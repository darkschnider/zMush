require "movement"

-- Define the Run class
Run = {}
Run.__index = Run

-- Constructor
function Run:new(first)
    local self = setmetatable({}, Run)
    self._first = first
    self._current = first
    self._name = "Some Random Run"
    self._path = ''
    return self
end

-- Load movements
function Run:loadMovements(first)
    self._first = first
    self._current = first
end

-- Load movements from a list of dictionaries
function Run:loadMovementsFromDictList(movement_dicts)
    --print("Loading movements from dict list")
    local previous = nil
    local first = nil
    for _, movement_dict in ipairs(movement_dicts) do
        --print("ITERATION " .. _)
        --print("Previous is " .. (previous and previous:name() or "nil"))
        --tprint(movement_dict)
        local newMovement = Movement:new(movement_dict)
        --tprint(newMovement)
        if first == nil then
            first = newMovement
        end
        newMovement:setPrevious(previous)
        previous = newMovement
    end
    self:loadMovements(first)
end

-- Get the prefix for the current line
function Run:getPrefix(line)
    for _, char in ipairs({':', ','}) do
        if string.find(line, char) then
            return string.match(line, "([^" .. char .. "]+)")
        end
    end
    return line
end

-- Fix movements by updating the name and announce attributes
function Run:fixMovements(movements)
    if not movements then
        return
    end
    local previous = nil
    for index, current in ipairs(movements) do
        --print("ITERATING:: Index: " .. index)
        current.index = index
        if previous ~= nil then
            --print("Previous is present: " .. (previous.name or "Unknown"))
            if current.name and previous.announce then
                --print("Current name is present and previous announce is present...")
                if current.name == '__announce__' then
                    --print("Current name is __announce__...")
                    if current.announce then
                        current.name = self:getPrefix(current.announce)
                    elseif current.name == nil then
                        current.name = 'Unknown'
                    end
                    --Note("Setting name to: " .. current.name)
                    previous.announce = string.format("[%s]. Next [%s]", previous.announce, current.name)
                    --Note("Setting previous announce to: " .. previous.announce)
                end
            elseif current.name ~= nil then
                --print("Current room: " .. current.name)
            else
                --current.name = 'standard_room'
            end
        else
            --print("Previous is not present")
        end
        --tprint(current)
        previous = current
    end
end

-- Load movements list from a config file
function Run.loadMovementsListFromConfigFile(path, basename)
    local sys_path = package.path
    package.path = path .. "?.lua;" .. package.path
    --print("Path: [" .. package.path .. "] basename: " .. basename)
    local success, modulea = pcall(require, basename)
    package.path = sys_path
    if not modulea then
        error("Error loading module: ", modulea)
        return false
    end
    if not modulea.FILE then
        error("No FILE attribute found in module " .. modulea)
        return {}
    end
    return modulea.FILE or {}
end

-- Load movements from a config file
function Run:loadMovementsFromConfigFile(config_file)
    local path, basename = string.match(config_file, "(.-)([^\\/]-%.?([^%.\\/]*))$")
    local movements = Run.loadMovementsListFromConfigFile(path, basename)

    if type(movements) ~= "table" then
        error("The FILE attribute is not a list: " .. type(movements))
        return false
    end

    self:fixMovements(movements)
    self:loadMovementsFromDictList(movements)

    error(string.format("Loaded run from config: %s", basename))

    self._name = basename
    self._path = config_file
    return true
end

-- Get the name of the run
function Run:name()
    return self._name
end

-- Get the path of the run
function Run:path()
    return self._path
end

-- Unload the run
function Run:unload()
    self._first = nil
    self._current = nil
    self._name = nil
    self._path = nil
    ColourNote("blue", "white", "Unloaded run")
end

-- Reset the run
function Run:reset()
    self._current = self._first
end

-- Get the first movement
function Run:first()
    return self._first
end

-- Get the current movement
function Run:current()
    return self._current
end

-- Display the current movement
function Run:display()
    Note(self._current)
end

-- Move forward to the next movement
function Run:forward()
    if self._current ~= nil then
        if self._current._next == nil then
            self._current = self._first
        else
            self._current = self._current._next
        end
    end
    return self._current
end

-- Rewind to the previous movement
function Run:rewind()
    if self._current ~= nil then
        if self._current._previous ~= nil then
            self._current = self._current._previous
        end
    end
    return self._current
end

-- Execute the current movement
function Run:execute(announce_only)
    announce_only = announce_only or false
    if self._current == nil then
        error("There is no movement to execute.")
        return
    end
    self._current:execute(announce_only)
end

-- Skip movements
function Run:skip()
    if self._current ~= nil then
        local skip = self._current:skip()
        if skip then
            ColourNote("white","blue",string.format("Skipping %d room%s", skip, (skip ~= 1 and "s" or "")))
            for _ = 1, skip - 1 do
                self:forward()
            end
            self:execute(true)
            self:forward()
        end
    end
    return self._current
end

-- Example usage
-- local run = Run:new()
-- run:loadMovementsFromConfigFile("test")
-- run:display()
-- run:execute(true)
-- run:forward()
-- run:display()
-- run:execute(true)
-- run:forward()
-- run:display()
-- run:unload()

return Run