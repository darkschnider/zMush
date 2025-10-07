require "add_effect"
zEffects = require "effects"
local trigFlags = 33 -- Enabled | RegularExpression

using_bag_of_holding = false

DeleteTrigger("luaBagOfHolding")
AddTriggerEx("luaBagOfHolding", "^You summon forth a bag of holding\\.$", "using_bag_of_holding = true", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
