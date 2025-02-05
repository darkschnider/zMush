zEffects = require "effects"

aliasEnabledAndRegex = 129
aliasEnabled = 1

function addNewSpellAndAlias(key, spell_name, short_name, alias_command, alias_flags, alias_script, layers, groups, upMessage, downMessage)
    local alias_name = "luaAlias" .. short_name
    local alreadyExists = GetAlias(alias_name)
    if alreadyExists ~= eAliasNotFound then
        DeleteAlias(alias_name)
    end
    if (alias_flags == 129) then
        AddAlias(alias_name, alias_command, "cast " .. string.lower(spell_name) .. " at %1", alias_flags, alias_script)
    else
        AddAlias(alias_name, alias_command, "cast " .. string.lower(spell_name), alias_flags, alias_script)
    end
    --SetAliasOption(alias_name, "omit_from_command_history", "y")
    SetAliasOption(alias_name, "send_to", sendto.execute)

    zEffects:addNewEffect(key, spell_name, short_name, layers, groups, upMessage, downMessage)
end
