----
-- The main interface for which to cast/use protective spells/skills.
--
-- @param options Table with the following options:
--   A = alias: The mud alias to set when performing this action
--   a = action*: The action to perform. Must be one of 'cast' or 'use'
--   d = destination: The destination of the message. Without this it uses announce_to
--   n = name: The proper name of this skill/spell
--   q = quiet: Do not announce the performing of action
--   s = sksp*: The name of the skill/spell to perform
--   t = target: The target on which to perform action
--   x = speed: Casting speed. Must be one of 'very quick', 'quick', 'normal', 'slow' or 'very slow'
----

require("getopts")
require("util")
require("do_announce")

-- Configuration variables
report_sksp = report_sksp or true
spell_speeds = spell_speeds or {}  -- Table to store spell speeds: spell_speeds["spell_name"] = "speed"

----
-- Get the spell speed for a given spell
--
-- @param spell_name The name of the spell
-- @return The speed or nil
----
function get_spell_speed(spell_name)
    return spell_speeds[spell_name]
end

----
-- Set the spell speed for a given spell
--
-- @param spell_name The name of the spell
-- @param speed The speed to use
----
function set_spell_speed(spell_name, speed)
    spell_speeds[spell_name] = speed
end

----
-- Check if a destination is a valid announcement channel
--
-- @param dest The destination to check
-- @return true if it's a valid announcement channel, false otherwise
----
function is_announce(dest)
    if not dest or dest == "" then
        return false
    end
    local valid = {echo = true, emote = true, other = true, party = true, say = true, think = true, note = true}
    return valid[dest] or false
end

----
-- Capitalize the first letter of a string
--
-- @param str The string to capitalize
-- @return The capitalized string
----
function capitalize(str)
    if not str or str == "" then return "" end
    return str:sub(1, 1):upper() .. str:sub(2)
end

----
-- Main function to cast or use protective spells/skills
--
-- @param options Table with options (see above)
----
function do_prot(options)
    local opts = getopts('A:a:d:s:n:t:x:q', options)
    
    if not opts then
        return
    end
    
    -- Validate action
    if opts.a ~= 'cast' and opts.a ~= 'use' then
        error("do_prot: option 'a' must be one of 'use' or 'cast'")
        return
    end
    
    -- Validate spell/skill name
    if not strlen(opts.s) then
        error("do_prot: option 's' must be the name of a spell")
        return
    end
    
    -- Handle casting speed (optional)
    if opts.a == 'cast' then
        if not opts.x or opts.x == "" then
            opts.x = get_spell_speed(opts.s)
        end
    else
        opts.x = nil
    end
    
    -- Case 1: No target specified (cast on self)
    if not strlen(opts.t) then
        -- Build command
        local cmd = opts.a .. " '" .. opts.s .. "'"
        if opts.x and opts.x ~= "" then
            cmd = cmd .. " try " .. opts.x
        end
        Send(cmd)
        
        -- Announce
        if report_sksp and not opts.q then
            if not is_announce(opts.d) then
                opts.d = "default"
            end
        else
            opts.d = "status"
        end
        
        local spell_name = opts.n or opts.s
        do_announce({d = opts.d, c = opts.d == "status" and "orange" or ""}, spell_name)
        return
    end
    
    -- Handle "me" as target
    if opts.t == "me" then
        opts.t = GetVariable("character_name") or "me"
    end
    
    -- Set alias if specified
    if strlen(opts.A) then
        SetVariable(opts.A, opts.t)
    end
    
    -- Case 2: Target specified
    local cmd = opts.a .. " '" .. opts.s .. "' " .. opts.t
    if opts.x and opts.x ~= "" then
        cmd = cmd .. " try " .. opts.x
    end
    Send(cmd)
    
    -- Announce with target
    if report_sksp and not opts.q then
        if not is_announce(opts.d) then
            opts.d = "default"
        end
    else
        opts.d = "status"
    end
    
    local spell_name = capitalize(opts.n or opts.s)
    do_announce({d = "default", f = opts.t, c = opts.d == "status" and "orange" or ""}, spell_name)
end
