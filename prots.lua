----
-- Protective Spells and Skills
-- MUSHClient aliases for various spells/skills using do_prot
----

require("do_prot")

-- Delete existing Prots group before recreating
DeleteAliasGroup("Prots")

-- Short aliases
AddAlias("luaAliasCombatTrance", "^/ct(.*)$", "combat_trance(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasBlurredImage", "^/blurr(.*)$", "blurred_image(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasBI", "^/bi(.*)$", "blurred_image(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasEnergyHauberk", "^/eh(.*)$", "energy_hauberk(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasEnlargeWeapon", "^/eweap(.*)$", "enlarge_weapon(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasFirstAid", "^/fa(.*)$", "first_aid(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasHeavyWeight", "^/hw(.*)$", "heavy_weight(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasInfravision", "^/infra(.*)$", "infravision(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasInnerPower", "^/ip(.*)$", "inner_power(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasIronWill", "^/iw(.*)$", "iron_will(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasRegeneration", "^/regen(.*)$", "regeneration(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasRelocate", "^/reloc(.*)$", "relocate(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasRemovePoison", "^/rp(.*)$", "remove_poison(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasReduceWeapon", "^/rweap(.*)$", "reduce_weapon(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasShieldOfProtection", "^/sop (.*)", "shield_of_protection(%1)", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasTeleportWithoutError", "^/twe(.*)$", "teleport_without_error(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("luaAliasWaterWalking", "^/ww(.*)$", "water_walking(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Set all aliases to "Prots" group and send to script
local prots_aliases = {
  "luaAliasCombatTrance", "luaAliasBlurredImage", "luaAliasBI", "luaAliasEnergyHauberk", "luaAliasEnlargeWeapon",
  "luaAliasFirstAid", "luaAliasHeavyWeight", "luaAliasInfravision", "luaAliasInnerPower",
  "luaAliasIronWill", "luaAliasRegeneration", "luaAliasRelocate", "luaAliasRemovePoison",
  "luaAliasReduceWeapon", "luaAliasShieldOfProtection", "luaAliasTeleportWithoutError", "luaAliasWaterWalking"
}

for _, alias_name in ipairs(prots_aliases) do
  SetAliasOption(alias_name, "group", "Prots")
  SetAliasOption(alias_name, "send_to", sendto.script)
end

----
-- Spell/Skill functions (A-D)
----

function acid_blade()
    do_prot({a = "cast", s = "acid blade", n = "Corroding Blade"})
end

function adrenaline_rush()
    do_prot({a = "use", s = "adrenaline rush", n = "Getting an Adrenaline Rush"})
end

function amorphic_armour(target_arg)
    do_prot({a = "cast", s = "amorphic armour", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", A = "healing"})
end

function anti_magic_field()
    do_prot({a = "cast", s = "anti-magic field", n = "Casting Anti-Magic Field"})
end

function arcane_bulwark(target_arg)
    do_prot({a = "cast", s = "arcane bulwark", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Arcane Bulwark (g_magic)"})
end

function armour_of_god(target_arg)
    do_prot({a = "cast", s = "armour of god", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", A = "healing"})
end

function aura_detection(target_arg)
    do_prot({a = "cast", s = "aura detection", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", A = "healing"})
end

function balance_axe(target_arg)
    do_prot({a = "cast", s = "balance axe", t = target_arg or "axe", n = "Balancing"})
end

function banish(target_arg)
    do_prot({a = "cast", s = "banishment", t = target_arg ~= "" and target_arg or GetVariable("target") or "", n = "Banishment", q = true})
end

function barkskin(target_arg)
    do_prot({a = "cast", s = "barkskin", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", A = "healing"})
end

function berserk()
    do_prot({a = "use", s = "berserk", n = "Going Berserk"})
end

function bless(target_arg)
    do_prot({a = "use", s = "bless", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Blessing", d = "think"})
end

function blurred_image(target_arg)
    do_prot({a = "cast", s = "blurred image", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", A = "healing"})
end

function bond_of_fates(target_arg)
    do_prot({a = "cast", s = "bond of fates", t = target_arg})
end

function brain_unpain(target_arg)
    do_prot({a = "cast", s = "brain unpain", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", A = "healing"})
end

function call_for_fire()
    do_prot({a = "use", s = "call for fire", n = "Calling for Fire"})
end

function call_for_ice()
    do_prot({a = "use", s = "call for ice", n = "Calling for Ice"})
end

function call_for_thunder()
    do_prot({a = "use", s = "call for thunder", n = "Calling for Thunder"})
end

function call_upon_unity(target_arg)
    do_prot({a = "use", s = "call upon unity", t = target_arg or "all"})
end

function calm_down()
    -- Note: pluralize(ignores, 'ignore') would need implementation
    do_prot({a = "use", s = "calm down", n = "Calming (ignores)"})
end

function cancellation(target_arg)
    do_prot({a = "cast", s = "cancellation", t = target_arg})
end

function cannibalize(target_arg)
    -- Note: p_hp would need to be tracked
    do_prot({a = "use", s = "cannibalize", t = target_arg})
end

function caustic_opposition(target_arg)
    do_prot({a = "cast", s = "caustic opposition", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Caustic Opposition (l_acid)"})
end

function chaos_cube(target_arg)
    do_prot({a = "cast", s = "chaos cube", t = target_arg or target})
end

function combat_trance()
    do_prot({a = "use", s = "combat trance", n = "Going in a Combat Trance"})
end

function corporeal_song_of_healing()
    do_prot({a = "cast", s = "corporeal song of healing", n = "Corporeal Song of Healing"})
end

function corrosive_opposition(target_arg)
    do_prot({a = "cast", s = "corrosive opposition", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Corrosive Opposition (g_acid)"})
end

function create_food()
    do_prot({a = "cast", s = "create food", n = "Creating Food"})
end

function create_healing_potion()
    do_prot({a = "cast", s = "create healing potion", n = "Creating Healing Potion"})
end

function create_money()
    do_prot({a = "cast", s = "create money", n = "Creating Money"})
end

function cure_blindness(target_arg)
    do_prot({a = "cast", s = "cure blindness", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", d = "think"})
end

function cure_disease(target_arg)
    do_prot({a = "cast", s = "cure disease", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", d = "think"})
end

function darkness(target_arg)
    do_prot({a = "cast", s = "darkness", t = target_arg or "10"})
end

function detect_alignment(target_arg)
    do_prot({a = "cast", s = "detect alignment", t = target_arg or target})
end

function dimension_door()
    do_prot({a = "cast", s = "dimension door", n = "Calling up a Dimensional Door"})
end

function dispel_curse(target_arg)
    do_prot({a = "cast", s = "dispel curse", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", d = "think"})
end

function displacement(target_arg)
    do_prot({a = "cast", s = "displacement", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

----
-- Spell/Skill functions (E-K)
----

function electric_blade()
    do_prot({a = "cast", s = "electric blade", n = "Electrifying Blade"})
end

function endure_void(target_arg)
    do_prot({a = "cast", s = "endure void", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Endure Void (l_asphyxiaton)"})
end

function energize_seal()
    do_prot({a = "use", s = "energize seal", n = "Energizing Seal"})
end

function energy_hauberk(target_arg)
    do_prot({a = "cast", s = "energy hauberk", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function enlarge_weapon(target_arg)
    do_prot({a = "cast", s = "enlarge weapon", t = target_arg, d = "think"})
end

function enlightenment(target_arg)
    do_prot({a = "cast", s = "enlightenment", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function estimate_worth(target_arg)
    do_prot({a = "cast", s = "estimate worth", t = target_arg ~= "" and target_arg or GetVariable("cleric_target") or GetVariable("healing") or "", A = "cleric_target", d = "think"})
end

function evaluate_corpse(target_arg)
    do_prot({a = "use", s = "evaluate corpse", t = target_arg ~= "" and target_arg or GetVariable("target") or "", q = true})
end

function feast(target_arg)
    do_prot({a = "cast", s = "feast", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", d = "think"})
end

function feather_weight(target_arg)
    do_prot({a = "cast", s = "feather weight", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function fire_blade()
    do_prot({a = "cast", s = "fire blade", n = "Burning Blade"})
end

function fire_building()
    do_prot({a = "use", s = "fire building", n = "Building a Fire"})
end

function first_aid(target_arg)
    do_prot({a = "use", s = "first aid", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function flight(target_arg)
    do_prot({a = "cast", s = "flight", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", d = "think"})
end

function floating_disc()
    do_prot({a = "cast", s = "floating disc", n = "Summoning Floating Disc"})
end

function floating_letters(target_arg)
    do_prot({a = "cast", s = "floating letters", t = target_arg or "Hello!", n = "Floating Letters", q = true})
end

function foraging()
    do_prot({a = "use", s = "foraging", n = "Foraging for Berries"})
end

function force_shield(target_arg)
    do_prot({a = "cast", s = "force shield", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function forget(target_arg)
    do_prot({a = "cast", s = "forget", t = target_arg ~= "" and target_arg or GetVariable("target") or "", q = true})
end

function greater_party_heal()
    do_prot({a = "cast", s = "greater party heal", n = "Greater Party Heal"})
end

function harmonious_barrier(target_arg)
    do_prot({a = "cast", s = "harmonious barrier", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function harmony_armour(target_arg)
    do_prot({a = "cast", s = "harmony armour", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function healing_ceremony()
    do_prot({a = "cast", s = "healing ceremony", n = "Starting a Healing Ceremony"})
end

function healing_smoke()
    do_prot({a = "cast", s = "healing smoke", n = "Summoning Healing Smoke"})
end

function healing_wind()
    do_prot({a = "cast", s = "healing wind", n = "Blowing a Healing Wind"})
end

function heavy_weight(target_arg)
    do_prot({a = "cast", s = "heavy weight", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function holy_wisdom()
    do_prot({a = "cast", s = "holy wisdom", n = "Casting Holy Wisdom"})
end

function hour_of_mercy(target_arg)
    do_prot({a = "cast", s = "hour of mercy", t = target_arg})
end

function hunting()
    do_prot({a = "use", s = "hunting"})
end

function ice_blade()
    do_prot({a = "cast", s = "ice blade", n = "Ice Blade"})
end

function identify(target_arg)
    do_prot({a = "cast", s = "identify", t = target_arg or "ring"})
end

function infernal_vestment(target_arg)
    do_prot({a = "cast", s = "infernal vestment", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Infernal Vestment (g_cold)"})
end

function infravision(target_arg)
    do_prot({a = "cast", s = "infravision", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function inner_power(target_arg)
    do_prot({a = "cast", s = "inner power", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function introversion(target_arg)
    -- Note: trunc(p_exp / 1000000) would need implementation
    do_prot({a = "use", s = "introversion", t = target_arg})
end

function invisibility(target_arg)
    do_prot({a = "cast", s = "invisibility", t = target_arg or "me", n = "Invisibility", q = true})
end

function iron_will(target_arg)
    do_prot({a = "cast", s = "iron will", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function jigoku_blade()
    do_prot({a = "cast", s = "jigoku blade", n = "Casting Jigoku Blade"})
end

function kamikaze()
    do_prot({a = "use", s = "kamikaze", n = "Going Kamikaze!"})
end

function know_your_audience(target_arg)
    do_prot({a = "cast", s = "know your audience", t = target_arg or target})
end

----
-- Spell/Skill functions (L-W)
----

function lesser_party_heal()
    do_prot({a = "cast", s = "lesser party heal", n = "Lesser Party Heal"})
end

function levitate_object(target_arg)
    do_prot({a = "cast", s = "levitate object", t = target_arg})
end

function light(target_arg)
    do_prot({a = "cast", s = "light", t = target_arg or "10", n = "Light", q = true})
end

function lightning_guard(target_arg)
    do_prot({a = "cast", s = "lightning guard", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Lightning Guard (g_electric)"})
end

function lightsword(target_arg)
    do_prot({a = "cast", s = "lightsword", t = (target_arg or "999") .. " hit", n = "Casting Lightsword (+hit)", q = true})
end

function mana_leech()
    do_prot({a = "cast", s = "mana leech", n = "Casting Mana Leech"})
end

function mental_aegis(target_arg)
    do_prot({a = "cast", s = "mental aegis", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Mental Aegis (l_psionic)"})
end

function mental_glance(target_arg)
    do_prot({a = "cast", s = "mental glance", t = target_arg ~= "" and target_arg or GetVariable("target") or "", n = "Mental Glance", q = true})
end

function mind_barrier()
    do_prot({a = "cast", s = "mind barrier", n = "Casting Mind Barrier"})
end

function mind_development(target_arg)
    do_prot({a = "cast", s = "mind development", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function minor_unpain(target_arg)
    do_prot({a = "cast", s = "minor unpain", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function mirror_image(target_arg)
    do_prot({a = "cast", s = "mirror image", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function modify_bodypart(part, modifier)
    do_prot({a = "use", s = "modify bodypart", t = part .. " modify towards " .. (modifier or ""), q = true})
end

function mystic_bulwark(target_arg)
    do_prot({a = "cast", s = "mystic bulwark", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Mystic Bulwark (l_magic)"})
end

function phaze_shift(target_arg)
    do_prot({a = "cast", s = "phaze shift", t = target_arg or tank})
end

function poison_blade()
    do_prot({a = "cast", s = "poison blade", n = "Poisoning Blade"})
end

function poison_fend(target_arg)
    do_prot({a = "cast", s = "poison fend", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Poison Fend (l_poison)"})
end

function preparation_of_harmony(target_arg)
    do_prot({a = "cast", s = "preparation of harmony", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function prepare_potion()
    do_prot({a = "use", s = "prepare potion", n = "Preparing Potion"})
end

function psychic_aegis(target_arg)
    do_prot({a = "cast", s = "psychic aegis", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Psychic Aegis (g_psionic)"})
end

function razor_edge(target_arg)
    do_prot({a = "cast", s = "razor edge", t = (target_arg or "999") .. " dam", n = "Casting Razor Edge (+dam)", q = true})
end

function rebuke_of_ice(target_arg)
    do_prot({a = "cast", s = "rebuke of ice", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Rebuke of Ice (l_fire)"})
end

function reduce_weapon(target_arg)
    do_prot({a = "cast", s = "reduce weapon", t = target_arg, d = "think"})
end

function regeneration(target_arg)
    do_prot({a = "cast", s = "regeneration", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function reincarnation(target_arg)
    do_prot({a = "cast", s = "reincarnation", t = target_arg ~= "" and target_arg or GetVariable("cleric_target") or GetVariable("healing") or "", A = "cleric_target", d = "think"})
end

function relocate(target_arg)
    do_prot({a = "cast", s = "relocate", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Relocate", q = true})
end

function remove_elements()
    do_prot({a = "use", s = "remove elements", n = "Removing Elements"})
end

function remove_invulnerabilities(target_arg)
    do_prot({a = "cast", s = "remove invulnerabilities", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function remove_poison(target_arg)
    do_prot({a = "cast", s = "remove poison", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", d = "think"})
end

function remove_scar(target_arg)
    do_prot({a = "cast", s = "remove scar", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", d = "think"})
end

function resist_void(target_arg)
    do_prot({a = "cast", s = "resist void", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Resist Void (g_asphyxiaton)"})
end

function restore_memory(target_arg)
    do_prot({a = "cast", s = "restore memory", t = target_arg})
end

function resurrect(target_arg)
    do_prot({a = "cast", s = "resurrect", t = target_arg ~= "" and target_arg or GetVariable("cleric_target") or GetVariable("healing") or "", A = "cleric_target", d = "think"})
end

function reverie_shadow(target_arg)
    do_prot({a = "cast", s = "reverie shadow", t = target_arg or target})
end

function sacred_ritual()
    do_prot({a = "cast", s = "sacred ritual", n = "Casting Sacred Ritual"})
end

function see_magic(target_arg)
    do_prot({a = "cast", s = "see magic", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function sex_change(target_arg)
    do_prot({a = "cast", s = "sex change", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", d = "think"})
end

function shadow_shield(target_arg)
    do_prot({a = "cast", s = "shadow shield", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function shadow_shift()
    do_prot({a = "use", s = "shadow shift", n = "Shadow Shifting"})
end

function shelter()
    do_prot({a = "cast", s = "shelter", n = "Sheltering"})
end

function shield_of_protection(target_arg)
    do_prot({a = "cast", s = "shield of protection", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function shizen(target_arg)
    -- Note: min(p_sp, p_maxhp - p_hp) would need implementation
    do_prot({a = "cast", s = "shizen", t = target_arg})
end

function silver_sheen(target_arg)
    do_prot({a = "cast", s = "silver sheen", t = (target_arg or "999") .. " wc", n = "Casting Silver Sheen (+wc)", q = true})
end

function spark_shelter(target_arg)
    do_prot({a = "cast", s = "spark shelter", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Spark Shelter (l_electric)"})
end

function spirit_of_nature()
    do_prot({a = "cast", s = "spirit of nature", n = "Casting Spirit of Nature"})
end

function stun_resistance(target_arg)
    do_prot({a = "cast", s = "stun resistance", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function summon(target_arg)
    do_prot({a = "cast", s = "summon", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Summon", q = true})
end

function summon_aide(target_arg)
    do_prot({a = "use", s = "summon aide", t = target_arg})
end

function summon_bag_of_holding()
    do_prot({a = "cast", s = "summon bag of holding", n = "Summoning Bag of Holding"})
end

function summon_ghost(target_arg)
    do_prot({a = "cast", s = "summon ghost", t = target_arg ~= "" and target_arg or GetVariable("cleric_target") or GetVariable("healing") or "", A = "cleric_target"})
end

function summon_orb_of_reflection()
    do_prot({a = "cast", s = "summon orb of reflection", n = "Summoning Orb of Reflection"})
end

function symmetry_in_body(target_arg)
    do_prot({a = "cast", s = "symmetry in body", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function teleport_without_error()
    do_prot({a = "cast", s = "teleport without error", n = "Teleporting to Church"})
end

function tenrai_blade()
    do_prot({a = "cast", s = "tenrai blade", n = "Casting Tenrai Blade"})
end

function transfer_mana(target_arg)
    do_prot({a = "cast", s = "transfer mana", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Transfering Mana"})
end

function transformation(target_arg)
    do_prot({a = "cast", s = "transformation", t = target_arg or "bird", n = "Transforming", q = true})
end

function transposition()
    do_prot({a = "use", s = "transposition", n = "Teleporting to Sorcerer Guild"})
end

function true_unpain(target_arg)
    do_prot({a = "cast", s = "true unpain", t = target_arg ~= "" and target_arg or GetVariable("healing") or ""})
end

function venom_fend(target_arg)
    do_prot({a = "cast", s = "venom fend", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Venom Fend (g_poison)"})
end

function vestment_of_flame(target_arg)
    do_prot({a = "cast", s = "vestment of flame", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Vestiment of Flame (l_cold)"})
end

function viscous_flesh()
    do_prot({a = "cast", s = "viscous flesh", n = "Casting Viscous Flesh"})
end

function vortex_magica()
    do_prot({a = "cast", s = "vortex magica", n = "Vortexing"})
end

function wall_of_steel()
    do_prot({a = "use", s = "wall of steel", n = "Putting up a Wall of Steel"})
end

function ward_of_steel(target_arg)
    do_prot({a = "cast", s = "ward of steel", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Ward of Steel (g_physical)"})
end

function ward_of_stone(target_arg)
    do_prot({a = "cast", s = "ward of stone", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Ward of Stone (l_physical)"})
end

function water_walking(target_arg)
    do_prot({a = "cast", s = "water walking", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", A = "healing", d = "think"})
end

function winters_rebuke(target_arg)
    do_prot({a = "cast", s = "winter's rebuke", t = target_arg ~= "" and target_arg or GetVariable("healing") or "", n = "Winter's Rebuke (g_fire)"})
end

function word_of_binding(target_arg)
    do_prot({a = "use", s = "word of binding", t = target_arg})
end

function word_of_recall()
    do_prot({a = "cast", s = "word of recall", n = "Recalling Words"})
end
