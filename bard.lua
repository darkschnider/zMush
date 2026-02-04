require "util"
require "add_effect"
zEffects = require "effects"
require "do_announce"

-- Delete existing Bard trigger group before recreating
DeleteTriggerGroup("Bard LUA Trigs")

-- Delete existing Bard alias group before recreating
DeleteAliasGroup("Bard LUA Aliases")
local trigFlags = 33 -- Enabled | RegularExpression

local lastBardSong = ""

local bard_songs = {
    {key = "CHA", spell = "bario's bawdy ballad", display = "Bario's Bawdy Ballad (cha)", alias = "cha"},
    {key = "INT", spell = "apollo's adagio", display = "Apollo's Adagio (int)", alias = "int"},
    {key = "WIS", spell = "symphony of solomon", display = "Symphony of Solomon (wis)", alias = "wis"},
    {key = "STR", spell = "berserker's bravura", display = "Berserker's Bravura (str)", alias = "str"},
    {key = "DEX", spell = "aria of the eagles", display = "Aria of the Eagles (dex)", alias = "dex"},
    {key = "CON", spell = "vigorous concerto", display = "Vigorous Concerto (con)", alias = "con"},
    {key = "PSALM", spell = "psalm of healing", display = "Psalm of Healing (healing)", alias = "psalm"},
    {key = "SPR", spell = "claris' melody of mana", display = "Claris' Melody of Mana (spr)", alias = "spr"},
    {key = "HPR", spell = "lullaby of life", display = "Lullaby of Life (hpr)", alias = "hpr"},
    {key = "AC", spell = "chant of fortitude", display = "Chant of Fortitude (ac)", alias = "ac"},
    {key = "BRAVE", spell = "score of the steadfast", display = "Score of the Steadfast (bravery)", alias = "brave"},
    {key = "SPMAX", spell = "sonata of sorcery", display = "Sonata of Sorcery (spmax)", alias = "spmax"},
    {key = "FLIGHT", spell = "uplifting melody", display = "Uplifting Melody (flight)", alias = "flight"},
    {key = "MELEE", spell = "chant of the beast", display = "Chant of the Beast (+hits)", alias = "melee"}
}

local bard_guises = {
    {match="Heavenly Angel", announce_type="Angel"},
    {match="Mind Flayer", announce_type="Flayer"},
    {match="Halfling Scout", announce_type="Scout"},
    {match="Mighty Titan", announce_type="Titan"},
    {match="Repulsive Ogre", announce_type="Ogre"},
    {match="Noble Paladin", announce_type="Paladin"},
    {match="Cackling Skeleton", announce_type="Skeleton"}
}

local bard_songs_lookup = {}
local bard_visu_spell_name = ""
local bard_visu_id = ""

function castBardSpell(spell_key)
    local spell_name = bard_songs_lookup[spell_key]
    if spell_name ~= nil then
        lastBardSong = spell_key
        addEffectToCheck(lastBardSong)
        Execute("cast " .. spell_name .. " try very slow")
    else
        error("Unknown bard spell: " .. spell_key)
    end
end

function songSung()
    --print("Song sung: " .. lastBardSong)
    effect_on(lastBardSong)
    lastBardSong = ""
end

function castVisu(name, line, wildcards)
    bard_visu_spell_name = wildcards[1]
    --print("bard_visu_spell_name: " .. bard_visu_spell_name)
    local visu = sanitize(bard_visu_spell_name)
    bard_visu_id = "visu_" .. visu
    --print("bard_visu_id: " .. bard_visu_id)
    Execute("cast visualize act at " .. bard_visu_spell_name .. " try very slow")
end

function visuOn()
    --print("Visu on: " .. bard_visu_spell_name .. "[" .. bard_visu_id .. "]")
    if(zEffects:find(bard_visu_id) == nil) then
        zEffects:addNewEffect(bard_visu_id, "Visualize Act [".. bard_visu_spell_name .. "]", nil, 1, nil, nil, nil)
        addEffectToCheck(bard_visu_id)
    end

    effect_on(bard_visu_id)
    bard_visu_id = "" -- reset for next time
end

function bard_visu_off(name, line, wildcards)
    local spell_name = wildcards[1]
    --print("Visu off: " .. visu)
    local visu = "visu_" .. sanitize(spell_name)
    --print("Visu off: " .. spell_name .. "[" .. visu .. "]")
    effect_off(visu)
end

