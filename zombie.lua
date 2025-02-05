package.path = package.path .. ";C:\\MUSH Scripts\\?.lua"

-- Globals!
party_members=0
party_aide=""
party_tank=""
party_commander=""

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
require "effects"
require "effect_definitions"

require "bard"
require "healer"

function test_alias(name, line, wildcards)
    require "tprint"
    Note ("Wildcards ...")
    tprint(wildcards)
end	-- of test_alias

_currentRun = {}
