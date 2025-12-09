zEffects = require "effects"
require("add_effect")

-- Track ranger skill progress
ranger_progress = {
    axe_fighting_techniques = {current = 0, last = 0},
    sword_fighting_techniques = {current = 0, last = 0},
    archery = {current = 0, last = 0},
    wilderness_survival = {current = 0, last = 0},
    beastmastery = {current = 0, last = 0}
}

-- Progress mapping
local progress_map = {
    ["in a long time"] = 0,
    ["in a very long while"] = 1,
    ["in quite a long while"] = 2,
    ["in a long while"] = 3,
    ["in a while"] = 4,
    ["in a little while"] = 5,
    ["in a short while"] = 6,
    ["soon"] = 7,
    ["very soon"] = 8,
    ["extremely soon"] = 9
}

function ranger_path_progress(name, line, wildcards)
    local skill = wildcards[1]
    local time_str = wildcards[2]
    
    -- Get progress value
    local progress = progress_map[time_str] or 0
    
    -- Convert skill name to key
    local skill_key = string.gsub(skill, " ", "_")
    
    -- Initialize if needed
    if not ranger_progress[skill_key] then
        ranger_progress[skill_key] = {current = 0, last = 0}
    end
    
    -- Calculate delta
    local last = ranger_progress[skill_key].last
    local delta = progress - last
    
    -- Handle wrap-around
    while delta < 0 do
        delta = delta + 10
    end
    
    -- Update values
    ranger_progress[skill_key].current = progress
    ranger_progress[skill_key].last = progress
    
    -- Build output message
    ColourTell("#C5C5C5", "#000000", line .." ")
    ColourTell("green", "black", "[" .. progress .. " of 10]")
    if delta > 0 then
        ColourTell("lightgreen", "black", " {+" .. delta .. "}")
    end
    Note("")
end

-- Add trigger
local trigFlags = 33 -- Enabled | RegularExpression
DeleteTrigger("luaRangerProgress")
AddTriggerEx(
    "luaRangerProgress",
    "^You will advance in (axe fighting techniques|sword fighting techniques|archery|wilderness survival|beastmastery) (.+)\\.$",
    "",
    trigFlags,
    -1,
    0,
    "",
    "ranger_path_progress",
    sendto.script,
    100
)
SetTriggerOption("luaRangerProgress", "omit_from_output", "y")
SetTriggerOption("luaRangerProgress", "group", "Ranger LUA Triggers")

-- Weapon skill level triggers
local weapon_skills = {
    {pattern = "^You are completely clueless about ([a-z, ]+) which makes you a danger to others\\.$", level = 1},
    {pattern = "^You have started learning about ([a-z ]+)\\.$", level = 2},
    {pattern = "^You have a little knowledge in ([a-z ]+)\\.$", level = 3},
    {pattern = "^You have learned a few basic facts about ([a-z ]+)\\.$", level = 4},
    {pattern = "^You have newbie skills in ([a-z ]+)\\.$", level = 5},
    {pattern = "^You have novice skills in ([a-z ]+)\\.$", level = 6},
    {pattern = "^You are an apprentice in ([a-z ]+)\\.$", level = 7},
    {pattern = "^You are a skilled apprentice in ([a-z ]+)\\.$", level = 8},
    {pattern = "^You are very talented in ([a-z ]+)\\.$", level = 9},
    {pattern = "^You are unusually talented in ([a-z ]+)\\.$", level = 10},
    {pattern = "^You have honed your skills in ([a-z ]+)\\.$", level = 11},
    {pattern = "^You are highly skilled in ([a-z ]+)\\.$", level = 12},
    {pattern = "^You have exceptional skills in ([a-z ]+)\\.$", level = 13},
    {pattern = "^Your talents in ([a-z ]+) are well known amongst the rangers\\.$", level = 14},
    {pattern = "^Your talents in ([a-z ]+) are known by many\\.$", level = 15},
    {pattern = "^Your talents in ([a-z ]+) are known throughout the world\\.$", level = 16},
    {pattern = "^You are often feared for your skill in ([a-z ]+)\\.$", level = 17},
    {pattern = "^You are a master in ([a-z ]+) and your enemies tremble at your name\\.$", level = 18},
    {pattern = "^You are a grand master in ([a-z ]+) and everyone fears your awesome skills\\.$", level = 19},
    {pattern = "^You are feared and revered throughout the world for your legendary skills in ([a-z ]+)\\.$", level = 20}
}

function ranger_mastery_print(name, line, wildcards)
    local level = GetTriggerOption(name, "user")
    ColourTell("#C5C5C5", "#000000", line .." ")
    ColourTell("green", "black", "[" .. level .. " of 20]")
    Note("")
end

-- Create triggers for each weapon skill level
local trigFlags = 33 -- Enabled | RegularExpression
for i, skill in ipairs(weapon_skills) do
    local trigger_name = "luaRangerWeapon" .. i
    DeleteTrigger(trigger_name)
    
    -- Create the trigger
    AddTriggerEx(
        trigger_name,
        skill.pattern,
        "",
        trigFlags,
        -1,
        0,
        "",
        "",
        sendto.script,
        100
    )
    
    -- Set the script function with the level parameter
    SetTriggerOption(trigger_name, "script", "ranger_mastery_print")
    SetTriggerOption(trigger_name, "omit_from_output", "y")
    
    -- Store the level in a way the trigger can access it
    SetTriggerOption(trigger_name, "user", tostring(skill.level))
    SetTriggerOption(trigger_name, "group", "Ranger LUA Triggers")
end

