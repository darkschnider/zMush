zEffects = require "effects"
require("add_effect")
require("util")
local trigFlags = 33 -- Enabled | RegularExpression

-- Delete existing Effect Definitions groups before recreating
DeleteTriggerGroup("Effect Definitions")

-- Effect Groups
zEffects:addNewGroup("stun", "Stun Protection")
zEffects:addNewGroup("unpain", "Unpain")
zEffects:addNewGroup("monk_pref", "Monk Preference")
zEffects:addNewGroup("blade_enchant", "Blade Enchant")
zEffects:addNewGroup("blade_element", "Blade Element")
zEffects:addNewGroup("greater_shield", "Greater Shield")
zEffects:addNewGroup("lesser_shield", "Lesser Shield")
zEffects:addNewGroup("greater", "Greater")
zEffects:addNewGroup("lesser", "Lesser")
zEffects:addNewGroup("skin", "Skin")

-- Stun Protection Group
zEffects:addNewEffect("stun_resistance", "Stun Resistance", "SR", 1, "stun", "Neverwhere wobbles around a bit\\.", "Your stun resistance wears off\\.")
zEffects:addNewEffect("iron_will", "Iron Will", "IW", 1, "stun", "[A-Z][a-z]+ stares deep into your eyes, bolstering your concentration greatly\\.$|^You turn your mind inwards, enchanting yourself with an aura of rigid concentration\\.", "Your Iron Will wears off\\.")

-- Flight
zEffects:addNewEffect("flight", "Flight", "flight", 1, nil, "You become lighter than the air, wow you feel like you could fly!", "You feel a bit heavier\\.")

-- Harmony Spells
zEffects:addNewEffect("preparation_of_harmony", "Prep. of Harmony", "PREP", 1, nil, "You feel like you might be ready for harmony\\.", "You feel less prepared for harmony\\.")
zEffects:addNewEffect("harmonious_barrier", "Harmonious Barrier", "HBAR", 1, nil, "You feel enveloped in harmony\\.", "You are no longer enveloped in harmony\\.")
zEffects:addNewEffect("harmony_armour", "Harmony Armour", "HA", 1, nil, "You feel in complete harmony\\.", "You no longer feel harmonious\\.")

-- Mind Protection
zEffects:addNewEffect("barrier_of_the_mind", "Barrier of the Mind", "barrier_of_the_mind", 1, nil, "You feel as if a protective barrier surrounds your fragile mind\\.", "You feel a slight tingle somewhere deep inside your mind\\.")
zEffects:addNewEffect("force_shield", "Force Shield", "FS", 1, nil, "[A-Z][a-z]+ surrounds you with a telekinetic shield of force\\.", "The force shield dissipates\\.")

-- Unpain Group
zEffects:addNewEffect("minor_unpain", "Minor Unpain", "MUP", 1, "unpain", "You feel more sturdy\\.", "You feel a little like crap\\.")
zEffects:addNewEffect("true_unpain", "True Unpain", "TUP", 1, "unpain", "You feel like you could carry the world\\.", "You feel like crap\\.")
zEffects:addNewEffect("brain_unpain", "Brain Unpain", "BUP", 1, nil, "Your brain feels bigger\\.", "Your brain feels smaller\\.")

-- Monk Preference Group
zEffects:addNewEffect("call_for_thunder", "Call for Thunder", "call_for_thunder", 1, "monk_pref", "Suddenly your body flashes bright white inviting the lightning to strike at your knuckles\\.", "Your body doesnt seem to sizzle anymore")
zEffects:addNewEffect("call_for_fire", "Call for Fire", "call_for_fire", 1, "monk_pref", "Suddenly bright flames burst out from your toes and flash over your body ending up into your knuckles\\.", "The flames around you grow weaker and disappear")
zEffects:addNewEffect("call_for_ice", "Call for Ice", "call_for_ice", 1, "monk_pref", "Suddenly your eyes freeze into two clear blocks of ice for a moment before they slide away down your arms into your knuckles\\.", "You feel your body temperature rise back as ice melts")

