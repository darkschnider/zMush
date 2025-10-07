package.path = package.path .. ";C:\\zMush\\zMush\\?.lua;C:\\zMush\\zMush\\runs\\?.lua"

-- Globals!
party_members=0
party_aide=""
party_tank="neverwhere"
party_commander="neverwhere"

function setTank(name)
    party_tank = name
    ColourNote("Grey", "Orange", "Tank set to: " .. name)
end

function setCommander(name)
    party_commander = name
    ColourNote("Grey", "Orange", "Commander set to: " .. name)
end

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

require "bard"
require "healer"
require "abjurer"
require "trader"
require "goblin"
require "death_knight"
require "necromancer"

function test_alias(name, line, wildcards)
    require "tprint"
    Note ("Wildcards ...")
    tprint(wildcards)
end	-- of test_alias

_currentRun = {}
local trigFlags = 33 -- Enabled | RegularExpression
status_prompt = 0
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

end

--DeleteTrigger("luaPromptMatch")
--AddTriggerEx("luaPromptMatch", "^p: (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) \"([^\"]*)\" \"([^\"]*)\" (.*)$", "", trigFlags, custom_colour.Custom3, 0, "", "updatePrompt", sendto.world, 100)

--/def -Fp5 -agL -mregexp -t'^p: (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) (-?\\d+) "([^"]*)" "([^"]*)" (.*)$' update_prompt = \
--  /set status_prompt=1%; \
--  /set p_hp=%{P1}%; \
--  /set p_maxhp=%{P2}%; \
--  /set p_sp=%{P3}%; \
--  /set p_maxsp=%{P4}%; \
--  /set p_exp=%{P5}%; \
--  /set p_cash=%{P6}%; \
--  /let _rooms=$[{P7} - p_expl]%; \
--  /if (_rooms) \
--    /say -- Found %{_rooms} New Room$[_rooms == 1 ? '' : 's']%; \
--  /endif%; \
--  /set p_expl=%{P7}%; \
--  /set p_wgt=%{P8}%; \
--  /set p_last_exp=%{P9}%; \
--  /set p_scan=%{P10}%; \
--  /set p_align=$[align({P11})]%; \
--  /set p_party=%{P12}%; \
--  /if (regmatch('^([A-Za-z\' -]+) is in (good shape)$$', p_scan)) \
--    /update_target_scan -t'$(/escape ' %{P1})' -s${scan_good_shape} -d'$(/escape ' $[toupper({P2})])'%; \
--  /elseif (regmatch('^([A-Za-z\' -]+) is (slightly hurt)$$', p_scan)) \
--    /update_target_scan -t'$(/escape ' %{P1})' -s${scan_slightly_hurt} -d'$(/escape ' $[toupper({P2})])'%; \
--  /elseif (regmatch('^([A-Za-z\' -]+) is (moderately hurt)$$', p_scan)) \
--    /update_target_scan -t'$(/escape ' %{P1})' -s${scan_moderately_hurt} -d'$(/escape ' $[toupper({P2})])'%; \
--  /elseif (regmatch('^([A-Za-z\' -]+) is (not in a good shape)$$', p_scan)) \
--    /update_target_scan -t'$(/escape ' %{P1})' -s${scan_not_in_a_good_shape} -d'$(/escape ' $[toupper({P2})])'%; \
--  /elseif (regmatch('^([A-Za-z\' -]+) is in (bad shape)$$', p_scan)) \
--    /update_target_scan -t'$(/escape ' %{P1})' -s${scan_bad_shape} -d'$(/escape ' $[toupper({P2})])'%; \
--  /elseif (regmatch('^([A-Za-z\' -]+) is in (very bad shape)$$', p_scan)) \
--    /update_target_scan -t'$(/escape ' %{P1})' -s${scan_very_bad_shape} -d'$(/escape ' $[toupper({P2})])'%; \
--  /elseif (regmatch('^([A-Za-z\' -]+) is (almost DEAD)$$', p_scan)) \
--    /update_target_scan -t'$(/escape ' %{P1})' -s${scan_almost_dead} -d'$(/escape ' $[toupper({P2})])'%; \
--  /elseif (regmatch('^([A-Za-z\' -]+) is (DEAD MEAT)!$$', p_scan)) \
--    /update_target_scan -t'$(/escape ' %{P1})' -s${scan_dead_meat} -d'$(/escape ' $[toupper({P2})])'%; \
--  /endif%; \
--  /if (!strlen(aide) | !is_me(aide)) \
--    /if (regmatch('^@?<(\\d*)>$$', p_party)) \
--      /set party_members=$[strlen({P1})]%; \
--    /else \
--      /set party_members=0%; \
--    /endif%; \
--    /if (party_members < 2) \
--      /test tank := me()%; \
--    /endif%; \
--  /endif%; \
--  @update_status

function doLoot(name, line, wildcards)

end