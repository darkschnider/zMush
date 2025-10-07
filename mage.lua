zEffects = require "effects"
require("add_effect")

addNewSpellAndAlias("eh", "Energy Hauberk", "eh", "/eh (.*)", aliasEnabledAndRegex, nil, 1, nil, "hauberk around yourself\\.", "The energy surrounding your body dwindles away\\.")
addNewSpellAndAlias("movmir", "Moving Mirrors", "moveMirrors", "/mmirrors (.*)", aliasEnabledAndRegex, nil, 1, nil, "many images of yourself appear\\.", "You have no more mirror images!")
addNewSpellAndAlias("mimg", "Mirror Image", "mimage", "/mimage (.*)", aliasEnabledAndRegex, nil, 1, nil, "[one|two|three|four|five] images of yourself appear\\.", "Your flesh armor dissipates\\.")