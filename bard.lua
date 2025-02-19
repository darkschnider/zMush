require "util"
require "add_effect"
zEffects = require "effects"


zEffects:addNewGroup("guise", "Guise")
addNewSpellAndAlias("angel_guise", "Guise of the Angel", "angel", "/angel", aliasEnabled, nil, 1, "guise", "You assume the shadowy guise of \\\"Heavenly Angel\\\"", "Your guise wears off.")

lastBardSong = ""

local bard_songs = {
    ["CHA"] = "bario's bawdy ballad",
    ["INT"] = "apollo's adagio",
    ["WIS"] = "symphony of solomon",
    ["STR"] = "berserker's bravura",
    ["DEX"] = "aria of the eagles",
    ["CON"] = "vigorous concerto",
    ["PSALM"] = "psalm of healing"
}

--zEffects:addNewEffect(key, spell_name, short_name, layers, groups, upMessage, downMessage)
zEffects:addNewEffect("CHA", "Bario's Bawdy Ballad", nil, 1, nil, nil, nil)
zEffects:addNewEffect("INT", "Apollo's Adagio", nil, 1, nil, nil, nil)
zEffects:addNewEffect("CON", "Vigorous Concerto", nil, 1, nil, nil, nil)
zEffects:addNewEffect("WIS", "Symphony of Solomon", nil, 1, nil, nil, nil)
zEffects:addNewEffect("DEX", "Aria of the Eagles", nil, 1, nil, nil, nil)
zEffects:addNewEffect("STR", "Berserker's Bravura", nil, 1, nil, nil, nil)
zEffects:addNewEffect("PSALM", "Psalm of Healing", nil, 1, nil, nil, nil)

bard_visu_id = ""
bard_visu_spell_name = ""

function castBardSpell(spell_name)
    local key = findTableKeyByValue(bard_songs, spell_name)
    if key ~= nil then
        lastBardSong = spell_name
        addEffectToCheck(lastBardSong)
        Execute("cast " .. bard_songs[key] .. " try very slow")
    else
        error("Unknown bard spell: " .. spell_name)
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
    visu = replace("'", "", replace(" ", "_", bard_visu_spell_name))
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
    bard_visu_id = ""
end

function bard_visu_off(name, line, wildcards)
    local spell_name = wildcards[1]
    --print("Visu off: " .. visu)
    visu = "visu_" .. replace("'", "", replace(" ", "_", spell_name))
    --print("Visu off: " .. spell_name .. "[" .. visu .. "]")
    effect_off(visu)
end

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
--#if (@kya.12 = "very vulnerable") {kya.2 = @kya.2" COLD"} {}
--#if (@kya.12 = "vulnerable") {kya.3 = @kya.3" COLD"} {}
--#if (@kya.12 = "susceptible") {kya.4 = @kya.4" COLD"} {}
--#if (@kya.12 = "somewhat susceptible") {kya.5 = @kya.5" COLD"} {}
--#if (@kya.12 = "barely susceptible") {kya.6 = @kya.6" COLD"} {}
--#if (@kya.12 = "immune") {kya.7 = @kya.7" COLD"} {}
--#if (@kya.12 = "invulnerable") {kya.8 = @kya.8" COLD"} {}

local trigFlags = 33 -- Enabled | RegularExpression
casting_kya = false
kya_stats = {
    ["resist_most"] = "",
    ["resist_least"] = "",
    ["health"] = 0,
    ["align"] = ""
}
kya_target = ""
kya_target_resists = {}
kya_announce_target = "other"

function kya_start(name, line, wildcards)
    kya_target = wildcards[1]
    --print("kya_target: " .. kya_target)
    Execute("cast know your audience at " .. kya_target)
    casting_kya = true
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
        --trimmed = rTrimChars(resist_message, ", ")
        do_announce(options, resist_message)
        kya_target_resists = {}
        casting_kya = false
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

DeleteAlias("luaKya")
AddAlias("luaKya", "/kya (.*)", "", aliasEnabledAndRegex, "kya_start")
--SetAliasOption("luaKya", "send_to", sendto.script)

