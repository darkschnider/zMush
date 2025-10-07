zEffects = require "effects"
require("add_effect")

addNewSpellAndAlias("grap", "Ward of Steel", "grap", "/grap (.*)", aliasEnabledAndRegex, nil, 1, "greater", ".* regards you with a focused look in .* eyes and the air around", "The air around you is calm once more as the wavering stops.")
--addNewSpellAndAlias("gpoi", "G. Poison", "gpoi", "/gpoi (.*)", aliasEnabledAndRegex, nil, 1, "greater", "adhesive fluid that tickles your skin.", "The air around you is calm once more as the wavering stops.")
--zEffects:addNewEffect("lcold", "Lesser Cold Resistance (sph)", "lcoldSph")

-- Greater Spheres
zEffects:addNewEffect("gsphfire", "GSphere(Fire)", "gsphfire", 1, "greater", "A shimmering sphere of fire protection envelops you\\.", "Your greater protective sphere against fire damage vanishes\\.")
zEffects:addNewEffect("gsphacid", "GSphere(Acid)", "gsphacid", 1, "greater", "A shimmering sphere of acid protection envelops you\\.", "Your greater protective sphere against acid damage vanishes\\.")
zEffects:addNewEffect("gsphcold", "GSphere(Cold)", "gsphcold", 1, "greater", "A shimmering sphere of cold protection envelops you\\.", "Your greater protective sphere against cold damage vanishes\\.")
zEffects:addNewEffect("gsphpsio", "GSphere(Psio)", "gsphpsio", 1, "greater", "A shimmering sphere of psionic protection envelops you\\.", "Your greater protective sphere against psionic damage vanishes\\.")
zEffects:addNewEffect("gsphelec", "GSphere(Elec)", "gsphelec", 1, "greater", "A shimmering sphere of electric protection envelops you\\.", "Your greater protective sphere against electric damage vanishes\\.")
zEffects:addNewEffect("gsphphys", "GSphere(Phys)", "gsphphys", 1, "greater", "A shimmering sphere of physical protection envelops you\\.", "Your greater protective sphere against physical damage vanishes\\.")
zEffects:addNewEffect("gsphpois", "GSphere(Pois)", "gsphpois", 1, "greater", "A shimmering sphere of poison protection envelops you\\.", "Your greater protective sphere against poison damage vanishes\\.")
zEffects:addNewEffect("gsphmagi", "GSphere(Magi)", "gsphmagi", 1, "greater", "A shimmering sphere of magical protection envelops you\\.", "Your greater protective sphere against magical damage vanishes\\.")
zEffects:addNewEffect("gsphasph", "GSphere(Asph)", "gsphasph", 1, "greater", "A shimmering sphere of asphyxiation protection envelops you\\.", "Your greater protective sphere against asphyxiation damage vanishes\\.")

-- Lesser Spheres
zEffects:addNewEffect("lsphfire", "LSphere(Fire)", "lsphfire", 1, "lesser", "A faint shimmering sphere of fire protection envelops you\\.", "Your lesser protective sphere against fire damage vanishes\\.")
zEffects:addNewEffect("lsphacid", "LSphere(Acid)", "lsphacid", 1, "lesser", "A faint shimmering sphere of acid protection envelops you\\.", "Your lesser protective sphere against acid damage vanishes\\.")
zEffects:addNewEffect("lsphcold", "LSphere(Cold)", "lsphcold", 1, "lesser", "A faint shimmering sphere of cold protection envelops you\\.", "Your lesser protective sphere against cold damage vanishes\\.")
zEffects:addNewEffect("lsphpsio", "LSphere(Psio)", "lsphpsio", 1, "lesser", "A faint shimmering sphere of psionic protection envelops you\\.", "Your lesser protective sphere against psionic damage vanishes\\.")
zEffects:addNewEffect("lsphelec", "LSphere(Elec)", "lsphelec", 1, "lesser", "A faint shimmering sphere of electric protection envelops you\\.", "Your lesser protective sphere against electric damage vanishes\\.")
zEffects:addNewEffect("lsphphys", "LSphere(Phys)", "lsphphys", 1, "lesser", "A faint shimmering sphere of physical protection envelops you\\.", "Your lesser protective sphere against physical damage vanishes\\.")
zEffects:addNewEffect("lsphpois", "LSphere(Pois)", "lsphpois", 1, "lesser", "A faint shimmering sphere of poison protection envelops you\\.", "Your lesser protective sphere against poison damage vanishes\\.")
zEffects:addNewEffect("lsphmagi", "LSphere(Magi)", "lsphmagi", 1, "lesser", "A faint shimmering sphere of magical protection envelops you\\.", "Your lesser protective sphere against magical damage vanishes\\.")
zEffects:addNewEffect("lsphasph", "LSphere(Asph)", "lsphasph", 1, "lesser", "A faint shimmering sphere of asphyxiation protection envelops you\\.", "Your lesser protective sphere against asphyxiation damage vanishes\\.")

addNewSpellAndAlias("iw", "Iron Will", "iw", "/iw (.*)", aliasEnabledAndRegex, nil, 1, "stun", "^[A-Z][a-z]+ stares deep into your eyes, bolstering your concentration greatly\\.$|^You turn your mind inwards, enchanting yourself with an aura of rigid concentration\\. $", "Your Iron Will wears off\\.")
addNewSpellAndAlias("eh", "Energy Hauberk", "eh", "/eh (.*)", aliasEnabledAndRegex, nil, 1, nil, "With a flash a shining hauberk of pure energy encases you\\.$|^hauberk around yourself\\.$", "The energy surrounding your body dwindles away\\.")