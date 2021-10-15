config = config or {}

-- Metal detector item name
config.metalDetectorItem = "metal_detector"

-- Will the metal detector detect if player has an item in config.detectableItemList?
config.detectItems = true

-- Items that will be detected if config.detectItems = true
config.detectableItemList = {
    ['drug_lsd'] = true,
    ['weed'] = true,
    ['drug_ecstasy'] = true,
    ['drug_lean'] = true,
    ['drug_meth'] = true,
}

-- Will the metal detector detect if player has any weapon?
config.detectWeapons = true

-- Weapons that will alert if the player carries them
config.detectableWeapons = {
    ["WEAPON_PISTOL"] = true,
    ["WEAPON_COMBATPISTOL"] = true,
    ["WEAPON_APPISTOL"] = true,
    ["WEAPON_PISTOL50"] = true,
    ["WEAPON_SNSPISTOL"] = true,
    ["WEAPON_HEAVYPISTOL"] = true,
    ["WEAPON_VINTAGEPISTOL"] = true,
    ["WEAPON_MACHINEPISTOL"] = true,
    ["WEAPON_REVOLVER"] = true,
    ["WEAPON_MARKSMANPISTOL"] = true,
    ["WEAPON_DOUBLEACTION"] = true,
    ["WEAPON_SMG"] = true,
    ["WEAPON_ASSAULTSMG"] = true,
    ["WEAPON_MICROSMG"] = true,
    ["WEAPON_MINISMG"] = true,
    ["WEAPON_COMBATPDW"] = true,
    ["WEAPON_PUMPSHOTGUN"] = true,
    ["WEAPON_SAWNOFFSHOTGUN"] = true,
    ["WEAPON_ASSAULTSHOTGUN"] = true,
    ["WEAPON_BULLPUPSHOTGUN"] = true,
    ["WEAPON_HEAVYSHOTGUN"] = true,
    ["WEAPON_DBSHOTGUN"] = true,
    ["WEAPON_AUTOSHOTGUN"] = true,
    ["WEAPON_MUSKET"] = true,
    ["WEAPON_ASSAULTRIFLE"] = true,
    ["WEAPON_CARBINERIFLE"] = true,
    ["WEAPON_ADVANCEDRIFLE"] = true,
    ["WEAPON_SPECIALCARBINE"] = true,
    ["WEAPON_BULLPUPRIFLE"] = true,
    ["WEAPON_COMPACTRIFLE"] = true,
    ["WEAPON_MG"] = true,
    ["WEAPON_COMBATMG"] = true,
    ["WEAPON_GUSENBERG"] = true,
    ["WEAPON_SNIPERRIFLE"] = true,
    ["WEAPON_HEAVYSNIPER"] = true,
    ["WEAPON_MARKSMANRIFLE"] = true,
    ["WEAPON_MINIGUN"] = true,
    ["WEAPON_RAILGUN"] = true,
    ["WEAPON_STUNGUN"] = true,
    ["WEAPON_RPG"] = true,
    ["WEAPON_HOMINGLAUNCHER"] = true,
    ["WEAPON_GRENADELAUNCHER"] = true,
    ["WEAPON_COMPACTLAUNCHER"] = true,
    ["WEAPON_FLAREGUN"] = true,
    ["WEAPON_FIREEXTINGUISHER"] = true,
    ["WEAPON_FIREWORK"] = true,
    ["WEAPON_KNUCKLE"] = true,
    ["WEAPON_HATCHET"] = true,
    ["WEAPON_MACHETE"] = true,
    ["WEAPON_SWITCHBLADE"] = true,
    ["WEAPON_DAGGER"] = true,
    ["WEAPON_POOLCUE"] = true,
    ["WEAPON_WRENCH"] = true,
    ["WEAPON_BATTLEAXE"] = true,
    ["WEAPON_KNIFE"] = true,
    ["WEAPON_NIGHTSTICK"] = true,
    ["WEAPON_HAMMER"] = true,
    ["WEAPON_BAT"] = true,
    ["WEAPON_GOLFCLUB"] = true,
    ["WEAPON_CROWBAR"] = true,
    ["WEAPON_GRENADE"] = true,
    ["WEAPON_SMOKEGRENADE"] = true,
    ["WEAPON_STICKYBOMB"] = true,
    ["WEAPON_PIPEBOMB"] = true,
    ["WEAPON_BZGAS"] = true,
    ["WEAPON_MOLOTOV"] = true,
    ["WEAPON_PROXMINE"] = true,

    ["WEAPON_BOTTLE"] = false,
    ["WEAPON_PETROLCAN"] = false,
    ["WEAPON_FLASHLIGHT"] = false,
    ["GADGET_PARACHUTE"] = false,
    ["WEAPON_SNOWBALL"] = false,
    ["WEAPON_BALL"] = false,
    ["WEAPON_FLARE"] = false,
}