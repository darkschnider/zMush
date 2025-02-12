require "util"

-- Define the Effect class
Effect = {}
Effect.__index = Effect

-- Constructor
function Effect:new(key, name, short_name, layers, groups)
    local self = setmetatable({}, Effect)
    self._key = key
    self._name = name
    self._short_name = short_name or nil
    self._layers = layers or 1
    if type(groups) == "string" then
        self._groups = groups ~= "" and split(groups, " ") or nil
    elseif type(groups) == "table" then
        self._groups = {unpack(groups)}
    else
        self._groups = groups
    end
    self._last_duration = -1
    self:reset()
    return self
end

-- Copy method
function Effect:copy()
    return Effect:new(self._key, self._name, self._short_name, self._layers, self._groups)
end

-- Reset method
function Effect:reset()
    self._state = {}
end

-- Comparison method
function Effect:__eq(other)
    return self._name == other._name
end

-- Property methods
function Effect:get_count()
    return math.max(0, math.min(self._layers, #self._state))
end

function Effect:get_key()
    return self._key
end

function Effect:get_name()
    return self._name
end

function Effect:get_short_name()
    return self._short_name
end

function Effect:get_layers()
    return self._layers
end

function Effect:get_groups()
    return self._groups
end

function Effect:get_duration()
    if #self._state > 0 then
        --print("Effect:get_duration: self._state size: " .. #self._state)
        --print("Effect:get_duration: self._state[1]: " .. self._state[1])
        --print("Effect:get_duration: os.time(): " .. os.time())
        --print("Effect:get_duration: os.time() - self._state[1]: " .. os.time() - self._state[1])
        return os.time() - self._state[1]
    end
    return -1
end

function Effect:get_last_duration()
    return self._last_duration
end

-- Turn effect on
function Effect:on(quiet)
    table.insert(self._state, os.time())
    self._state = {unpack(self._state, math.max(1, #self._state - self._layers + 1))}
    --print("Effect:on: state: ")
    --tprint(self._state)
    if quiet then return end
    if self._layers > 1 then
        --tf.eval(string.format("/announce_effect -p%s -s1 -o%s", self._name, string.format("%d/%d", self:get_count(), self._layers)))
        local o = string.format("%d/%d", self:get_count(), self._layers)
        --print("o: " .. o)
        announce_effect({
            p = self._name,
            s = 1,
            o = o,
            x = false
        })
    else
        --tf.eval(string.format("/announce_effect -p%s -s1", self._name))
        announce_effect({
            p = self._name,
            s = 1,
            x = false
        })
    end
end

-- Turn effect off
function Effect:off(quiet)
    local duration = self:get_duration()
    if #self._state > 0 then
        self._last_duration = duration
        table.remove(self._state, 1)
    end
    if quiet then return end
    local tanking = is_me(party_tank)
    if self._layers > 1 then
        --tf.eval(string.format("/announce_effect -p%s -s0 -o%s -n%d", self._name, string.format("%s, %d/%d", util.getPrettyTime(math.floor(duration), true), self:get_count(), self._layers), tanking and 2 or 1))
        local dur = getPrettyTime(math.floor(duration), true)
        --print("Effect:off: dur: " .. dur)
        local o = string.format("%s, %d/%d", getPrettyTime(math.floor(duration), true), self:get_count(), self._layers)
        --print("Effect:off: o: " .. o)
        announce_effect({
            p = self._name,
            s = 0, 
            o = string.format("%s, %d/%d", getPrettyTime(math.floor(duration), true), self:get_count(), self._layers),
            n = tanking and 2 or 1,
            x = false
        })
    else
        --tf.eval(string.format("/announce_effect -p%s -s0 -o%s -n%d", self._name, util.getPrettyTime(math.floor(duration), true), tanking and 2 or 1))
        announce_effect({
            p = self._name,
            s = 0,
            o = getPrettyTime(math.floor(duration), true),
            n = tanking and 2 or 1,
            x = false
        })
    end
end

-- Return the current state of the effect as a dictionary
function Effect:stateDict(online, offline)
    online = online or true
    offline = offline or true
    if self:get_count() > 0 and (online or (self:get_count() < self._layers and offline)) then
        return {
            name = self._name,
            key = self._key,
            count = string.format("%d/%d", self:get_count(), self._layers),
            status = self._last_duration ~= -1 and string.format("%d/%ds", self:get_duration(), self._last_duration) or string.format("%ds", self:get_duration()),
            state = "ON",
            color = self:get_count() == self._layers and "green" or "yellow"
        }
    end
    if offline and self:get_count() == 0 then
        return {
            name = self._name,
            key = self._key,
            count = string.format("%d/%d", self:get_count(), self._layers),
            status = "OFF",
            state = "OFF",
            color = "red"
        }
    end
end

-- Define the EffectGroup class
EffectGroup = {}
EffectGroup.__index = EffectGroup

-- Constructor
function EffectGroup:new(key, name, short_name)
    local self = setmetatable({}, EffectGroup)
    self._effects = {}
    self._key = key
    self._name = name
    self._short_name = short_name or nil
    return self
end

-- Copy method
function EffectGroup:copy()
    return EffectGroup:new(self._key, self._name, self._short_name)
end

-- Property methods
function EffectGroup:get_key()
    return self._key
end

function EffectGroup:get_effect()
    for key, effect in pairs(self._effects) do
        if effect:get_count() > 0 then
            return effect
        end
    end
    return nil
end

function EffectGroup:get_count()
    local effect = self:get_effect()
    if effect == nil then
        return 0
    end
    return effect:get_count()
end

function EffectGroup:get_name()
    local effect = self:get_effect()
    if effect == nil then
        return self._name
    end
    return effect:get_name()
end

function EffectGroup:get_short_name()
    local effect = self:get_effect()
    if effect == nil then
        return self._short_name
    end
    return effect:get_short_name()
end

function EffectGroup:get_layers()
    local effect = self:get_effect()
    if effect == nil then
        return 1
    end
    return effect:get_layers()
end

-- Add an effect to this effect group
function EffectGroup:add(effect)
    self._effects[effect:get_key()] = effect
end

-- Remove an effect from this effect group
function EffectGroup:remove(key)
    self._effects[key] = nil
end

-- Return the current state of this effect group as a dictionary
function EffectGroup:stateDict(online, offline)
    online = online or true
    offline = offline or true
    local effect = self:get_effect()
    if effect ~= nil then
        return effect:stateDict(online, offline)
    end

    if offline then
        return {
            name = string.format("%s (g)", self._name),
            key = self._key,
            count = "-",
            status = "OFF",
            state = "OFF",
            color = "red"
        }
    end
end

-- Define the Effects class
Effects = {}
Effects.__index = Effects

-- Constructor
function Effects:new()
    local self = setmetatable({}, Effects)
    self._effects = {}
    self._effect_groups = {}
    return self
end

-- Copy method
function Effects:copy()
    local effects = Effects:new()
    for _, effect_group in pairs(self._effect_groups) do
        effects:addGroup(effect_group:copy())
    end
    for _, effect in pairs(self._effects) do
        effects:add(effect:copy())
    end
    return effects
end

-- Reset all effects
function Effects:reset()
    for _, effect in pairs(self._effects) do
        effect:reset()
    end
end

-- Iterator method
function Effects:__pairs()
    return pairs(self._effects)
end

-- Add an effect group
function Effects:addGroup(effect_group)
    if self._effects[effect_group:get_key()] then
        error(string.format("effect_group.key is an effect: %s", effect_group:get_key()))
        return
    end
    self._effect_groups[effect_group:get_key()] = effect_group
end
function Effects:addNewGroup(group_key, group_name)
    local newEffectGroup = EffectGroup:new(group_key, group_name)
    self:addGroup(newEffectGroup)
end

-- Add an effect
function Effects:add(effect)
    if self._effect_groups[effect:get_key()] then
        error(string.format("effect.key[%s] is already defined as an effect group", effect:get_key()))
        return
    end
    self._effects[effect:get_key()] = effect

    if not effect:get_groups() then
        return
    end

    for _, group in ipairs(effect:get_groups()) do
        --print("Da group: " .. group)
        if not self._effect_groups[group] then
            error(string.format("effect.groups does not exist: %s", group))
        else
            --print("Found an existing group: " .. group .. " for effect: " .. effect:get_key() .. ". Adding effect to group.")
            self._effect_groups[group]:add(effect)
        end
    end
end
function Effects:addNewEffect(key, name, short_name, layers, groups, upMessage, downMessage)
    local newEffect = Effect:new(key, name, short_name, layers, groups)
    self:add(newEffect)
    if not upMessage or not downMessage then
        return
    end
    local alreadyExists = GetTrigger("luaTrig"..short_name .."Up")
    if alreadyExists ~= eTriggerNotFound then
        DeleteTrigger("luaTrig"..short_name .."Up")
        DeleteTrigger("luaTrig"..short_name .."Down")
    end
    local trigFlags = 33 -- Enabled | RegularExpression
    AddTriggerEx("luaTrig"..short_name .."Up", "^"..upMessage.."$", "effect_on(\"" .. key .. "\")", trigFlags, custom_colour.Custom3, 0, "", "", 12, 100)
    AddTriggerEx("luaTrig"..short_name .. "Down", "^"..downMessage.."$", "effect_off(\"" .. key .. "\")", trigFlags, custom_colour.Custom6, 0, "", "", 12, 100)
end

-- Remove an effect group
function Effects:removeGroup(key)
    self._effect_groups[key] = nil
end

-- Remove an effect
function Effects:remove(key)
    if self._effects[key] then
        self._effects[key] = nil
        for _, effect_group in pairs(self._effect_groups) do
            effect_group:remove(key)
        end
    end
end

-- Turn on an effect
function Effects:on(key, quiet)
    quiet = quiet or false
    if self._effects[key] then
        --print("Turning on effect: " .. key)
        self._effects[key]:on(quiet)
    end
end

-- Turn off an effect
function Effects:off(key, quiet)
    quiet = quiet or false
    if self._effects[key] then
        self._effects[key]:off(quiet)
    end
end

-- Get the count of an effect
function Effects:count(key)
    if self._effects[key] then
        return self._effects[key]:get_count()
    end
    return 0
end

-- Get the name of an effect
function Effects:name(key)
    if self._effects[key] then
        return self._effects[key]:get_name()
    end
    return ""
end

-- Get the short name of an effect
function Effects:short_name(key)
    if self._effects[key] then
        return self._effects[key]:get_short_name()
    end
    return ""
end

-- Get the layers of an effect
function Effects:layers(key)
    if self._effects[key] then
        return self._effects[key]:get_layers()
    end
    return 0
end

-- Get the duration of an effect
function Effects:duration(key)
    if self._effects[key] then
        return self._effects[key]:get_duration()
    end
    return -1
end

-- Get the last duration of an effect
function Effects:last_duration(key)
    if self._effects[key] then
        return self._effects[key]:get_last_duration()
    end
    return -1
end

-- Apply template for each effect that matches the search criteria
function Effects:forall(template, keys, online, offline)
    online = online or true
    offline = offline or true

    if not template then
        return
    end

    local effects = {}
    if not keys then
        for _, effect in pairs(self._effects) do
            table.insert(effects, effect)
        end
        table.sort(effects, function(a, b) return a:get_name() < b:get_name() end)
    else
        if type(keys) == "string" then
            keys = util.split(keys, " ")
        end
        for _, key in ipairs(keys) do
            if self._effect_groups[key] then
                table.insert(effects, self._effect_groups[key])
            elseif self._effects[key] then
                table.insert(effects, self._effects[key])
            end
        end
    end

    local found = false
    for _, effect in ipairs(effects) do
        local result = effect:stateDict(online, offline)
        if result then
            found = true
            local options = {
                d = "default",
                x = false,
                c = result.color
            }
            do_announce(options, string.format(template, result.name, result.count, result.status))
        end
    end

    if not found then
        local options = {
            d = "default",
            x = false,
            c = "red"
        }
        do_announce(options, string.format(template, "None", "-", "-"))
    end
end

-- Add this function to the Effects class
function Effects:find(key)
    return self._effects[key] or nil
end

-- Global instance of the Effects class
zEffects = Effects:new()

function effect_on(key)
    local quiet = false
    zEffects:on(key, quiet)
end
function effect_off(key)
    local quiet = false
    zEffects:off(key, quiet)
end

effects_list = {"beckon_darkness","unpain","brain_unpain","healing_smoke","regeneration"}

function check_effects(sendToParty)
    --/say -d'party' -x -c'blue' -- --------------------------------------------------------------%; \
    --/python effects.inst.forall('/say -d"party" -x -c"%%(color)s" -- %%(name)-35s %%(count)10s %%(status)15s', keys='$(/escape ' %{effects_list})', online=True, offline=True)%; \
    --/say -d'party' -x -c'blue' -- --------------------------------------------------------------
    local options = {
        d = "default",
        x = false,
        c = "blue"
    }

    -- effects_list here comes from the list of effects that the user wishes to have displayed as part of this command
    -- This is a list of effect or effect group keys. Either one works in this list
    -- for now, let's hard code this list to just true_unpain
    do_announce(options, "---------------------- Current effects -----------------------")
    zEffects:forall("%-35s %10s %15s", effects_list, true, true)
    do_announce(options, "--------------------------------------------------------------")
end

function addEffectToCheck(effect_key)
    for _, key in ipairs(effects_list) do
        if key == effect_key then
            return -- Exit the function if the key already exists
        end
    end
    table.insert(effects_list, effect_key) -- Add the key if it does not exist
end

function removeEffectToCheck(effect_key)
    for i, key in ipairs(effects_list) do
        if key == effect_key then
            table.remove(effects_list, i)
            break
        end
    end
end

-- Example usage contained within effect_definitions.lua
return zEffects