zEffects = require "effects"
require("add_effect")

zEffects:addNewGroup("gravemist", "Gravemist")
zEffects:addNewGroup("spectral_armour", "Spectral Armour")

addNewSpellAndAlias("spec", "Spectral Armour", "spec_arm", "/sa (.*)", aliasEnabledAndRegex, nil, 1, "spectral_armour", ".* fades slightly out of view as its figure becomes ghostly, shimmering and translucent\\.", "The air around you is calm once more as the wavering stops\\.")


addNewSpellAndAlias("ddecay", "Diminish Decay", "ddecay", "/dd (.*)", aliasEnabledAndRegex, nil, 1, nil, "You channel some of your deathless essence into .*, bolstering its undead body and its ability to regenerate\\.", "You feel slightly worse as the decay tightens its hold on you\\.")
addNewSpellAndAlias("gmist", "Gravemist", "gmist", "/gm", aliasEnabled, nil, 1, "gravemist", "You utter the words 'ka-chraii ux aam' and an otherworldly mist starts pouring out of your body rapidly permeating the air\\.", "The billow of ghostly mist dissipates\\.")
--zEffects:addNewEffect(key, spell_name, short_name, layers, groups, upMessage, downMessage)
zEffects:addNewEffect("fell_gmist", "Gravemist (fell)", "fellgmist", 1, "gravemist", "You utter the words 'ka-chraii ux aam' and an otherworldly mist starts pouring out of your body and up from the fell gravesite in thick billows to rapidly permeate the air\\.", "The more powerful gravemist present in this location quickly devours that of your making\\.")
