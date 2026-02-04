package.path = package.path .. ";C:\\zMush\\zMush\\?.lua;C:\\zMush\\zMush\\runs\\?.lua"

require "util" -- Needs to be first!!
require "align"
require "math"
require "tprint"
require "var"
require "getopts"
require "do_announce"
require "run"
zEffects = require "effects"
require "effect_definitions"
require "attack"

require "bard"
require "healer"
require "abjurer"
require "trader"
require "goblin"
require "death_knight"
require "necromancer"
require "ranger"

-- Globals!
party_members=0
party_aide=""
party_tank="neverwhere"
party_commander="neverwhere"

SetVariable("player_name", "neverwhere")
SetVariable("party_tank", party_tank)
SetVariable("party_commander", party_commander)
SetVariable("target", "")
SetVariable("healing", party_tank)

function setHealTarget(name)
    SetVariable("healing", name)
    ColourNote("Grey", "Orange", "Healing target set to: " .. name)
end
DeleteAlias("luaSetHealingTarget")
AddAlias("luaSetHealingTarget", "^/ht(.*)$", "setHealTarget(trim(\"%1\") == \"\" and \"neverwhere\" or trim(\"%1\"))", alias_flag.Enabled + alias_flag.RegularExpression, "")
SetAliasOption("luaSetHealingTarget", "send_to", sendto.script)

function setTank(name)
    party_tank = name
    SetVariable("party_tank", party_tank)
    ColourNote("Grey", "Orange", "Tank set to: " .. name)
    setHealTarget(name)
end

function setCommander(name)
    party_commander = name
    SetVariable("party_commander", party_commander)
    ColourNote("Grey", "Orange", "Commander set to: " .. name)
end

function setTankAndCommander(name, line, wildcards)
    local lower_name = string.lower(wildcards[1])
    setTank(lower_name)
    setCommander(lower_name)
end

DeleteTrigger("luaAutoTank")
AddTriggerEx("luaAutoTank", "^You are joined to the party of (\\w+)\\.$", "", 33, custom_colour.Custom3, 0, "", "setTankAndCommander", sendto.script, 100)

function test_alias(name, line, wildcards)
    require "tprint"
    Note ("Wildcards ...")
    tprint(wildcards)
end	-- of test_alias

_currentRun = {}
local trigFlags = 33 -- Enabled | RegularExpression
status_prompt = 0

-- Helper function to interpolate color from green (100% HP) to red (0% HP)
function hpColor(current, max)
    local percentage = current / max
    if percentage > 1 then percentage = 1 end
    if percentage < 0 then percentage = 0 end
    
    local r = math.floor(255 * (1 - percentage))
    local g = math.floor(255 * percentage)
    
    return string.format("#%02X%02X00", r, g)
end

luaPrompt = {
    ["p_hp"] = 0,
    ["p_maxhp"] = 0,
    ["p_sp"] = 0,
    ["p_maxsp"] = 0,
    ["p_exp"] = 0,
    ["p_cash"] = 0,
    ["p_expl"] = 0,
    ["p_wgt"] = 0,
    ["p_last_exp"] = 0,
    ["p_scan"] = 0,
    ["p_align"] = 0,
    ["p_party"] = 0
}


function updatePrompt(name, line, wildcards)
    --InfoClear()
    --Note("Updating prompt...")
    --tprint(wildcards)
    luaPrompt["p_hp"] = wildcards[1]
    luaPrompt["p_maxhp"] = wildcards[2]
    luaPrompt["p_sp"] = wildcards[3]
    luaPrompt["p_maxsp"] = wildcards[4]
    luaPrompt["p_exp"] = wildcards[5]
    luaPrompt["p_cash"] = wildcards[6]
    local new_expl = wildcards[7] - luaPrompt["p_expl"]
    if new_expl > 0 or false then
        
    end
    luaPrompt["p_expl"] = wildcards[7]
    luaPrompt["p_wgt"] = wildcards[8]
    luaPrompt["p_last_exp"] = wildcards[9]
    luaPrompt["p_scan"] = wildcards[10]
    luaPrompt["p_align"] = wildcards[11]
    luaPrompt["p_party"] = wildcards[12]

    --tprint(luaPrompt)
    local scan_color = "#FFFFFF"
    local xp_change = ""
    if tonumber(luaPrompt["p_last_exp"]) >= 0 then
        xp_change = "(+" .. luaPrompt["p_last_exp"] .. ")"
    elseif tonumber(luaPrompt["p_last_exp"]) < 0 then
        xp_change = "(" .. luaPrompt["p_last_exp"] .. ")"
    end
    --Info(luaPrompt["p_hp"] .. "/" .. luaPrompt["p_maxhp"] .. " HP, " .. luaPrompt["p_sp"] .. "/" .. luaPrompt["p_maxsp"] .. " SP, " .. luaPrompt["p_exp"] .. " EXP " .. xp_change .. ", " .. luaPrompt["p_cash"] .. " Cash")
    Simulate(luaPrompt["p_scan"])
    local hp_color = hpColor(tonumber(luaPrompt["p_hp"]), tonumber(luaPrompt["p_maxhp"]))
    ColourTell(hp_color, "#000000", luaPrompt["p_hp"])
    ColourTell("#C5C5C5", "#000000", "/" )
    ColourTell("#FFFFFF", "#000000", luaPrompt["p_maxhp"])
    ColourTell("#C5C5C5", "#000000", " HP, ")
    local sp_color = hpColor(tonumber(luaPrompt["p_sp"]), tonumber(luaPrompt["p_maxsp"]))
    ColourTell(sp_color, "#000000", luaPrompt["p_sp"])
    ColourTell("#C5C5C5", "#000000", "/")
    ColourTell("#FFFFFF", "#000000", luaPrompt["p_maxsp"])
    ColourTell("#C5C5C5", "#000000", " SP")
    Note("")
    ColourTell("#C5C5C5", "#000000", luaPrompt["p_exp"] .. " EXP " .. xp_change .. ", " .. luaPrompt["p_cash"] .. " Gold" .."> ")
end

DeleteTrigger("luaPromptMatch")
AddTriggerEx("luaPromptMatch", "^p: (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) ([-\\d]+) \"([^\"]*)\" \"([^\"]*)\" (.*)$", "", trigFlags, custom_colour.Custom3, 0, "", "updatePrompt", sendto.world, 100)
SetTriggerOption("luaPromptMatch", "omit_from_output", true)

function doLoot(name, line, wildcards)
    servant = GetVariable("use_servant")
    if servant == "1" then
        Send("scom loot")
    else
        loot_to_bag = using_bag_of_holding or false
        have_carriage = GetVariable("have_carriage") or false
        isAbjurer = GetVariable("is_abjurer") or false
        --Send("loot")
        if loot_to_bag then
            Send("put noeq in bag")
        end
        if have_carriage == true then
            Execute("take corpse;put corpse in carriage")
        end
        if isAbjurer == true then
            on_enemy_killed_abjurer()
        end
    end
end

function on_connected()

end

function on_save()

end