AddTriggerEx("luaBardVisuOff", "^Your (.*) visu spell is no longer affecting your songs\\.$", "", trigFlags, custom_colour.Custom6, 0, "", "", sendto.world, 100)
SetTriggerOption("luaBardVisuOff", "script", "bard_visu_off")
SetTriggerOption("luaBardVisuOff", "group", "Bard LUA Trigs")
AddTriggerEx("luaBardVisuOn", "^You weave new magic into your song\\.$", "visuOn()", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
SetTriggerOption("luaBardVisuOn", "group", "Bard LUA Trigs")
AddAlias("luaAliasBardVisu", "^/visu (.*)", "", aliasEnabledAndRegex,"castVisu")
SetAliasOption("luaAliasBardVisu", "group", "Bard LUA Aliases")
----
-- Know Your Audience (KYA) Example
----
-- You are done with the chant.
-- You utter the magic words 'raera yuouy nadna'
-- Xecthae's gender is: male
--        race:                   huecuva (undead)
--        money:                  0
--        armour class            310
--        weapon class:           162
--        Attacks/round:          11
--        Level relative to you:  same
--        The target is at about 87% health.
--        Targets natural stats are:
--         con: 678    int: 1394    dex: 886
--         str: 1117    wis: 648    siz: 59
--        resists the damage type psionic the most.
--        resists the damage type electric the least.
--        Xecthae is invulnerable to cold.
--        Xecthae is invulnerable to poison.
--        Xecthae is invulnerable to asphyxiation.
--        Xecthae is invulnerable to fire.
--        Xecthae is invulnerable to psionic.
--        Xecthae is immune to physical.
--        Xecthae is invulnerable to acid.
--        Xecthae is invulnerable to magical.
--        Xecthae is barely susceptible to electric.
-- Xecthae is Demonic.
local resist_map = {
    ["completely vulnerable"] = 1,
    ["very vulnerable"] = 2,
    ["vulnerable"] = 3,
    ["susceptible"] = 4,
    ["somewhat susceptible"] = 5,
    ["barely susceptible"] = 6,
    ["immune"] = 7,
    ["invulnerable"] = 8
}

local casting_kya = false
local kya_target = ""
local kya_target_resists = {}
local kya_announce_target = "other"

-- Global for the trigs
kya_stats = {
    ["resist_most"] = "",
    ["resist_least"] = "",
    ["health"] = 0,
    ["align"] = ""
}

----
-- KYA (Know Your Audience)
----
function kya_start(name, line, wildcards)
    kya_target = wildcards[1]
    --print("kya_target: " .. kya_target)
    Execute("cast know your audience at " .. kya_target)
    casting_kya = true
    SetTriggerOption("luaKyaHealth", "enabled", "y")
    SetTriggerOption("luaKyaResistMost", "enabled", "y")
    SetTriggerOption("luaKyaResistLeast", "enabled", "y")
    SetTriggerOption("luaKyaResists", "enabled", "y")
    SetTriggerOption("luaKyaDone", "enabled", "y")
end

function kya_done(name, line, wildcards)
    --print("kya_stats[\"align\"]: " .. kya_stats["align"])
    if (casting_kya or false) then
        kya_target = wildcards[1]
        kya_stats["align"] = wildcards[2]
        local options = {
            d = kya_announce_target,
            x = false,
            c = "blue"
        }
        do_announce(options, kya_target .. ": " .. kya_stats["health"] .. "% health, resists " .. kya_stats["resist_most"] .. " the MOST, " .. kya_stats["resist_least"] .. " the LEAST")
        local resist_message = ""
        --print ("kya_target_resists:")
        --tprint(kya_target_resists)

        for i, resist in pairs(kya_target_resists) do
            --print("Checking resist: " .. i .. " at ")
            --tprint(resist)
            local type = resist[1]
            local resist_amt = resist[2]
            if (i ~= nil) then
                if i == 1 then
                    resist_message =  "Resists: "
                end
                resist_message = resist_message .. type .. "[" .. resist_amt .. "]"
                if i < #kya_target_resists then
                    resist_message = resist_message .. ", "
                end
            end
        end
        if strlen(resist_message) then
            do_announce(options, resist_message)
        end
        kya_target_resists = {}
        casting_kya = false
        SetTriggerOption("luaKyaHealth", "enabled", "n")
        SetTriggerOption("luaKyaResistMost", "enabled", "n")
        SetTriggerOption("luaKyaResistLeast", "enabled", "n")
        SetTriggerOption("luaKyaResists", "enabled", "n")
        SetTriggerOption("luaKyaDone", "enabled", "n")
    end
end

function kya_add_resist(name, line, wildcards)
    if casting_kya then
        local resist_target = wildcards[1]
        local resist = wildcards[2]
        local resist_type = wildcards[3]
        --print("kya_add_resist: " .. resist_target .. " resists " .. resist_type .. " at " .. resist)
        local found_resist = nil
        for key, value in pairs(resist_map) do
            --print("Checking resist: " .. key .. " at " .. value)
            if key == resist then
                --print("kya_add_resist: " .. resist_target .. " resists " .. resist .. " at " .. value)
                found_resist = value
                break
            end
        end
        if found_resist ~= nil then
            --print("Adding resist: " .. resist .. " at " .. found_resist)
            table.insert(kya_target_resists, {resist_type, found_resist})
        else
            error("Unknown resist: " .. resist)
        end
    else
        error("Not casting kya")
    end
end

function bard_guise_on(guise_name)
    local guise_effect = zEffects:find('bardGuise')
    --tprint(guise_effect)
    for _, guise in ipairs(bard_guises) do
        if guise.match == guise_name and guise_effect then
            guise_effect._name = "Guise of the " .. guise.announce_type
            break
        end
    end
    effect_on('bardGuise')
end

----
-- Aliases and Triggers for Bard
----

-- KYA
AddAlias("luaKya", "/kya (.*)", "", aliasEnabledAndRegex, "kya_start")
SetAliasOption("luaKya", "group", "Bard LUA Aliases")
AddTriggerEx("luaKyaHealth", "^[\\w'\\s]+ The target is at about (\\d+)% health\\.$", "kya_stats[\"health\"] = %1", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
SetTriggerOption("luaKyaHealth", "enabled", "n")
SetTriggerOption("luaKyaHealth", "group", "Bard LUA Trigs")
AddTriggerEx("luaKyaResistMost", "^[\\w'\\s]+ resists the damage type (.*) the most\\.$", "kya_stats[\"resist_most\"] = \"%1\"", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
SetTriggerOption("luaKyaResistMost", "enabled", "n")
SetTriggerOption("luaKyaResistMost", "group", "Bard LUA Trigs")
AddTriggerEx("luaKyaResistLeast", "^[\\w'\\s]+ resists the damage type (.*) the least\\.$", "kya_stats[\"resist_least\"] = \"%1\"", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
SetTriggerOption("luaKyaResistLeast", "enabled", "n")
SetTriggerOption("luaKyaResistLeast", "group", "Bard LUA Trigs")
AddTriggerEx("luaKyaResists", "^([\\w'\\s]+) is (.*) to (\\w+)\\.$", "", trigFlags, custom_colour.Custom3, 0, "", "kya_add_resist", sendto.world, 100)
SetTriggerOption("luaKyaResists", "enabled", "n")
SetTriggerOption("luaKyaResists", "group", "Bard LUA Trigs")
AddTriggerEx("luaKyaDone", "^([\\w'\\s]+) is (Demonic|Very evil|Extremely evil|Evil|Neutral|Good|Angelic|Very good|Extremely good)\\.$", "", trigFlags, custom_colour.Custom3, 0, "", "kya_done", sendto.world, 100)
SetTriggerOption("luaKyaDone", "enabled", "n")
SetTriggerOption("luaKyaDone", "group", "Bard LUA Trigs")

-- Bard Songs
AddTriggerEx("luabard_songstart", "^You begin to sing, infusing your song with magic\\.$", "songSung()", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
SetTriggerOption("luabard_songstart", "group", "Bard LUA Trigs")

-- Setup all bard songs: lookup table, effects, triggers, and aliases
for _, song in ipairs(bard_songs) do
    -- Create lookup table entry
    bard_songs_lookup[song.key] = song.spell
    
    -- Register effect
    zEffects:addNewEffect(song.key, song.display, nil, 1, nil, nil, nil)
    
    -- Create trigger
    local trigger_name = "luaBard" .. song.key .. "Off"
    local trigger_pattern = "^Your " .. song.spell .. " spell is no longer affecting your songs\\.$"
    local trigger_script = "effect_off('" .. song.key .. "')"
    AddTriggerEx(trigger_name, trigger_pattern, trigger_script, trigFlags, custom_colour.Custom6, 0, "", "", sendto.script, 100)
    SetTriggerOption(trigger_name, "group", "Bard LUA Trigs")
    
    -- Create alias
    local alias_name = "luaAliasBard" .. song.key
    local alias_pattern = "^/" .. song.alias .. "$"
    local alias_script = "castBardSpell('" .. song.key .. "')"
    AddAlias(alias_name, alias_pattern, alias_script, aliasEnabledAndRegex, "")
    SetAliasOption(alias_name, "send_to", sendto.script)
    SetAliasOption(alias_name, "group", "Bard LUA Aliases")
end

-- Guises
zEffects:addNewEffect("bardGuise", "Guise of the Unknown", "guise", 1, nil, nil, nil)

AddTriggerEx("luaBardGuiseDown",
 "^You assume the shadowy guise of \\\"(Heavenly Angel|Mind Flayer|Halfling Scout|Mighty Titan|Repulsive Ogre|Noble Paladin|Cackling Skeleton)\\\"$",
 "bard_guise_on(\"%1\")", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
SetTriggerOption("luaBardGuiseDown", "group", "Bard LUA Trigs")

AddTriggerEx("luaBardGuiseOff",
 "^Your guise wears off\\.$",
 "effect_off('bardGuise')", trigFlags, custom_colour.Custom6, 0, "", "", sendto.script, 100)
SetTriggerOption("luaBardGuiseOff", "group", "Bard LUA Trigs")

AddAlias("luaAliasBardGuise", "^/guise (.*)$", "Execute(\"cast guise of the \" .. '%1')", aliasEnabledAndRegex, "")
SetAliasOption("luaAliasBardGuise", "group", "Bard LUA Aliases")
SetAliasOption("luaAliasBardGuise", "send_to", sendto.script)