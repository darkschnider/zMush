require "getopts"
require "util"

quiet_mode = false
is_away = false
announce = true
announce_to = "note"

local announce_locations = {
    "echo",
    "emote",
    "other",
    "party",
    "say",
    "think",
    "note"
}

-- Announce extra variables
announce_echo_l = "-={ "
announce_echo_s = ""
announce_echo_r = " }=-"

announce_say_l = "-={ "
announce_say_s = ""
announce_say_r = " }=-"

announce_think_l = ""
announce_think_s = ""
announce_think_r = ""

announce_party_l = "-={ "
announce_party_s = ""
announce_party_r = " }=-"

announce_other_l = ""
announce_other_s = ""
announce_other_r = ""

announce_status_l = "-={ "
announce_status_s = ""
announce_status_r = " }=-"

announce_other_command = "echo"

if GetAlias("luaAliasAnnounce") ~= eAliasNotFound then
    DeleteAlias("luaAliasAnnounce")
end
AddAlias("luaAliasAnnounce", "/announce", "toggle_announce()", alias_flag.Enabled, "")
SetAliasOption("luaAliasAnnounce", "send_to", sendto.script)

function toggle_announce()
    local idx = findIndex(announce_locations, announce_to)
    
    if idx == nil then
        idx = 1
    elseif idx == #announce_locations then
        idx = 1
    else
        idx = idx + 1
    end
    announce_to = announce_locations[idx]
    ColourNote("Grey", "Orange", "Announce destination set to: " .. announce_to)
end

function setAnnounceTo(destination)
    announce_to = destination
    ColourNote("Grey", "Orange", "Announce destination set to: " .. destination)
end
function setAnnounce(shoudAnnounce)
    announce = shoudAnnounce
    ColourNote("Grey", "Orange", "Announce set to: " .. shoudAnnounce)
end
function setQuietMode(shouldQuiet)
    quiet_mode = shouldQuiet
    ColourNote("Grey", "Orange", "Quiet Mode set to: " .. shouldQuiet)
end
function setAway(shouldAway)
    is_away = shouldAway
    ColourNote("Grey", "Orange", "Away set to: " .. shouldAway)
end
function setInParty(inParty)
    party_members = inParty > 0 or 0
    ColourNote("Grey", "Orange", "Party members set to: " .. inParty)
end

----
--
-- The main trig interface to displaying messages. This macro will announce
-- the message to the default medium unless otherwise specified. Will also
-- only delegate to the other announce_to macros when %{announce} is true or
-- otherwise forced.
--
-- @param message* The message that is to be announced.
--
-- @option a Announce regardless of the %{announce} var's setting.
-- @option b Do not print customized brackets (party).
-- @option c:color Prints the message with the color given.
-- @option d:destination The destination of the message. Without this it uses the
--     %{announce_to} variable.
-- @option f:status Prints a status for the message using separator.
-- @option m Only send messages to party IF there's more than one member (party).
-- @option n#repeats Number of times to repeat the message.
-- @option t Send messages if and only if you are the tank (party).
-- @option x Never send messages to status when other channel fails.
function do_announce(options, message)
    --print("do_announce")
    -- Check options
    local opts = getopts('abc:d:f:mn#tx', options)
    --tprint(opts)
    if not opts or not message then
        print("do_announce: returning due to missing options or message")
        if  opts.t and not is_me(party_tank) then
            print ("do_announce: .. BUT also due to not being the tank and t option set!")
            return
        end
        
        return
    end

    if not strlen(opts.d) or opts.d == 'default' then
        -- print("do_announce: missing or default opts.d, setting to announce_to[" .. announce_to .. "].")
        opts.d = announce_to
    end

    if not quiet_mode and not is_away and (party_members > 1 or not (opts.m or false)) and (announce or (opts.a or false)) then
        local _repeats = (opts.n and opts.n > 1) and opts.n .. " " or ""
        if opts.d == 'echo' then
            if strlen(opts.f) then
                Send(_repeats .. "echo " .. announce_echo_l .. message .. announce_echo_s .. opts.f .. announce_echo_r)
            else
                Send(_repeats .. "echo " .. announce_echo_l .. message .. announce_echo_r)
            end
            return
        end

        if opts.d == 'emote' then
            if strlen(opts.f) then
                Send(_repeats .. "emote " .. announce_emote_l .. message .. announce_emote_s .. opts.f .. announce_emote_r)
            else
                Send(_repeats .. "emote " .. announce_emote_l .. message .. announce_emote_r)
            end
            return
        end

        if opts.d == 'other' then
            if strlen(opts.f) then
                Send(_repeats .. announce_other_command .. " " .. announce_other_l .. message .. announce_other_s .. opts.f .. announce_other_r)
            else
                Send(_repeats .. announce_other_command .. " " .. announce_other_l .. message .. announce_other_r)
            end
            return
        end

        if opts.d == 'party' and party_members then
            local _color = ""
            if strlen(opts.c) and is_me(party_commander) then
                _color = opts.c:upper() .. "_COLOUR "
            end

            local _party_say = "party say"
            if strlen(party_aide) and is_me(party_aide) then
                _party_say = "aide say"
            end

            if opts.b then
                if strlen(opts.f) then
                    Send(_repeats .. _party_say .. " " .. _color .. message .. announce_party_s .. opts.f)
                else
                    Send(_repeats .. _party_say .. " " .. _color .. message)
                end
                return
            end

            if strlen(opts.f) then
                Send(_repeats .. _party_say .. " " .. _color .. announce_party_l .. message .. announce_party_s .. opts.f .. announce_party_r)
            else
                Send(_repeats .. _party_say .. " " .. _color .. announce_party_l .. message .. announce_party_r)
            end
            return
        end

        if opts.d == 'say' then
            if strlen(opts.f) then
                Send(_repeats .. "say " .. announce_say_l .. message .. announce_say_s .. opts.f .. announce_say_r)
            else
                Send(_repeats .. "say " .. announce_say_l .. message .. announce_say_r)
            end
            return
        end

        if opts.d == 'think' then
            if strlen(opts.f) then
                Send(_repeats .. "think " .. announce_think_l .. message .. announce_think_s .. opts.f .. announce_think_r)
            else
                Send(_repeats .. "think " .. announce_think_l .. message .. announce_think_r)
            end
            return
        end
    end

    if not opts.x then
        local _cmd = ""
        if strlen(opts.f) then
            _cmd = announce_status_l .. message .. announce_say_s .. opts.f .. announce_status_r
        else
            _cmd = announce_status_l .. message .. announce_status_r
        end
        for i = 1, (opts.n or 1) do
            ColourNote("white", opts.c, _cmd)
        end
    end
