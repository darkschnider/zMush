zEffects = require "effects"
require("add_effect")
require ("vulns")
require ("aura")
require ("prots")
local trigFlags = 33 -- Enabled | RegularExpression

-- Delete existing Abjurer groups before recreating
DeleteAliasGroup("Abjurer Aliases")
DeleteTriggerGroup("Abjurer Vulns")

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

addNewSpellAndAlias("iw", "Iron Will", "iw", "/iw (.*)", aliasEnabledAndRegex, nil, 1, "stun", "^[A-Z][a-z]+ stares deep into your eyes, bolstering your concentration greatly\\.$|^You turn your mind inwards, enchanting yourself with an aura of rigid concentration\\.$", "Your Iron Will wears off\\.")
addNewSpellAndAlias("eh", "Energy Hauberk", "eh", "/eh (.*)", aliasEnabledAndRegex, nil, 1, nil, "With a flash a shining hauberk of pure energy encases you\\.$|^hauberk around yourself\\.$", "The energy surrounding your body dwindles away\\.")

--- Abjurer Protections ---
-- Format: code 	name
---        lacid 	caustic opposition
---        gacid 	corrosive opposition
---        lasph 	endure void
---        gasph 	resist void
---        lcold 	vestment of flame
---        gcold 	infernal vestment
---        lelec 	spark shelter
---        gelec 	lightning guard
---        lfire 	rebuke of ice
---        gfire 	winter's rebuke
---        lmagi 	mystic bulwark
---        gmagi 	arcane bulwark
---        lphys 	ward of stone
---        gphys 	ward of steel
---        lpois 	poison fend
---        gpois 	venom fend
---        lpsio 	mental aegis
---        gpsio 	psychic aegis
----
-- INVULNERABILITIES
-- Aliases for protection spells
----

