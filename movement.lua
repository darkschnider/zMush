require "util"
require "run_commands" -- for run_path

Movement = {}
Movement.__index = Movement

function Movement:new(args)
    local self = setmetatable({}, Movement)
    --tprint(args)
    
    self._previous = nil
    self._next = nil
    self._index = args.index or 0
    self._alignment = args.alignment or ''
    self._announce = args.announce or ''
    self._commands = args.commands and split(args.commands,';') or {}
    self._eval = args.eval or ''
    self._flags = args.flags or ''
    self._in_commands = args.in_commands and split(args.in_commands,';') or {}
    self._items = args.items or ''
    self._name = args.name or ''
    self._out_commands = args.out_commands and split(args.out_commands,';') or {}
    self._path = args.path and split(args.path,';') or {}
    self._orig_path = args.path or ''
    self._skip = math.max(0, args.skip or 0)
    self._target = args.target or ''
    self._warnings = args.warnings or ''

    --tprint(self)
    
    return self
end

function Movement:__tostring()
    return string.format("%d: %s > %s", self._index, self._announce, self._orig_path)
end

function Movement:previous()
    return self._previous
end

function Movement:setPrevious(newPrevious)
    --print("Movement " .. (self:name() or "Unknown") .. " - Setting previous to " .. (newPrevious and newPrevious:name() or "nil"))
    if self._previous ~= nil then
        --print("Unsetting previous next")
        self._previous._next = nil
    end
    if newPrevious ~= nil then
        --print(string.format("Setting newPrevious[%s] next to [%s]", newPrevious:name(), self:name()))
        newPrevious._next = self
    end

    self._previous = newPrevious
end

function Movement:next()
    return self._next
end

function Movement:setNext(newNext)
    --print("Movement " .. (self:name() or "Unknown") .. " - Setting next to " .. (newNext and newNext:name() or "nil"))
    if self._next ~= nil then
        --print("Unsetting next previous")
        self._next._previous = nil
    end
    if newNext ~= nil then
        --print(string.format("Setting newNext[%s] previous to [%s]", newNext:name(), self:name()))
        newNext._previous = self
    end

    self._next = newNext
end

function Movement:index()
    return self._index
end
function Movement:announce()
    return self._announce
end
function Movement:commands()
    return self._commands
end
function Movement:eval()
    return self._eval
end
function Movement:flags()
    return self._flags
end
function Movement:inCommands()
    return self._in_commands
end
function Movement:items()
    return self._items
end
function Movement:name()
    return self._name or "ERROR"
end
function Movement:outCommands()
    return self._out_commands
end
function Movement:path()
    return self._path
end
function Movement:skip()
    return self._skip
end
function Movement:nextSkip()
    if self._next then
        return math.max(0, self._next:skip())
    end
    return 0
end
function Movement:target()
    return self._target
end
function Movement:warnings()
    return self._warnings
end
function Movement:execute(announce_only)
    announce_only = announce_only or false
    local template = {}
    if announce_only then
        template = {
            a = self._announce,
            A = self._alignment,
            F = self._flags,
            r = self._index,
            s = self._skip,
            t = self._target,
            w = table.concat(self._out_commands, ";"),
            W = self._warnings,
            x = table.concat(self._in_commands, ";")
        }
    else
        template = {
            a = self._announce,
            A = self._alignment,
            bag = using_bag_of_holding or false,
            c = table.concat(self._commands, ";"),
            d = table.concat(self._path, ";"),
            e = self._eval,
            F = self._flags,
            i = self._items,
            r = self._index,
            s = self._skip,
            t = self._target,
            w = table.concat(self._out_commands, ";"),
            W = self._warnings,
            x = table.concat(self._in_commands, ";")
        }
    end

    --print("Executing movement: ")
    --tprint(template)
    run_path(template)
end

return Movement