----
--
-- Prints out the error to screen in a standard format.
--
-- @param message The error message to be printed.
--
function error(message)
    ColourNote("white","red", message)
end

function me(user)
    -- TODO: Replace with fetching the username from world properties, once I know how to do that...
    return user ~= nil and #user > 0 and user == GetVariable("player_name") or ""
end

-- Helper function to check if a name matches the player
function is_me(name)
    local player_name = GetVariable("player_name") or ""
    return name:lower() == player_name:lower()
end

function strlen(value)
    return value and #value > 0
end

function replace(old, new, text)
    return text:gsub(old, new)
end

function eval(code)
    local func, err = load(code)
    if not func then
        error("eval error when trying to load(code): " .. err)
        return false
    end

    local success, result = pcall(func)
    if not success then
        error("eval error when executing pcall(func): " .. result)
        return false
    end

    return result
end

function expr(expression)
    local func, err = load("return " .. expression)
    if not func then
        error("expr error when trying to load()" .. err)
        return false
    end

    local success, result = pcall(func)
    if not success then
        error("expr error whene running expression: " .. result)
        return false
    end

    return result
end

function getPrettyTime(time, short)
    short = short or false
    local negative = time < 0
    time = math.abs(math.floor(time * 1000))

    local units = {
        {time / 604800000, 'week', 'w'},
        {time / 86400000 % 7, 'day', 'd'},
        {time / 3600000 % 24, 'hour', 'h'},
        {time / 60000 % 60, 'minute', 'm'},
        {time / 1000 % 60, 'second', 's'},
        {time % 1000, 'millisecond', 'ms'},
    }

    local results = {}
    for _, unit in ipairs(units) do
        local count, long_name, short_name = unit[1], unit[2], unit[3]
        --print("Looking at " .. long_name .. "[" .. short_name .. "] with count " .. count .. " and time " .. time)
        if count > 1 or (count == 0 and long_name == 'second') then
            if short or (count == 0 and long_name == 'second') then
                table.insert(results, string.format("%d%s", count, short_name))
            else
                table.insert(results, string.format("%d %s%s", count, long_name, count == 1 and "" or "s"))
            end
        end
    end

    if short then
        return string.format("%s%s", negative and "-" or "", table.concat(results, " "))
    else
        return string.format("%s%s", negative and "-" or "", table.concat(results, ", "))
    end
end

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function unique(list, value)
    for _, v in ipairs(list) do
        if v == value then
            return list
        end
    end
    table.insert(list, value)
    return list
end

-- Helper function to mimic Python's repr function
function repr(value)
    if type(value) == "string" then
        return string.format("%q", value)
    else
        return tostring(value)
    end
end

function findIndex(t, value)
    for i, v in ipairs(t) do
        if v == value then
            return i
        end
    end
    return nil
end

function findTableKeyByValue(table, value_to_find)
    for key, value in pairs(table) do
        if key == value_to_find then
            return key
        end
    end
    return nil
end

function rTrimChars(str, chars)
    local pattern = "^*(.-)[" .. chars .. "]*$"
    return str:gsub(pattern, "%1")
end

----
-- Trim whitespace from both ends of a string
--
-- @param str The string to trim
-- @return The trimmed string
----
function trim(str)
    if not str then return "" end
    return str:match("^%s*(.-)%s*$")
end

----
-- Sanitize a string for use as an effect key
-- Converts to lowercase, replaces spaces with underscores, removes special characters
--
-- @param str The string to sanitize
-- @return The sanitized string
----
function sanitize(str)
    if not str then return "" end
    -- Convert to lowercase
    str = str:lower()
    -- Replace spaces with underscores
    str = str:gsub("%s+", "_")
    -- Remove apostrophes and other special characters (keep only alphanumeric and underscores)
    str = str:gsub("[^%w_]", "")
    return str
end
