zEffects = require "effects"
require("add_effect")


zEffects:addNewGroup("nec_greater", "Necromancer Greater")
zEffects:addNewGroup("nec_lesser", "Necromancer Lesser")
zEffects:addNewEffect("ges", "Greater Elemental Shield", "ges", 1, "nec_greater", "An elemental shelter protecting Mortem materializes\\.", "Mortem flashes brightly as energy escapes it\\.")
zEffects:addNewEffect("lem", "Lesser Magical Shield", "les", 1, "nec_lesser", "A magical shield protecting Mortem materializes\\.", "Mortem twinkles softly as energy escapes it\\.")

zEffects:addNewGroup("greater", "Greater")
zEffects:addNewGroup("lesser", "Lesser")
zEffects:addNewGroup("stun", "Stun Protection")

zEffects:addNewEffect("bone_armour", "Bone Armour", "BA", 1, {"greater", "lesser"}, "You drain the last functional essence from the corpse and fashion the calcified energy into an impenetrable bulwark around yourself\\.", "The magic binding the armour together fails and the bone casing around your body collapses into nothingness\\.")

zEffects:addNewEffect("blurred_image", "Blurred Image", "BI", 1, nil, "You enchant the air around you, blurring your outlines\\.", "Your blur wears off\\.")

zEffects:addNewEffect("holy_wisdom", "Holy Wisdom", "hwis", 1, nil, "You feel wiser as holy wisdom expands your mind\\.", "You feel the wisdom leaving you\\.")

--zEffects:addNewEffect("darkness", "Darkness", "dark", 1, nil, "You summon a circle of darkness\\.", "The darkness spell wears off\\.")
zEffects:addNewEffect("beckon_darkness", "Beckon Darkness", "beckon", 1, nil, "You call forth a dark cloud, which quickly engulfs you within in its murky bosom\\.", "The darkness spell wears off\\.")
zEffects:addNewEffect("batform", "na-na-na-na-na-na-na-na-Batman!", "batform", 1, nil, "the transformation shakes your body, turning you into a bat\\.", "You close your wings around yourself, transforming back into a vampire\\.$|^Without warning, you suddenly transform back into a vampire\\.")

zEffects:addNewEffect("water_walking", "Water Walking", "wwalk", 1, nil, "You feel lighter\\.", "You feel heavy\\.")
zEffects:addNewEffect("coin", "Coin", "coin", 1, nil, "You catch the shining golden coin as it falls down: (tails|heads)","The golden coin does not seem to shine so brightly anymore\\.")