end

local report_effects = true
local effect_extra_l = "[" 
local effect_extra_r = "]"

----
--
-- Announce the status of an effect. If %{report_effects} is enabled then it
-- will be displayed to the default %{announce_to} location. Otherwise it'll
-- report to status.
--
-- @option n#repeats Number of times to repeat the announcement.
-- @option o:other Other information related to the effect such as the uptime.
-- @option p:name* Name of the effect you wish to display.
-- @option s#status Prints the message with the color given.
--
function announce_effect(options)
    --print("announce_effect")
    --tprint(options)
    local opts = getopts('p:s#o:n#', options)
    if not opts then
        return
    end

    if not strlen(opts.p) then
        error(string.format("Error: %s must be the name of the effects", options[0]))
        return 0
    end

    local color = opts.s == 1 and "green" or "red"
    local status = opts.s == 1 and "ON" or "OFF"
    local repeats = tonumber(opts.n) or 1

    if report_effects then
        if strlen(opts.o) then
            --print(string.format("-c%s -f'%s %s%s%s' -- %s", color, status, effect_extra_l, escape(opts.o), effect_extra_r, opts.p))
            do_announce({c = color, f = string.format("%s %s%s%s", status, effect_extra_l, opts.o, effect_extra_r), n = repeats, x = false}, opts.p .. " ")
        else
            --print(string.format("-c%s -f'%s' -- %s", color, status, opts.p))
            do_announce({c = color, f = status, n = repeats, x = false}, opts.p .. " ")            
        end
    else
        if strlen(opts.o) then
            for i = 1, repeats do
                print(string.format("-d'status' -f'%s %s%s%s' -- %s", status, effect_extra_l, opts.o, effect_extra_r, opts.p))
            end
        else
            for i = 1, repeats do
                print(string.format("-d'status' -f'%s' -- %s", status, opts.p))
            end
        end
    end
end

----
--
-- Announce the current area in a standard format.
--
-- @param areaMessage The area to announce
--
function area_announce(areaMessage)
    if strlen(areaMessage) then
        local options = {
            d = "party",
            x = false,
            b = true,
            c = "yellow"
        }
        do_announce(options, "+++ We have arrived at: " .. areaMessage)
    end
end

-- Function to handle area warnings
function area_warning(...)
    local args = {...}
    local message = table.concat(args, " ")

    -- Send a message to the party
    if #message then
        local options = {
            d = "party",
            b = true,
            c = "green"
        }
        do_announce(options, "!!! WARNING: " .. message .. " !!!")
    end
end