-- Combat Skills
zEffects:addNewEffect("adrenaline_rush", "Adrenaline Rush", "adrenaline_rush", 1, nil, "You are bursting with energy!!!", "Exhaustion washes over you as the adrenaline begins to leave your bloodstream\\.\\.")
zEffects:addNewEffect("berserk", "Berserk", "berserk", 1, nil, "You bellow in rage and you must kill!", "You come out of your berserk!")
zEffects:addNewEffect("combat_trance", "Combat Trance", "combat_trance", 1, nil, "Your movements are now more focused and your mind is calm\\.", "You lose your concentration and fight with less precision\\.")
zEffects:addNewEffect("energy_hauberk", "Energy Hauberk", "EH", 1, nil, "With a flash a shining hauberk of pure energy encases you\\.$|^hauberk around yourself\\.", "The energy surrounding your body dwindles away\\.")
zEffects:addNewEffect("inner_power", "Inner Power", "IP", 1, nil, "You feel inner strength increasing\\.", "You feel your inner power decreasing\\.")

-- Image/Vision Spells
zEffects:addNewEffect("blurred_image", "Blurred Image", "BI", 1, nil, "You enchant the air around you, blurring your outlines\\.|^[A-Z][a-z]+ enchants the air around you, blurring your figure\\.$", "Your blur wears off\\.")
zEffects:addNewEffect("regeneration", "Regeneration", "Regen", 1, nil, "You feel your metabolism speed up\\.", "Your metabolism slows back down\\.")
zEffects:addNewEffect("light", "Light", "light", 1, nil, "You summon a magical ball of light\\.", "The light spell wears off\\.")
zEffects:addNewEffect("darkness", "Darkness", "dark", 1, nil, "You call forth a dark cloud, which quickly engulfs you within in its murky bosom\\.|You summon a circle of darkness\\.", "The darkness spell wears off\\.")
zEffects:addNewEffect("infravision", "Infravision", "infra", 1, nil, "You feel like you can see in the dark\\.", "Your vision is a bit less red\\.")
zEffects:addNewEffect("wolf_eyes", "Wolf Eyes", "wolf_eyes", 1, nil, "Your eyes gleam yellow and your night vision improves\\.", "Your yellow wolf eyes turn back to normal\\.")

-- Healing/Support
zEffects:addNewEffect("healing_smoke", "Healing Smoke", "healing_smoke", 1, nil, "You breathe out a billowy cloud of harmonious smoke\\.", "Your healing smoke disperses\\.")
zEffects:addNewEffect("heavy_weight", "Heavy Weight", "heavy_weight", 1, nil, "You feel magically heavier\\.", "You feel lighter\\.")

-- Debuffs
zEffects:addNewEffect("blind", "Blind", "blind", 1, nil, "[A-Za-z,-:\\' ]+ blinds you\\.", "You are able to see again\\.")
zEffects:addNewEffect("wall_of_steel", "Wall of Steel", "wall_of_steel", 1, nil, "You lift up your shield\\.", "Your hand starts to ache, forcing you to lower your shield\\.|Your offensive maneuver proves out more demanding than you thought")

-- Blade Enchant Group
zEffects:addNewEffect("ghorux_blade", "Ghorux Blade", "ghorux_blade", 1, "blade_enchant", "You cast a ghorux blade spell at your sword\\.", "Ghorux blade looses it\\'s magical power\\.")
zEffects:addNewEffect("jigoku_blade", "Jigoku Blade", "jigoku_blade", 1, "blade_enchant", "the spiritual forces of evil\\.", "The dark spiritual forces of the Jigoku Blade twindle away\\.")
zEffects:addNewEffect("tenrai_blade", "Tenrai Blade", "tenrai_blade", 1, "blade_enchant", "the spiritual forces of good\\.", "The benign spiritual forces of the Tenrai Blade twindle away\\.")

-- Blade Element Group
zEffects:addNewEffect("fire_blade", "Fire Blade", "fire_blade", 1, "blade_element", "Your sword begins to glow with the faintest glow of elemental fire\\.", "Your fireblade spell wears off\\.")
zEffects:addNewEffect("acid_blade", "Acid Blade", "acid_blade", 1, "blade_element", "Your sword begins to glow with the faintest yellow light\\.", "Your acidblade spell wears off\\.")
zEffects:addNewEffect("poison_blade", "Poison Blade", "poison_blade", 1, "blade_element", "Your sword begins to glow with the dark green hue of poison\\.", "Your poisonblade spell wears off\\.")

