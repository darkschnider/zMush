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

zEffects:addNewEffect("bone_armour", "Bone Armour", "BA", 1, {"greater", "lesser"}, "You drain the last functional essence from the corpse and fashion the calcified energy into an impenetrable bulwark around yourself\\.", "The magic binding the armour together fails and the bone casing around your body collapses into nothingness\\.")

--addEffectToCheck("nec_greater")
--addEffectToCheck("nec_lesser")
--addEffectToCheck("bone_armour")