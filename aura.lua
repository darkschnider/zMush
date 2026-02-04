----
-- AURA
----

zEffects = require("effects")
require("util")

-- Configuration variables
-- Global variable to accumulate multi-line aura detection output
aura_detection_line = ""
last_aura_effects = ""

----
-- Parse aura detection output and return a list of active effect keys
--
-- @param text The text from aura detection output
-- @return table of effect keys (short names)
----
function parse_aura_effects(text)
    if not text or text == "" then
        return {}
    end
    
    local effect_keys = {}
    
    -- Replace " and " with ", " and trim
    local effects_str = trim(text:gsub(" and ", ", "))
    
    -- Remove trailing period
    if effects_str:sub(-1) == "." then
        effects_str = effects_str:sub(1, -2)
    end
    
    -- Parse effects list
    for effect_str in effects_str:gmatch("[^,]+") do
        effect_str = trim(effect_str)
        local count = 1
        local effect_name = effect_str
        
        -- Check if it starts with "Two"
        if effect_str:match("^Two ") then
            count = 2
            effect_name = effect_str:sub(5)  -- Remove "Two "
            
            -- Special case for "Shields of protection"
            if effect_name == "Shields of protection" then
                effect_name = "Shield of protection"
            else
                -- Remove plural 's'
                effect_name = effect_name:sub(1, -2)
            end
        end
        
        -- Sanitize the effect name to get the key
        local effect_key = sanitize(effect_name)
        
        -- Look up the short name from zEffects
        local effect = zEffects:find(effect_key)
        
        if effect then
            local short_name = effect:get_short_name()
            if short_name and short_name ~= "" then
                -- Add to list (count times if multiple)
                table.insert(effect_keys, count == 2 and "Two " .. short_name or short_name)
            else
                -- Fallback to key if no short name found
                table.insert(effect_keys, count == 2 and "Two " .. effect_key or effect_key)
            end
        else
            -- Effect not found, use the key
            table.insert(effect_keys, count == 2 and "Two " .. effect_key or effect_key)
        end
    end

    local up = table.concat(effect_keys, ", ")
    last_aura_effects = up
    --Note("Online effects: " .. up)
      
    aura_effects_display(last_aura_effects)
end

----
-- Check effects from aura_effects_list and display their status
----
function aura_effects_display(text, location)
    local options = {
        d = location or "default",
        x = false,
        c = "green"
    }
    
    do_announce(options, (GetVariable("aura_target") or GetVariable("healing")) .. " has the above effects online: " .. text)
end

-- Alias for aura_effects_display
function adl()
    aura_effects_display(last_aura_effects)
end

-- Alias for aura_effects_party
function adl_p()
    aura_effects_display(last_aura_effects, "party")
end

----
-- Triggers for aura detection
----

-- Delete existing Aura trigger group before recreating
DeleteTriggerGroup("Aura LUA Triggers")

-- Trigger for when no spells are affecting the target
DeleteTrigger("aura_detection_none")
AddTriggerEx("aura_detection_none", "^The target is not under the noticeable effect of any spells\\.$",
    "do_aura_detection()",
    trigger_flag.Enabled + trigger_flag.RegularExpression,
    custom_colour.Custom4, 0, "", "", sendto.script, 100)
SetTriggerOption("aura_detection_none", "group", "Aura LUA Triggers")

-- Trigger for the start of aura detection output
function do_aura_detection_start(name, line, wildcards)
    local match = wildcards[1]
    --Note("match: " .. match)
    if match:sub(-1) == "." then
        --Note("Single line detected")
        -- Single line, process immediately
        parse_aura_effects(match)
        aura_detection_line = ""
    else
        -- Multi-line, start accumulating
        aura_detection_line = match
        EnableTrigger("aura_detection_more", true)
    end
end
DeleteTrigger("aura_detection_start")
AddTriggerEx("aura_detection_start", "^The target is affected by (.+)$",
    "", trigger_flag.Enabled + trigger_flag.RegularExpression,
    custom_colour.Custom4, 0, "", "do_aura_detection_start", sendto.world, 100)
SetTriggerOption("aura_detection_start", "group", "Aura LUA Triggers")

-- Trigger for continuation lines of aura detection
function do_aura_detection_more(name, line, wildcards)
    local match = wildcards[1]
    --Note("match: " .. match)
    aura_detection_line = aura_detection_line .. " " .. match
    if match:sub(-1) == "." then
        -- End of multi-line, process now
        parse_aura_effects(aura_detection_line)
        aura_detection_line = ""
        EnableTrigger("aura_detection_more", false)
    end
end
DeleteTrigger("aura_detection_more")
AddTriggerEx("aura_detection_more", "^(.+)$",
    "", trigger_flag.RegularExpression,
    custom_colour.Custom4, 0, "", "do_aura_detection_more", sendto.world, 100)
SetTriggerOption("aura_detection_more", "group", "Aura LUA Triggers")

EnableTrigger("aura_detection_more", false)  -- Initially disabled