-- Neutralize blade trigger
AddTriggerEx("neutralize_blade", "^Your spirit touches the blade, cleansing it of elemental powers\\.$", [[
    if zEffects:on('fire_blade') then zEffects:off('fire_blade') end
    if zEffects:on('acid_blade') then zEffects:off('acid_blade') end
    if zEffects:on('poison_blade') then zEffects:off('poison_blade') end
]], trigFlags, custom_colour.Custom6, 0, "", "", sendto.script, 100)
SetTriggerOption("neutralize_blade", "group", "Effect Definitions")

-- More Debuffs
zEffects:addNewEffect("slow_person", "Slow Person", "slow_person", 1, nil, "You feel like lagged\\.", "You no longer feel lagged\\.")
zEffects:addNewEffect("glue", "Glue", "glue", 1, nil, "Your feet are covered with slimy matter\\.", "You can move again\\.")
zEffects:addNewEffect("see_magic", "See Magic", "see_magic", 1, nil, "Your vision seems more sensitive\\.", "Your vision feels less sensitive\\.")
zEffects:addNewEffect("shadow_shield", "Shadow Shield", "shadow_shield", 1, nil, "[A-Z][a-z]+ draws a protective circle in the air and shadows cover your body\\.$|You draw a protective circle in the air around yourself and shadows", "The shadows lift from your body\\.")
zEffects:addNewEffect("summon_orb_of_reflection", "Orb of Reflection", "summon_orb_of_reflection", 1, nil, "An orb of reflection appears in the room\\.", "You banish the orb back to chaos-continuum\\.")

-- Magical Movement
zEffects:addNewEffect("smwalk", "Magical Walking", "smwalk", 1, nil, "You start walking magically\\.", "Your magical walking wears off\\.")
zEffects:addNewEffect("sspirit", "Inner Spirit", "sspirit", 1, nil, "You open your eyes with new found confidence\\.", "The teachings of your ancestors fade from your mind as the aches and")

-- Combat States
zEffects:addNewEffect("kamikaze", "Kamikaze", "kamikaze", 1, nil, "You start your Kamikaze attack!", "You calm down\\.")
zEffects:addNewEffect("forget", "Forget", "forget", 1, nil, "You feel stoopid\\.|Lich assaults your mind, you feel excruciating pain\\.", "For some reason or another\\.\\. you feel smarter\\.")
zEffects:addNewEffect("poison", "Poison", "poison", 1, nil, "You shiver and suffer as the POISON takes effect!", "[A-Z][a-z]+ neutralizes the poison in your veins\\.")

-- Water Spells
zEffects:addNewEffect("water_breathing", "Water Breathing", "wb", 1, nil, "[A-Z][a-z]+ puts a protective blue aura around your head\\.$|You put a protective blue aura around your head\\.", "You are no longer able to breathe underwater\\.")
zEffects:addNewEffect("water_walking", "Water Walking", "ww", 1, nil, "([A-Z][a-z]+) looks a bit different\\.$|^You give ([A-Z][a-z]+) an ability to avoid water\\.", "You feel heavy\\.")

-- Nature Spells
zEffects:addNewEffect("spirit_of_nature", "Spirit of Nature", "spirit_of_nature", 1, nil, "You feel (strong|nimble|tough) as (a|an) (bear|eagle|drake) as the spirit of the (forest|mountain|desert) strenghtens you!", "You suddenly feel cold as the presence leaves your body\\.")
zEffects:addNewEffect("eyes_of_the_marksman", "Eyes of the Marksman", "eyes_of_the_marksman", 1, nil, "Your eyes flash in silky colours\\.", "You feel a pinch in your eyes\\.")

-- Invisibility/Transformation
zEffects:addNewEffect("invisibility", "Invisibility", "invisibility", 1, nil, "You turn invisible[.!]$|Your true mastery allows you to turn invisible!", "You turn visible again\\.")
zEffects:addNewEffect("transformation", "Transformation", "transformation", 1, nil, "You shriek in pain as your entire body begins to transform!", "With a violent convulsion, you return to your normal form\\.")

