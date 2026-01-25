zEffects = require "effects"
require("add_effect")

function control_spirit_attack()
    local is_in_combat = GetVariable("in_combat")
    if not is_in_combat then
        SetVariable("in_combat", "true")
    end
    local target = GetVariable("target")
    local attack_sksp = GetVariable("attack_sksp")
    Send("cast control at horde kill " .. target)
    -- Send("chain control:" .. attack_sksp .. ":" .. target)
end

--zEffects:addNewGroup("nec_greater", "Necromancer Greater")
--zEffects:addNewGroup("nec_lesser", "Necromancer Lesser")

--zEffects:addNewEffect("ges", "Greater Elemental Shield", "ges", 1, "nec_greater", "An elemental shelter protecting Mortem materializes\\.", "Mortem flashes brightly as energy escapes it\\.")
--zEffects:addNewEffect("lem", "Lesser Magical Shield", "les", 1, "nec_lesser", "A magical shield protecting Mortem materializes\\.", "Mortem twinkles softly as energy escapes it\\.")

zEffects:addNewEffect("bone_armour", "Bone Armour", "BA", 1, {"greater", "lesser"}, "You drain the last functional essence from the corpse and fashion the calcified energy into an impenetrable bulwark around yourself\\.", "The magic binding the armour together fails and the bone casing around your body collapses into nothingness\\.")

addEffectToCheck("nec_greater")
addEffectToCheck("nec_lesser")
addEffectToCheck("bone_armour")