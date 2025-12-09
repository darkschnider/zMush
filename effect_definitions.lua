zEffects = require "effects"
require("add_effect")

zEffects:addNewGroup("greater", "Greater")
zEffects:addNewGroup("lesser", "Lesser")
zEffects:addNewGroup("stun", "Stun Protection")

zEffects:addNewEffect("blurred_image", "Blurred Image", "BI", 1, nil, "You enchant the air around you, blurring your outlines\\.", "Your blur wears off\\.")

zEffects:addNewEffect("holy_wisdom", "Holy Wisdom", "hwis", 1, nil, "You feel wiser as holy wisdom expands your mind\\.", "You feel the wisdom leaving you\\.")

--zEffects:addNewEffect("darkness", "Darkness", "dark", 1, nil, "You summon a circle of darkness\\.", "The darkness spell wears off\\.")
zEffects:addNewEffect("beckon_darkness", "Beckon Darkness", "beckon", 1, nil, "You call forth a dark cloud, which quickly engulfs you within in its murky bosom\\.", "The darkness spell wears off\\.")
zEffects:addNewEffect("batform", "na-na-na-na-na-na-na-na-Batman!", "batform", 1, nil, "the transformation shakes your body, turning you into a bat\\.", "You close your wings around yourself, transforming back into a vampire\\.$|^Without warning, you suddenly transform back into a vampire\\.")

zEffects:addNewEffect("water_walking", "Water Walking", "wwalk", 1, nil, "You feel lighter\\.", "You feel heavy\\.")
zEffects:addNewEffect("coin", "Coin", "coin", 1, nil, "You catch the shining golden coin as it falls down: (tails|heads)","The golden coin does not seem to shine so brightly anymore\\.")