-- Elixirs
zEffects:addNewEffect("elixir_of_charisma", "Elixir of Charisma", "elixir_of_charisma", 1, nil, "", "The Elixir of Charisma drains from your system\\.")
zEffects:addNewEffect("elixir_of_constitution", "Elixir of Constitution", "elixir_of_constitution", 1, nil, "", "The Elixir of Constitution drains from your system\\.")
zEffects:addNewEffect("elixir_of_dexterity", "Elixir of Dexterity", "elixir_of_dexterity", 1, nil, "", "The Elixir of Dexterity drains from your system\\.")
zEffects:addNewEffect("elixir_of_intelligence", "Elixir of Intelligence", "elixir_of_intelligence", 1, nil, "", "The Elixir of Intelligence drains from your system\\.")
zEffects:addNewEffect("elixir_of_restoration", "Elixir of Restoration", "elixir_of_restoration", 1, nil, "", "The Elixir of Restoration drains from your system\\.")
zEffects:addNewEffect("elixir_of_stamina", "Elixir of Stamina", "elixir_of_stamina", 1, nil, "", "The Elixir of Stamina drains from your system\\.")
zEffects:addNewEffect("elixir_of_strength", "Elixir of Strength", "elixir_of_strength", 1, nil, "", "The Elixir of Strength drains from your system\\.")
zEffects:addNewEffect("elixir_of_wisdom", "Elixir of Wisdom", "elixir_of_wisdom", 1, nil, "", "The Elixir of Wisdom drains from your system\\.")

-- Salves
zEffects:addNewEffect("salve_of_physical_resistance", "Salve of Physical Resistance", "salve_of_physical_resistance", 1, nil, "", "The Salve of Physical Resistance dries up and flakes off\\.")
zEffects:addNewEffect("salve_of_magic_resistance", "Salve of Magic Resistance", "salve_of_magic_resistance", 1, nil, "", "The Salve of Magical Resistance dries up and flakes off\\.")
zEffects:addNewEffect("salve_of_fire_resistance", "Salve of Fire Resistance", "salve_of_fire_resistance", 1, nil, "", "The Salve of Fire Resistance dries up and flakes off\\.")
zEffects:addNewEffect("salve_of_cold_resistance", "Salve of Cold Resistance", "salve_of_cold_resistance", 1, nil, "", "The Salve of Cold Resistance dries up and flakes off\\.")
zEffects:addNewEffect("salve_of_acid_resistance", "Salve of Acid Resistance", "salve_of_acid_resistance", 1, nil, "", "The Salve of Acid Resistance dries up and flakes off\\.")
zEffects:addNewEffect("salve_of_psionic_resistance", "Salve of Psionic Resistance", "salve_of_psionic_resistance", 1, nil, "", "The Salve of Psionic Resistance dries up and flakes off\\.")
zEffects:addNewEffect("salve_of_asphyxiation_resistance", "Salve of Asphyxiation Resistance", "salve_of_asphyxiation_resistance", 1, nil, "", "The Salve of Asphyxiation Resistance dries up and flakes off\\.")
zEffects:addNewEffect("salve_of_electrical_resistance", "Salve of Electrical Resistance", "salve_of_electrical_resistance", 1, nil, "", "The Salve of Electrical Resistance dries up and flakes off\\.")
zEffects:addNewEffect("salve_of_poison_resistance", "Salve of Poison Resistance", "salve_of_poison_resistance", 1, nil, "", "The Salve of Poison Resistance dries up and flakes off\\.")

-- Misc Effects
zEffects:addNewEffect("resist_heal", "Resist Heal", "RH", 1, nil, "You feel weird\\.", "You feel normal again\\.")
zEffects:addNewEffect("mind_development", "Mind Development", "MD", 1, nil, "You feel smart\\.", "You feel stupid\\.")
zEffects:addNewEffect("enlightenment", "Enlightenment", "ENLIGHT", 1, nil, "You feel wiser\\.", "You feel less wise\\.")
zEffects:addNewEffect("holy_wisdom", "Holy Wisdom", "HWIS", 1, nil, "You feel wiser as holy wisdom expands your mind\\.", "You feel the wisdom leaving you\\.")
zEffects:addNewEffect("viscous_flesh", "Viscious Flesh", "viscous_flesh", 1, nil, "You concentrate on your body, and its composition is revealed to your", "The viscous black substance is absorbed by your skin, and so it disappears\\.")
zEffects:addNewEffect("mind_linked", "Mind Linked", "mind_linked", 1, nil, "You think that you\\'re not alone in your head\\.", "You feel alone in your head again\\.")
zEffects:addNewEffect("lions_heart", "Lion's Heart", "lions_heart", 1, nil, "Your heart is that of a Lion!", "The Courage of the Lion leaves you\\.")

-- Greater Shield Group
zEffects:addNewEffect("greater_elemental_shield", "Greater Elem Shield", "GES", 1, "greater_shield", "An elemental shelter protecting Mortem materializes\\.", "Mortem flashes brightly as energy escapes it\\.")

