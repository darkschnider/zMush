require "util"
require "getopts"
require "var"
require "do_announce"

function load_run(runner_file)
    if not runner_file then
        error("No runner file specified.")
        return
    end

    if _current_run ~= nil then
        local runner = _current_run
        print(_current_run)
        print("Unloading previous runner[" .. (_current_run:name() or "Unknown") .. "] file.")
        _current_run:unload()
        _current_run = nil
    end

    local _new_run = Run:new()
    if _new_run:loadMovementsFromConfigFile(runner_file) then
        --print("Loaded runner file: " .. runner_file)
        _current_run = _new_run
    else
        error("Could not load runner file: " .. runner_file)
    end
end

function leave_room()
    if strlen(GetVariable("on_leave_room")) or false then
        Send(GetVariable("on_leave_room"))
    end
end

function enter_room()
    if strlen(GetVariable("on_enter_room")) or false then
        Send(GetVariable("on_enter_room"))
    end
end

function area_cmds(cmds)
    if strlen(cmds) and is_me(party_tank) or is_me(party_commander) then
        do_announce({d="party", b=true, x=true, c="red"}, "TYPE: " .. replace(';', ', ', cmds))
    end
end

----
--
-- This does many actions with the supplied arguments. This lets you, for
-- example run to a monster, set the target, tell party members what they need
-- to type, let them know about various warnings, gets certain items from your
-- bag of holding, and optionally sets the macro that would take you back and
-- the sets the number of rooms one would skip if they skipped the area.
--
-- @option A:alignment Alignment of the target.
-- @option E:expression Expression to check before executing. (UNSUPPORTED)
-- @option F:flags Flags.
-- @option W:warnings Warning messages.
-- @option a:area Name of the area, room.
-- @option b:macro Name of macro to get reverse.
-- @option c:commands Commands that other members need to type.
-- @option d:dirs zMUD style dirs (; separated).
-- @option e:commands Extra commands that are evaluated after dirs are executed.
-- @option f Force sending of text to mud even if idle/away.
-- @option bag:bag If you need to get items from the bag of holding.
-- @option i:items Items needed from bag of holding.
-- @option n Name of the current path.
-- @option r#number The current room number.
-- @option s#skip Number of rooms to skip if you wish to not continue.
-- @option t:target Target to set.
-- @option w:dirs zMUD style wimpy dirs (; separated).
-- @option x:dirs zMUD style opposite of wimpy dirs (; separated).
function run_path(options)
    -- Check options; gotta have them!
    if not options then
        return
    end

    local opt = getopts('d:b:t:a:c:w:x:i:s#r#W:n:E:F:A:fe:', options)
    --tprint(opt)

    -- Check the expression (if any)
    if strlen(options.E) and not expr(options.E) then
        return
    end

    -- Name of the current path
    if strlen(options.n) then
        location = options.n
    else
        location = nil
    end

    -- Store back movement
    if strlen(options.b) then
        SetVariable("_go_back", options.b)
    else
        SetVariable("_go_back", "??")
    end

    -- Get any needed items from the bag of holding
    if strlen(options.i) and options.bag or false then
        Send("get " .. options.i .. " from bag of holding")
    end

    -- Actual movement happens here!
    if strlen(options.d) then
        -- Ignore other party members movements, if we have any other members
        if options.party_members and options.party_members > 1 then
            Send("ignore -m on")
        end

        -- TODO: These might have been TF macros? Still need to check
        --Send("plain_prompt")
        leave_room()

        -- This seems to be determining if it should forcibly send the actions to the MUD or just send the command.
        -- Used when a user goes idle, but right now that is not supported in this implementation.
        -- TODO: Implement idle/away support
        if options.f then
            --Send("eval -s1 /send -- !" .. replace(";", "%;/send -- !", options.d))
            -- Since this isn't supported, just send the command
            Execute(options.d)
        else
            -- Do the movement
            Execute(options.d)
        end

        -- Turn back on party member movements
        if options.party_members and options.party_members > 1 and not options.ignore_movement then
            Send("ignore -m off")
        end

        -- TODO: These might have been TF macros? Still need to check
        --Send("status_prompt")
        enter_room()
    end

    -- Extra commands to run after movement
    if strlen(options.e) then
        eval(options.e)
    end

    if strlen(options.i) and options.bag or false then
        Send("put " .. options.i .. " in bag of holding")
    end

    -- Are we announcing the movement?
    if strlen(options.a) then
        local _area = options.a
        if strlen(options.A) then -- Alignment
            _area = _area .. " <" .. options.A .. ">"
        end
        if options.r then -- Room number
            _area = _area .. " (" .. options.r .. ")"
        end
        if options.s then -- Number of subsequent movements to skip
            _area = _area .. " {SKIP:" .. options.s .. "}"
        end
        if strlen(options.F) then -- Flags
            _area = _area .. " *" .. options.F .. "*"
        end
        -- Do the announcement
        --print(area)
        area_announce(_area)
    end

    --if strlen(options.F) then
    --    print("area_flags " .. options.F)
    --end

    --print("area_warnings: " .. options.W)
    if strlen(options.W) then
        area_warning(options.W)
    end

    if strlen(options.c) then
        area_cmds(options.c)
    end

    if strlen(options.w) then
        out = options.w
        area_wimpy_cmds(out)
    else
        out = nil
    end

    if strlen(options.x) then
        _in = options.x
    else
        _in = nil
    end

    if options.s then
        skip = options.s
    else
        skip = nil
    end

    if strlen(options.t) then
        Send("alias _target ", options.t)
        --print("area_target " .. options.t)
        if options.scan_target then
            Send("look at " .. options.t)
        end
    end
end

function next_movement()
    if _current_run == nil then
        error("No runner loaded.")
        return
    end
    _current_run:execute()
    _current_run:forward()
end
    