-- Wilderness survival skill level triggers
local wilderness_skills = {
    {pattern = "You couldn\\'t light a fire with a flamethrower\\.", level = 1},
    {pattern = "Bunny rabbits dance in front of you for kicks\\.", level = 2},
    {pattern = "People mistake your campsites for rubbish heaps\\.", level = 3},
    {pattern = "You once caught a lame baby mouse\\.", level = 4},
    {pattern = "Your poison ivy itches amuse people\\.", level = 5},
    {pattern = "You are sometimes found by search parties\\.", level = 6},
    {pattern = "You once had to live off rats to survive\\.", level = 7},
    {pattern = "You sometimes have to sleep under trees\\.", level = 8},
    {pattern = "You probably won\\'t poison yourself in the wilderness\\.", level = 9},
    {pattern = "You know where to find food\\.", level = 10},
    {pattern = "You construct snug hideaways\\.", level = 11},
    {pattern = "Your campfires burn brightly\\.", level = 12},
    {pattern = "You know enough to survive in the wilderness\\.", level = 13},
    {pattern = "You can hunt silently and well\\.", level = 14},
    {pattern = "People call on you when someone is lost\\.", level = 15},
    {pattern = "You can live in the wilderness with ease\\.", level = 16},
    {pattern = "Your campfires are skillfully constructed\\.", level = 17},
    {pattern = "You have seen places no-one else will ever see\\.", level = 18},
    {pattern = "You never get lost\\.", level = 19},
    {pattern = "You are a master of wilderness survival\\.", level = 20}
}

-- Create triggers for each wilderness survival skill level
for i, wskill in ipairs(wilderness_skills) do
    local wilderness_trigger_name = "luaRangerWilderness" .. i
    DeleteTrigger(wilderness_trigger_name)
    
    -- Create the trigger with exact text match
    AddTriggerEx(
        wilderness_trigger_name,
        "^" .. wskill.pattern .. "$",
        "",
        trigFlags,
        -1,
        0,
        "",
        "",
        sendto.script,
        100
    )
    
    -- Set the script function
    SetTriggerOption(wilderness_trigger_name, "script", "ranger_mastery_print")
    SetTriggerOption(wilderness_trigger_name, "omit_from_output", "y")
    
    -- Store the level in the trigger's user field
    SetTriggerOption(wilderness_trigger_name, "user", tostring(wskill.level))
    SetTriggerOption(wilderness_trigger_name, "group", "Ranger LUA Triggers")
end

-- Beastmastery skill level triggers
local beastmastery_skills = {
    {pattern = "Little girls say \\'You, a beastmaster\\?\\' and laugh\\.", level = 1},
    {pattern = "Your shoes are urinated on by hamsters\\.", level = 2},
    {pattern = "You have trouble controlling even your pet fishes\\.", level = 3},
    {pattern = "You have started your training at becoming a beastmaster\\.", level = 4},
    {pattern = "Animals have been known to mistake you for someone they know\\.", level = 5},
    {pattern = "You are occasionally addressed by beasts\\.", level = 6},
    {pattern = "You are sometimes helped by beasts if you ask very nicely\\.", level = 7},
    {pattern = "Animals sometimes enjoy your company\\.", level = 8},
    {pattern = "Animals find you interesting\\.", level = 9},
    {pattern = "You never get bitten by dogs anymore\\.", level = 10},
    {pattern = "Horses tell you their personal problems\\.", level = 11},
    {pattern = "Other rangers look to you for advice in taking care of beasts\\.", level = 12},
    {pattern = "You are approached by owls for advice\\.", level = 13},
    {pattern = "You can read the tracks of wild animals like a good book\\.", level = 14},
    {pattern = "You are sometimes asked to babysit for bears\\.", level = 15},
    {pattern = "When you call, animals answer you\\.", level = 16},
    {pattern = "You are one of the elite beastmasters\\.", level = 17},
    {pattern = "The fame of your knowledge has spread far\\.", level = 18},
    {pattern = "Even the mightiest of beasts acknowledge your beastmastery skills\\.", level = 19},
    {pattern = "You are one with the animal kingdom\\.", level = 20}
}

-- Create triggers for each beastmastery skill level
for i, bm_skill in ipairs(beastmastery_skills) do
    local bm_trigger_name = "luaRangerBeastmastery" .. i
    DeleteTrigger(bm_trigger_name)
    
    -- Create the trigger with exact text match
    AddTriggerEx(
        bm_trigger_name,
        "^" .. bm_skill.pattern .. "$",
        "",
        trigFlags,
        -1,
        0,
        "",
        "",
        sendto.script,
        100
    )
    
    -- Set the script function
    SetTriggerOption(bm_trigger_name, "script", "ranger_mastery_print")
    SetTriggerOption(bm_trigger_name, "omit_from_output", "y")
    
    -- Store the level in the trigger's user field
    SetTriggerOption(bm_trigger_name, "user", tostring(bm_skill.level))
    SetTriggerOption(bm_trigger_name, "group", "Ranger LUA Triggers")
end

addNewSpellAndAlias("eyes_marksman", "Eyes of the Marksman", "eom", "/eom", aliasEnabledAndRegex, "", 1, nil,
 "Your eyes flash in silky colours\\.",
 "You feel a pinch in your eyes\\.")
addEffectToCheck("eyes_marksman")

addNewSpellAndAlias("spirit_of_nature", "Spirit of Nature", "son", "/son", aliasEnabledAndRegex, "", 1, nil,
 "You feel {strong|nimble|tough} as {a|an} {bear|eagle|drake} as the spirit of the {forest|mountain|desert} strenghtens you!",
 "You suddenly feel cold as the presence leaves your body\\.")
addEffectToCheck("spirit_of_nature")