-- Lesser Shield Group
zEffects:addNewEffect("lesser_magical_shield", "Lesser Mag Shield", "LMS", 1, "lesser_shield", "A magical shield protecting Mortem materializes\\.", "Mortem twinkles softly as energy escapes it\\.")

-- Greater Protections
zEffects:addNewEffect("infernal_vestment", "Infernal Vestment", "GCOLD", 1, "greater", "burning with transcendental ardor\\.", "A great chill washes over you as the magical warmth leaves you\\.")
zEffects:addNewEffect("ward_of_steel", "Ward of Steel", "GPHYS", 1, "greater", "you starts to waver vigorously\\.|The air around you starts to waver vigorously\\.", "The air around you is calm once more as the wavering stops\\.")
zEffects:addNewEffect("venom_fend", "Venom Fend", "GPOIS", 1, "greater", "an otherworldly fervor rushing through your veins\\.|Envisaging the arteries, you inject yourself with an arcane", "The blazing fervor in your veins is gone\\.")
zEffects:addNewEffect("winters_rebuke", "Winter's Rebuke", "GFIRE", 1, "greater", "feel the hand of winter gripping you gently\\.", "The freezing grip of winter disappears and you feel comfortably warm again\\.")
zEffects:addNewEffect("corrosive_opposition", "Corrosive Opposition", "GACID", 1, "greater", "substance that irritates your skin\\.|You clench your fist and manipulate the air around you", "The irritating viscid substance on your skin disappears\\.")
zEffects:addNewEffect("psychic_aegis", "Psychic Aegis", "GPSIO", 1, "greater", "form around your soul\\.|You place your hand on your forehead and a soothing barrier forms", "The soothing void around your soul is no more\\.")
zEffects:addNewEffect("arcane_bulwark", "Arcane Bulwark", "GMAGI", 1, "greater", "around you, cascading down in waves and back up again,", "The swirling shell of effulgent magic around you vanishes\\.")
zEffects:addNewEffect("lightning_guard", "Lightning Guard", "GELEC", 1, "greater", "making you spasm as it settles into your body\\.|With a strong pulling motion of your outstreched hands an", "The world flashes around you and with a quick spasm the magic in your body disappears\\.")
zEffects:addNewEffect("resist_void", "Resist Void", "GASPH", 1, "greater", "the magic is absorbed into your body\\.|You inhale hard and a gust of wind blows against your face, ", "You gasp for air as a choking feeling passes over you\\.")

-- Lesser Protections
zEffects:addNewEffect("vestment_of_flame", "Vestment of Flame", "LCOLD", 1, "lesser", "slowly revolving around you\\. The magic settles finally on your", "You feel cold and exposed as the magical warmth leaves you\\.")
zEffects:addNewEffect("ward_of_stone", "Ward of Stone", "LPHYS", 1, "lesser", "[A-Z][a-z]+ eyes you attentively and the air around you starts to ripple\\.$|You concentrate your thoughts and channel a great amount of", "The air around you is calm once more as the rippling stops\\.")
zEffects:addNewEffect("poison_fend", "Poison Fend", "LPOIS", 1, "lesser", "feel an unnatural warmth coursing through your veins\\.|Envisaging the arteries, you inject yourself with a mystic", "The warmth in your veins is gone\\.")
zEffects:addNewEffect("rebuke_of_ice", "Rebuke of Ice", "LFIRE", 1, "lesser", "you feel a chill climbing up your spine\\.|You trace a circle in the air and a shining circumference of blue", "The chill in your bones is gone and you feel comfortably warm again\\.")
zEffects:addNewEffect("caustic_opposition", "Caustic Opposition", "LACID", 1, "lesser", "adhesive fluid that tickles your skin\\.|You close your fist and manipulate the air around you", "The tickling adhesive fluid on your skin disappears\\.")
zEffects:addNewEffect("mental_aegis", "Mental Aegis", "LPSIO", 1, "lesser", "emptiness settle in your mind\\.|You tap yourself lightly on the forehead and a relaxing shelter", "The relaxing emptiness in your mind is no more\\.")
zEffects:addNewEffect("mystic_bulwark", "Mystic Bulwark", "LMAGI", 1, "lesser", "you, spiralling up and down, like a whirlwind of stardust\\.|You point your index finger forward, and a sizzling stream", "The whirlwind of protective magic around you vanishes\\.")
zEffects:addNewEffect("spark_shelter", "Spark Shelter", "LELEC", 1, "lesser", "energy leaps at you\\. The magic penetrates your chest, and|With a withdrawing motion of your outstreched hands a", "Your surroundings flash and with a shiver the magic in your body disappears\\.")
zEffects:addNewEffect("endure_void", "Endure Void", "LASPH", 1, "lesser", "magic is absorbed into your body\\.|You breathe in and a light breeze brushes against your", "You have trouble breathing for a moment\\.")

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

