local function init(self)
	require(self.scriptPath.."FURL")(self, {

		-- {
		-- 	Type = "color",
		-- 	Name = "FrostThrone",
		-- 	PawnLocation = self.scriptPath.."pawns",
			
		-- 	PlateHighlight =	{55, 202, 226},	--lights
		-- 	PlateLight =		{10, 160, 153},	--main highlight
		-- 	PlateMid =			{25, 75, 89},	--main light
		-- 	PlateDark =			{20, 73, 81},	--main mid
		-- 	PlateOutline =		{7, 12, 13},	--main dark

		-- 	BodyHighlight =		{61, 69, 63},	--metal light
		-- 	BodyColor =			{30, 35, 34},	--metal mid
		-- 	PlateShadow =		{15, 17, 17},	--metal dark
		-- }, 

		{
			Type = "mech",
			Name = "FrostMech",
			Filename = "mech_frost",
			Path = "img", 
			ResourcePath = "units/player",

			Default =           {  PosX = -22, PosY = -7 },
			Animated =          {  PosX = -22, PosY = -7 , NumFrames = 4},  -- 이거가 행거에서 보이는 위치 
			Broken =            {  PosX = -22, PosY = -7},
			Submerged =         { PosX = -22, PosY = -1 },
			SubmergedBroken =   {  PosX = -22, PosY = -1 },
			Icon =              {},
		},
		{
			Type = "mech",
			Name = "DrakoMech",
			Filename = "mech_icejet",
			Path = "img", 
			ResourcePath = "units/player",

			Default =           {  PosX = -22, PosY = -5 },
			Animated =          {  PosX = -22, PosY = -5 , NumFrames = 4},  -- 이거가 행거에서 보이는 위치 
			Broken =            {  PosX = -17, PosY = 5},
			Submerged =         { PosX = -17, PosY = 10 },
			SubmergedBroken =   {  PosX = -17, PosY = 12 },
			Icon =              {},
		},
		{
			Type = "mech",
			Name = "IcycleMech",
			Filename = "mech_iceartillery",
			Path = "img", 
			ResourcePath = "units/player",

			Default =           {  PosX = -17, PosY = -1 },
			Animated =          {  PosX = -17, PosY = -1 , NumFrames = 4},  -- 이거가 행거에서 보이는 위치 
			Broken =            {  PosX = -17, PosY = -1},
			Submerged =         { PosX = -17, PosY = 5 },
			SubmergedBroken =   {  PosX = -17, PosY = 5 },
			Icon =              {},
		},
		
	});

	require(self.scriptPath.."pawns")
	require(self.scriptPath.."weapons")
	require(self.scriptPath.."animations")
	--modApi:addWeapon_Texts(require(self.scriptPath.."weapons_text"))


	modApi:appendAsset("img/weapons/IcePunch.png",self.resourcePath.."img/weapons/IcePunch.png")
	
	modApi:appendAsset("img/effects/shot_frostShot_R.png",self.resourcePath.."img/effects/shot_frostShot_R.png")
	modApi:appendAsset("img/effects/shot_frostShot_U.png",self.resourcePath.."img/effects/shot_frostShot_U.png")

	modApi:appendAsset("img/weapons/frost_warhammer.png",self.resourcePath.."img/weapons/frost_warhammer.png")
	modApi:appendAsset("img/weapons/frost_range.png",self.resourcePath.."img/weapons/frost_range.png")

	modApi:appendAsset("img/weapons/iceBomb.png",self.resourcePath.."img/weapons/iceBomb.png")
	modApi:appendAsset("img/weapons/iceShot.png",self.resourcePath.."img/weapons/iceShot.png")
	modApi:appendAsset("img/weapons/phaseFrost.png",self.resourcePath.."img/weapons/phaseFrost.png")
	modApi:appendAsset("img/effects/gaia_zeta_iceblast_D.png",self.resourcePath.."img/effects/gaia_zeta_iceblast_D.png")
	modApi:appendAsset("img/effects/gaia_zeta_iceblast_U.png",self.resourcePath.."img/effects/gaia_zeta_iceblast_U.png")
	modApi:appendAsset("img/effects/gaia_zeta_iceblast_R.png",self.resourcePath.."img/effects/gaia_zeta_iceblast_R.png")
	modApi:appendAsset("img/effects/gaia_zeta_iceblast_L.png",self.resourcePath.."img/effects/gaia_zeta_iceblast_L.png")


	
	modApi:appendAsset("img/effects/ice_smash_R.png",self.resourcePath.."img/effects/ice_smash_R.png")
	modApi:appendAsset("img/effects/ice_smash_U.png",self.resourcePath.."img/effects/ice_smash_U.png")
	modApi:appendAsset("img/effects/ice_smash_L.png",self.resourcePath.."img/effects/ice_smash_L.png")
	modApi:appendAsset("img/effects/ice_smash_D.png",self.resourcePath.."img/effects/ice_smash_D.png")

	modApi:appendAsset("img/combat/icons/narD_icon_ice_glow.png",self.resourcePath.."img/combat/icons/narD_icon_ice_glow.png")
		Location["combat/icons/narD_icon_ice_glow.png"] = Point(-13,10)
	modApi:appendAsset("img/combat/icons/narD_icon_ice_glowU.png",self.resourcePath.."img/combat/icons/narD_icon_ice_glow.png")
		Location["combat/icons/narD_icon_ice_glowU.png"] = Point(-28,10)

	modApi:appendAsset("img/combat/icons/narD_icon_icecrack_glow.png",self.resourcePath.."img/combat/icons/narD_icon_icecrack_glow.png")
		Location["combat/icons/narD_icon_icecrack_glow.png"] = Point(-13,10)
	modApi:appendAsset("img/combat/icons/narD_icon_icecrack_glowU.png",self.resourcePath.."img/combat/icons/narD_icon_icecrack_glow.png")
		Location["combat/icons/narD_icon_icecrack_glowU.png"] = Point(-28,10)



	modApi:appendAsset("img/combat/icons/tosx_create_water_icon_glow.png",self.resourcePath.."img/combat/icons/tosx_create_water_icon_glow.png")
		Location["combat/icons/tosx_create_water_icon_glow.png"] = Point(-13,10)
	modApi:appendAsset("img/combat/icons/tosx_create_water_icon_glowU.png",self.resourcePath.."img/combat/icons/tosx_create_water_icon_glow.png")
		Location["combat/icons/tosx_create_water_icon_glowU.png"] = Point(-28,10)


	require(self.scriptPath .."achievements/init")
	require(self.scriptPath .."achievements")
	require(self.scriptPath .."achievementTriggers"):init()
	local achvApi = require(self.scriptPath.."/achievements/api")

	if modApiExt then
        -- modApiExt already defined. This means that the user has the complete
        -- ModUtils package installed. Use that instead of loading our own one.
        narD_frostsquad_ModApiExt = modApiExt
    else
        -- modApiExt was not found. Load our inbuilt version
        local extDir = self.scriptPath.."modApiExt/"
        narD_frostsquad_ModApiExt = require(extDir.."modApiExt")
        narD_frostsquad_ModApiExt:init(extDir)
	end
	
	local shop = require(self.scriptPath .."shop")
	shop:addWeapon({
		id = "nard_frostHammer",
		name = nard_frostHammer.Name,
		desc = "Adds Frost Hammer to the store."
	})
	shop:addWeapon({
		id = "nard_DragonFire",
		name = nard_DragonFire.Name,
		desc = "Adds Frost Bombs to the store."
	})
	shop:addWeapon({
		id = "narD_SidePushShot",
		name = narD_SidePushShot.Name,
		desc = "Adds Frost Cannon to the store."
	})
end


--GetSkillEffect() is called before it does stuff (often several times), so you will need to set variables that stores the queued state via ret:AddScript()



local function load(self,options,version)

	--assert(package.loadlib(self.resourcePath .."/lib/utils.dll", "luaopen_utils"))()
	modApi:addSquadTrue({"Frost Throne","narD_FrostMech","narD_IcicleMech","narD_DrakoMech"},"Frost Throne","Warriors of the frozen wastes, Rise!",self.resourcePath.."/squad_icon.png")
	require(self.scriptPath .."shop"):load(options)


end



return {
	id = "Frost Throne", 
	name = "Frost Throne", 
	version = "2.1.0", 
	requirements = {},
	init = init,
    icon = "mod_icon.png",
	load = load,
	description = "Freeze tiles and crush enemies. (Tip : Fire + Ice = water)"  
}