DeleteTrigger("luaKyaHealth")
AddTriggerEx("luaKyaHealth", "^\\s+ The target is at about (\\d+)% health\\.$", "kya_stats[\"health\"] = %1", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
DeleteTrigger("luaKyaResistMost")
AddTriggerEx("luaKyaResistMost", "^\\s+ resists the damage type (.*) the most\\.$", "kya_stats[\"resist_most\"] = \"%1\"", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
DeleteTrigger("luaKyaResistLeast")
AddTriggerEx("luaKyaResistLeast", "^\\s+ resists the damage type (.*) the least\\.$", "kya_stats[\"resist_least\"] = \"%1\"", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
DeleteTrigger("luaKyaResists")
AddTriggerEx("luaKyaResists", "^\\s+ ([\\w']+) is (.*) to (\\w+)\\.$", "", trigFlags, custom_colour.Custom3, 0, "", "kya_add_resist", sendto.world, 100)
DeleteTrigger("luaKyaDone")
AddTriggerEx("luaKyaDone", "^([\\w']+) is (Demonic|Evil|Good|Angelic|Very Good|Extremely Good)\\.$", "", trigFlags, custom_colour.Custom3, 0, "", "kya_done", sendto.world, 100)

DeleteTrigger("luabard_songstart")
DeleteTrigger("luaBardChaOff")
DeleteTrigger("luaBardIntOff")
DeleteTrigger("luaBardConOff")
DeleteTrigger("luaBardWisOff")
DeleteTrigger("luaBardDexOff")
DeleteTrigger("luaBardStrOff")
DeleteTrigger("luaBardPsalmOff")

AddTriggerEx("luabard_songstart", "^You begin to sing, infusing your song with magic\\.$", "songSung()", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
AddTriggerEx("luaBardChaOff", "^Your bario's bawdy ballad spell is no longer affecting your songs\\.$", "effect_off('CHA')", trigFlags, custom_colour.Custom6, 0, "", "", sendto.script, 100)
AddTriggerEx("luaBardIntOff", "^Your apollo's adagio spell is no longer affecting your songs\\.$", "effect_off('INT')", trigFlags, custom_colour.Custom6, 0, "", "", sendto.script, 100)
AddTriggerEx("luaBardConOff", "^Your vigorous concerto spell is no longer affecting your songs\\.$", "effect_off('CON')", trigFlags, custom_colour.Custom6, 0, "", "", sendto.script, 100)
AddTriggerEx("luaBardWisOff", "^Your symphony of solomon spell is no longer affecting your songs\\.$", "effect_off('WIS')", trigFlags, custom_colour.Custom6, 0, "", "", sendto.script, 100)
AddTriggerEx("luaBardDexOff", "^Your aria of the eagles spell is no longer affecting your songs\\.$", "effect_off('DEX')", trigFlags, custom_colour.Custom6, 0, "", "", sendto.script, 100)
AddTriggerEx("luaBardStrOff", "^Your berserker's bravura spell is no longer affecting your songs\\.$", "effect_off('STR')", trigFlags, custom_colour.Custom6, 0, "", "", sendto.script, 100)
AddTriggerEx("luaBardPsalmOff", "^Your psalm of healing spell is no longer affecting your songs\\.$", "effect_off('PSALM')", trigFlags, custom_colour.Custom6, 0, "", "", sendto.script, 100)

DeleteTrigger("luaBardVisuOff")
AddTriggerEx("luaBardVisuOff", "^Your (.*) visu spell is no longer affecting your songs\\.$", "", trigFlags, custom_colour.Custom6, 0, "", "", sendto.world, 100)
SetTriggerOption("luaBardVisuOff", "script", "bard_visu_off")
DeleteTrigger("luaBardVisuOn")
AddTriggerEx("luaBardVisuOn", "^You weave new magic into your song\\.$", "visuOn()", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
DeleteAlias("luaAliasBardVisu")
AddAlias("luaAliasBardVisu", "/visu (.*)", "", aliasEnabledAndRegex,"castVisu")

-- Add Bard spell casting alias
DeleteAlias("luaAliasBardCast")
AddAlias("luaAliasBardCha", "/cha", "castBardSpell('CHA')", aliasEnabled,"")
AddAlias("luaAliasBardInt", "/int", "castBardSpell('INT')", aliasEnabled,"")
AddAlias("luaAliasBardCon", "/con", "castBardSpell('CON')", aliasEnabled,"")
AddAlias("luaAliasBardWis", "/wis", "castBardSpell('WIS')", aliasEnabled,"")
AddAlias("luaAliasBardStr", "/str", "castBardSpell('STR')", aliasEnabled,"")
AddAlias("luaAliasBardDex", "/dex", "castBardSpell('DEX')", aliasEnabled,"")
AddAlias("luaAliasBardPsalm", "/psalm", "castBardSpell('PSALM')", aliasEnabled,"")
SetAliasOption("luaAliasBardCha", "send_to", sendto.script)
SetAliasOption("luaAliasBardInt", "send_to", sendto.script)
SetAliasOption("luaAliasBardCon", "send_to", sendto.script)
SetAliasOption("luaAliasBardWis", "send_to", sendto.script)
SetAliasOption("luaAliasBardStr", "send_to", sendto.script)
SetAliasOption("luaAliasBardDex", "send_to", sendto.script)
SetAliasOption("luaAliasBardPsalm", "send_to", sendto.script)
