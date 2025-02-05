zEffects = require "effects"
require("add_effect")

-- Healer group(s)
zEffects:addNewGroup("unpain", "Unpain")

-- Healer castable spells
addNewSpellAndAlias("brain_unpain", "Brain Unpain", "bup", "/bup (.*)", aliasEnabledAndRegex, nil, 1, nil, "Your brain feels bigger.", "Your brain feels smaller.")
addNewSpellAndAlias("true_unpain", "True Unpain", "tup", "/tup (.*)", aliasEnabledAndRegex, nil, 1, "unpain", "You feel like you could carry the world.", "You feel like crap.")
addNewSpellAndAlias("healing_smoke", "Healing Smoke", "healing_smoke", "/hs", aliasEnabled, nil, 1, nil, "You breathe out a billowy cloud of harmonious smoke.", "Your healing smoke disperses.")
addNewSpellAndAlias("regeneration", "Regeneration", "regen", "/regen (.*)", aliasEnabledAndRegex, nil, 1, nil, "You feel your metabolism speed up.", "You feel your metabolism slow down.")