-- Physical protections
AddAlias("gphys", "^/gphys(.*)$", "ward_of_steel(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_phys", "^/g_phys(.*)$", "ward_of_steel(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_physical", "^/g_physical(.*)$", "ward_of_steel(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("lphys", "^/lphys(.*)$", "ward_of_stone(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_phys", "^/l_phys(.*)$", "ward_of_stone(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_physical", "^/l_physical(.*)$", "ward_of_stone(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Magic protections
AddAlias("g_mag", "^/g_mag(.*)$", "arcane_bulwark(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("gmagi", "^/gmagi(.*)$", "arcane_bulwark(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_magi", "^/g_magi(.*)$", "arcane_bulwark(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_magic", "^/g_magic(.*)$", "arcane_bulwark(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_mag", "^/l_mag(.*)$", "mystic_bulwark(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("lmagi", "^/lmagi(.*)$", "mystic_bulwark(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_magi", "^/l_magi(.*)$", "mystic_bulwark(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_magic", "^/l_magic(.*)$", "mystic_bulwark(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Fire protections
AddAlias("gfire", "^/gfire(.*)$", "winters_rebuke(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_fire", "^/g_fire(.*)$", "winters_rebuke(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("lfire", "^/lfire(.*)$", "rebuke_of_ice(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_fire", "^/l_fire(.*)$", "rebuke_of_ice(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Cold protections
AddAlias("gcold", "^/gcold(.*)$", "infernal_vestment(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_cold", "^/g_cold(.*)$", "infernal_vestment(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("lcold", "^/lcold(.*)$", "vestment_of_flame(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_cold", "^/l_cold(.*)$", "vestment_of_flame(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Acid protections
AddAlias("gacid", "^/gacid(.*)$", "corrosive_opposition(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_acid", "^/g_acid(.*)$", "corrosive_opposition(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("lacid", "^/lacid(.*)$", "caustic_opposition(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_acid", "^/l_acid(.*)$", "caustic_opposition(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Psionic protections
AddAlias("g_psi", "^/g_psi(.*)$", "psychic_aegis(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("gpsio", "^/gpsio(.*)$", "psychic_aegis(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_psio", "^/g_psio(.*)$", "psychic_aegis(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_psionic", "^/g_psionic(.*)$", "psychic_aegis(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_psi", "^/l_psi(.*)$", "mental_aegis(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("lpsio", "^/lpsio(.*)$", "mental_aegis(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_psio", "^/l_psio(.*)$", "mental_aegis(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_psionic", "^/l_psionic(.*)$", "mental_aegis(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Asphyxiation protections
AddAlias("g_asp", "^/g_asp(.*)$", "resist_void(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("gasph", "^/gasph(.*)$", "resist_void(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_asph", "^/g_asph(.*)$", "resist_void(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_asphyxiaton", "^/g_asphyxiaton(.*)$", "resist_void(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_asp", "^/l_asp(.*)$", "endure_void(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("lasph", "^/lasph(.*)$", "endure_void(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_asph", "^/l_asph(.*)$", "endure_void(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_asphyxiaton", "^/l_asphyxiaton(.*)$", "endure_void(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Electric protections
AddAlias("gelec", "^/gelec(.*)$", "lightning_guard(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_elec", "^/g_elec(.*)$", "lightning_guard(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_electric", "^/g_electric(.*)$", "lightning_guard(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("lelec", "^/lelec(.*)$", "spark_shelter(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_elec", "^/l_elec(.*)$", "spark_shelter(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_electric", "^/l_electric(.*)$", "spark_shelter(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Poison protections
AddAlias("g_poi", "^/g_poi(.*)$", "venom_fend(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("gpois", "^/gpois(.*)$", "venom_fend(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_pois", "^/g_pois(.*)$", "venom_fend(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("g_poison", "^/g_poison(.*)$", "venom_fend(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_poi", "^/l_poi(.*)$", "poison_fend(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("lpois", "^/lpois(.*)$", "poison_fend(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_pois", "^/l_pois(.*)$", "poison_fend(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("l_poison", "^/l_poison(.*)$", "poison_fend(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

----
-- VULNERABILITIES
-- Aliases for vulnerability spells
----
def_vuln("vitriolic_bane", "acid", "Vitriolic Bane", 32)
def_vuln("labored_breathing", "asphyxiation", "Labored Breathing", 32)
def_vuln("deprive_warmth", "cold", "Deprive Warmth", 32)
def_vuln("energetic_frailty", "electric", "Energetic Frailty", 32)
def_vuln("incendiary_coating", "fire", "Incendiary Coating", 32)
def_vuln("mystic_impairment", "magic", "Mystic Impairment", 32)
def_vuln("fragile_frame", "physical", "Fragile Frame", 32)
def_vuln("blemished_health", "poison", "Blemished Health", 32)
def_vuln("languished_soul", "psionic", "Languished Soul", 32)
def_vuln("elemental_disarray", "cold, mag, fire, asp, phys", "Elemental Disarray", 32)
def_vuln("ray_of_enervation", "elec, acid, psi, poi, phys", "Ray of Enervation", 26)

AddTriggerEx("luaElementalDisarrayVuln", "^You reach out with your hands and focus the spell at .*", "vuln_up('elemental_disarray')", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
AddTriggerEx("luaRayOfEnervationVuln", "^A colourful ray of immense power shoots from your hands towards .*", "vuln_up('ray_of_enervation')", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
AddTriggerEx("luaVitriolicBaneVuln", "^You trace the rune of dissolving and .*", "vuln_up('vitriolic_bane')", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
AddTriggerEx("luaLaboredBreathingVuln", "^You trace the rune of constriction and an ebon cloud .*", "vuln_up('labored_breathing')", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
AddTriggerEx("luaDepriveWarmthVuln", "^You trace the rune of frost and a single white snowflake .*", "vuln_up('deprive_warmth')", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
AddTriggerEx("luaEnergeticFrailtyVuln", "^You trace the rune of lightning and an arc of lazuline .*", "vuln_up('energetic_frailty')", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
AddTriggerEx("luaIncendiaryCoatingVuln", "^You trace the rune of burning and a scarlet stream of .*", "vuln_up('incendiary_coating')", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
AddTriggerEx("luaMysticImpairmentVuln", "^You trace the rune of enervation and send a violet missile .*", "vuln_up('mystic_impairment')", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
AddTriggerEx("luaFragileFrameVuln", "^You trace the rune of withering and an ashen dart launches .*", "vuln_up('fragile_frame')", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
AddTriggerEx("luaBlemishedHealthVuln", "^You trace the rune of virulence and pinch your fingers.*", "vuln_up('blemished_health')", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)
AddTriggerEx("luaLanguishedSoulVuln", "^You trace the rune of dreaming and a bolt of viridian .*", "vuln_up('languished_soul')", trigFlags, custom_colour.Custom3, 0, "", "", sendto.script, 100)

SetTriggerOption("luaElementalDisarrayVuln", "group", "Abjurer Vulns")
SetTriggerOption("luaRayOfEnervationVuln", "group", "Abjurer Vulns")
SetTriggerOption("luaVitriolicBaneVuln", "group", "Abjurer Vulns")
SetTriggerOption("luaLaboredBreathingVuln", "group", "Abjurer Vulns")
SetTriggerOption("luaDepriveWarmthVuln", "group", "Abjurer Vulns")
SetTriggerOption("luaEnergeticFrailtyVuln", "group", "Abjurer Vulns")
SetTriggerOption("luaIncendiaryCoatingVuln", "group", "Abjurer Vulns")
SetTriggerOption("luaMysticImpairmentVuln", "group", "Abjurer Vulns")
SetTriggerOption("luaFragileFrameVuln", "group", "Abjurer Vulns")
SetTriggerOption("luaBlemishedHealthVuln", "group", "Abjurer Vulns")
SetTriggerOption("luaLanguishedSoulVuln", "group", "Abjurer Vulns")

-- Elemental Disarray and Ray of Enervation
AddAlias("ed", "^/ed(.*)$", "elemental_disarray(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("re", "^/re(.*)$", "ray_of_enervation(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Physical vulnerabilities
AddAlias("vphys", "^/vphys(.*)$", "fragile_frame(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_phys", "^/v_phys(.*)$", "fragile_frame(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_physical", "^/v_physical(.*)$", "fragile_frame(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Magic vulnerabilities
AddAlias("vmag", "^/vmag(.*)$", "mystic_impairment(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_mag", "^/v_mag(.*)$", "mystic_impairment(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("vmagi", "^/vmagi(.*)$", "mystic_impairment(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_magi", "^/v_magi(.*)$", "mystic_impairment(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_magic", "^/v_magic(.*)$", "mystic_impairment(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Fire vulnerabilities
AddAlias("vfire", "^/vfire(.*)$", "incendiary_coating(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_fire", "^/v_fire(.*)$", "incendiary_coating(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Cold vulnerabilities
AddAlias("vcold", "^/vcold(.*)$", "deprive_warmth(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_cold", "^/v_cold(.*)$", "deprive_warmth(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Acid vulnerabilities
AddAlias("vacid", "^/vacid(.*)$", "vitriolic_bane(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_acid", "^/v_acid(.*)$", "vitriolic_bane(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Psionic vulnerabilities
AddAlias("vpsi", "^/vpsi(.*)$", "languished_soul(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_psi", "^/v_psi(.*)$", "languished_soul(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("vpsio", "^/vpsio(.*)$", "languished_soul(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_psio", "^/v_psio(.*)$", "languished_soul(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_psionic", "^/v_psionic(.*)$", "languished_soul(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Asphyxiation vulnerabilities
AddAlias("vasp", "^/vasp(.*)$", "labored_breathing(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_asp", "^/v_asp(.*)$", "labored_breathing(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("vasph", "^/vasph(.*)$", "labored_breathing(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_asph", "^/v_asph(.*)$", "labored_breathing(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_asphyxiation", "^/v_asphyxiation(.*)$", "labored_breathing(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Electric vulnerabilities
AddAlias("velec", "^/velec(.*)$", "energetic_frailty(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_elec", "^/v_elec(.*)$", "energetic_frailty(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_electric", "^/v_electric(.*)$", "energetic_frailty(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Poison vulnerabilities
AddAlias("vpoi", "^/vpoi(.*)$", "blemished_health(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_poi", "^/v_poi(.*)$", "blemished_health(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("vpois", "^/vpois(.*)$", "blemished_health(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_poio", "^/v_poio(.*)$", "blemished_health(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")
AddAlias("v_poison", "^/v_poison(.*)$", "blemished_health(trim('%1'))", alias_flag.Enabled + alias_flag.RegularExpression, "")

-- Set all aliases to "Abjurer Aliases" group
local abjurer_aliases = {
  "gphys", "g_phys", "g_physical", "lphys", "l_phys", "l_physical",
  "g_mag", "gmagi", "g_magi", "g_magic", "l_mag", "lmagi", "l_magi", "l_magic",
  "gfire", "g_fire", "lfire", "l_fire",
  "gcold", "g_cold", "lcold", "l_cold",
  "gacid", "g_acid", "lacid", "l_acid",
  "g_psi", "gpsio", "g_psio", "g_psionic", "l_psi", "lpsio", "l_psio", "l_psionic",
  "g_asp", "gasph", "g_asph", "g_asphyxiaton", "l_asp", "lasph", "l_asph", "l_asphyxiaton",
  "gelec", "g_elec", "g_electric", "lelec", "l_elec", "l_electric",
  "g_poi", "gpois", "g_pois", "g_poison", "l_poi", "lpois", "l_pois", "l_poison",
  "ed", "re",
  "vphys", "v_phys", "v_physical",
  "vmag", "v_mag", "vmagi", "v_magi", "v_magic",
  "vfire", "v_fire",
  "vcold", "v_cold",
  "vacid", "v_acid",
  "vpsi", "v_psi", "vpsio", "v_psio", "v_psionic",
  "vasp", "v_asp", "vasph", "v_asph", "v_asphyxiation",
  "velec", "v_elec", "v_electric",
  "vpoi", "v_poi", "vpois", "v_poio", "v_poison"
}

for _, alias_name in ipairs(abjurer_aliases) do
  SetAliasOption(alias_name, "group", "Abjurer Aliases")
  SetAliasOption(alias_name, "send_to", sendto.script)
end

--- Abjurer Vulns ---
-- Format: code     name
---        vacid 	vitriolic bane
---        vasph 	labored breathing
---        vcold 	deprive warmth
---        velec 	energetic frailty
---        vfire 	incendiary coating
---        vmagi 	mystic impairment
---        vphys 	fragile frame
---        vpois 	blemished health
---        vpsio 	languished soul