-- Multi-group Effects
zEffects:addNewEffect("armour_of_god", "Armour of God", "AOG", 1, "lesser greater", "A shining robe of glowing silver surrounds you\\.$|^Shining vestments of glowing silver surround you\\.$|^A shining suit of glowing silver mail surrounds you\\.", "The Armour of God surrounding you fades away\\.")
zEffects:addNewEffect("protection_from_good", "Protection from Good", "PFG", 1, "lesser greater", "A sizzling red aura surrounds you\\.", "The red aura surrounding you vanishes\\.")

-- Vulnerabilities
zEffects:addNewEffect("fragile_frame", "Fragile Frame", "fragile_frame", 1, nil, "weakened by a spell\\. ", "You feel robust again as the spell ends\\.")
zEffects:addNewEffect("mystic_impairment", "Mystic Impairment", "mystic_impairment", 1, nil, "creating a magenta aura around you\\. ", "The aura surrounding you snaps out of existence\\.")
zEffects:addNewEffect("incendiary_coating", "Incendiary Coating", "incendiary_coating", 1, nil, "incendiary coating on you\\. ", "The incendiary substance on you evaporates\\.")
zEffects:addNewEffect("deprive_warmth", "Deprive Warmth", "deprive_warmth", 1, nil, "as you feel like you are naked in a blizzard storm\\. ", "Your bodily temperature seems to be normal again\\.")
zEffects:addNewEffect("vitriolic_bane", "Vitriolic Bane", "vitriolic_bane", 1, nil, "a strange tawny hue\\. ", "Your skin feels thick and healthy again as the bane disappears\\.")
zEffects:addNewEffect("languished_soul", "Languished Soul", "languished_soul", 1, nil, "light lances at you\\. ", "You snap out of your languid mood\\.")
zEffects:addNewEffect("labored_breathing", "Labored Breathing", "labored_breathing", 1, nil, "feels arduous\\. ", "The ebon cloud disappears and you feel relieved as breathing is easier\\.")
zEffects:addNewEffect("energetic_frailty", "Energetic Frailty", "energetic_frailty", 1, nil, "you crackles and electrifies\\. ", "You feel grounded and comfortable again\\.")
zEffects:addNewEffect("blemished_health", "Blemished Health", "blemished_health", 1, nil, "breathe out turns miasmic and jade green\\. ", "You feel healthy again as the mephitic bane is gone\\.")
zEffects:addNewEffect("multivuln", "Multivuln", "multivuln", 1, nil, "You feel your resistances weakening\\.", "You feel your resistances returning to normal\\.")

-- Protective Spells
zEffects:addNewEffect("amorphic_armour", "Amorphic Armour", "va", 2, nil, "[A-Z][a-z]+ casts a protective spell on you\\.$|^You cast a protective spell on (.+)\\.", "Your Amorphic Armour spell wears off\\.")

-- Skin Group
zEffects:addNewEffect("stoneskin", "Stoneskin", "SSKIN", 2, "skin", "Granite plates form over your skin\\.", "Your stoneskin crumbles and drops off\\.")
zEffects:addNewEffect("barkskin", "Barkskin", "BSKIN", 2, "skin", "Your skin turns green and fissures, thickening into a layer of tough bark\\.", "Your barkskin wears off\\.")

-- Shield of Protection
zEffects:addNewEffect("shield_of_protection", "Shield of Protection", "SOP", 2, nil, "You form a barrier of repulsive magic around yourself\\.$|^You are surrounded by a green glow\\.", "Your protection spell wears off\\.")

-- Displacement
zEffects:addNewEffect("displacement", "Displacement", "DISP", 2, nil, "[A-Z][a-z]+ displaces your image\\.$|^You displace ([A-Z][a-z]+)\\'s image\\.", "Your displacement wears off\\.")
