require "util"
require "add_effect"
zEffects = require "effects"


zEffects:addNewGroup("guise", "Guise")
--zEffects:addNewEffect("angel_guise", "Angel Guise", "angel", 1, "guise", "You assume the shadowy guise of \\\"Heavenly Angel\\\"", "Your guise wears off.")
addNewSpellAndAlias("angel_guise", "Angel Guise", "angel", "/angel", aliasEnabled, nil, 1, "guise", "You assume the shadowy guise of \\\"Heavenly Angel\\\"", "Your guise wears off.")

lastBardSong = ""

-- function doBardSong(stat_name, spell_name)
--     lastBardSong = stat_name
--     SendNoEcho(spell_name)
-- end

-- function addNewBardSong(name, alias_command, stat_name, spell_name)
--     local alias_name = "luaAliasBard" .. name
--     local alreadyExists = GetAlias(alias_name)
--     if alreadyExists ~= eAliasNotFound then
--         DeleteAlias(alias_name)
--     end
--     AddAlias(alias_name, alias_command, "", alias_flag.Enabled, "doBardSong('" .. stat_name .. "', '" .. spell_name .. "')")
-- end

-- local bardSongs = {
--     ["bario's bawdy ballad"] = "CHA",
--     ["apollo's adagio"] = "INT",
--     ["symphony of solomon"] = "WIS",
--     ["berserker's bravura"] = "STR",
--     ["aria of the eagles"] = "DEX",
--     ["vigorous concerto"] = "CON",
--     ["visu"] = "VISU",
-- }

-- addNewBardSong("bard_cha", "/bcha", "CHA", "bario's bawdy ballad")
-- addNewBardSong("bard_int", "/bint", "INT", "apollo's adagio")
-- addNewBardSong("bard_wis", "/bwis", "WIS", "symphony of solomon")
-- addNewBardSong("bard_str", "/bstr", "STR", "berserker's bravura")
-- addNewBardSong("bard_dex", "/bdex", "DEX", "aria of the eagles")
-- addNewBardSong("bard_con", "/bcon", "CON", "vigorous concerto")

-- function bardSongDown(spell_name)
--     if spell_name == "visu" then
--         local visu_item = string.match(spell_name, "(.*) visu")
--         print("Visualize Act Off")
--     else
--         effect_off(bardSongs[spell_name])
--     end
-- end

--Your bario's bawdy ballad spell is no longer affecting your songs.

local trigFlags = 33 -- Enabled | RegularExpression
DeleteTrigger("luaBardSongStart")
AddTriggerEx("luaBardSongStart", "^You begin to sing, infusing your song with magic\\.$", "songSung()", trigFlags, custom_colour.5, "", "", sendto.script, 100)
AddTriggerEx("luaBardChaOff", "^Your bario's bawdy ballad spell is no longer affecting your songs\\.$", "effect_off('CHA')", trigFlags, custom_colour.5, "", "", sendto.script, 100)
AddTriggerEx("luaBardIntOff", "^Your apollo's adagio spell is no longer affecting your songs\\.$", "effect_off('INT')", trigFlags, custom_colour.5, "", "", sendto.script, 100)
AddTriggerEx("luaBardConOff", "^Your vigorous concerto spell is no longer affecting your songs\\.$", "effect_off('CON')", trigFlags, custom_colour.5, "", "", sendto.script, 100)
AddTriggerEx("luaBardWisOff", "^Your bario's bawdy ballad spell is no longer affecting your songs\\.$", "effect_off('WIS')", trigFlags, custom_colour.5, "", "", sendto.script, 100)
AddTriggerEx("luaBardDexOff", "^Your bario's bawdy ballad spell is no longer affecting your songs\\.$", "effect_off('DEX')", trigFlags, custom_colour.5, "", "", sendto.script, 100)

bard_visu = ""
AddTriggerEx("luaBardVisuOff", "^Your (.*) visu spell is no longer affecting your songs\\.$", "bard_visu = %1", trigFlags, custom_colour.5, "", "", sendto.script, 100)
SetTriggerOption("luaBardVisuOff", "script", "bard_visu_off()")

function songSung()
    if string.contains(lastBardSong, "VISU") then
        effect_on("VISU")
    else
        effect_on(lastBardSong)
    end
end

function bard_visu_off()
    effect_off(bard_visu)
end
