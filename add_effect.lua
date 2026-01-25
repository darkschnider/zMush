zEffects = require "effects"

aliasEnabledAndRegex = 129
aliasEnabled = 1

function addNewSpellAndAlias(key, spell_name, short_name, alias_command, alias_flags, alias_script, layers, groups, upMessage, downMessage)
    addNewAlias(spell_name, short_name, alias_command, alias_flags, alias_script, true)
    zEffects:addNewEffect(key, spell_name, short_name, layers, groups, upMessage, downMessage)
end

function addNewAlias(spell_name, short_name, alias_command, alias_flags, alias_script, is_spell)
    local alias_name = "luaAlias" .. short_name
    local alreadyExists = GetAlias(alias_name)
    local ability_type = is_spell and "cast" or "use"
    if alreadyExists ~= eAliasNotFound then
        DeleteAlias(alias_name)
    end

    if (alias_flags == aliasEnabledAndRegex) then
        AddAlias(alias_name, "^" .. alias_command, ability_type .. " " .. string.lower(spell_name) .. " at %1", aliasEnabledAndRegex, alias_script)
    else
        AddAlias(alias_name, "^" .. alias_command, ability_type .. " " .. string.lower(spell_name), aliasEnabledAndRegex, alias_script)
    end
    SetAliasOption(alias_name, "send_to", sendto.execute)
end
