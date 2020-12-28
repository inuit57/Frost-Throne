local function init(self)
	require(self.scriptPath.."FURL")(self, {
		-- {
		-- 	Type = "color",
		-- 	Name = "FrostThrone",
		-- 	PawnLocation = self.scriptPath.."pawns",
			
		-- 	PlateHighlight =	{242, 132, 34},	--lights
		-- 	PlateLight =		{116, 125, 127},	--main highlight
		-- 	PlateMid =			{62, 71, 73},	--main light
		-- 	PlateDark =			{29, 38, 40},	--main mid
		-- 	PlateOutline =		{7, 12, 13},	--main dark
		-- 	BodyHighlight =		{61, 69, 63},	--metal light
		-- 	BodyColor =			{30, 35, 34},	--metal mid
		-- 	PlateShadow =		{15, 17, 17},	--metal dark
		-- },
		{
			Type = "mech",
			Name = "IceMech",
			Filename = "mech_ice",
			Path = "img", 
			ResourcePath = "units/player",

			Default =           {  PosX = -22, PosY = -7 },
			Animated =          {  PosX = -22, PosY = -7 , NumFrames = 4},  -- 이거가 행거에서 보이는 위치 
			Broken =            {  PosX = -22, PosY = -7},
			Submerged =         { PosX = -22, PosY = -1 },
			SubmergedBroken =   {  PosX = -22, PosY = -1 },
			-- Default =           { PosX = -20, PosY = -8 },
			-- Animated =          { PosX = -20, PosY = -8 , NumFrames = 4},  -- 이거가 행거에서 보이는 위치 
			-- Broken =            { PosX = -20, PosY = -8},
			-- Submerged =         { PosX = -25, PosY = -6 },
			-- SubmergedBroken =   { PosX = -25, PosY = -6 },
			Icon =              {},
		},
		-- {
		-- 	Type = "mech",
		-- 	Name = "StealthMech",
		-- 	Filename = "ronin_mech_stealth",
		-- 	Path = "img", 
		-- 	ResourcePath = "units/player",

		-- 	Default =           { PosX = -37, PosY = -19 },
		-- 	Animated =          { PosX = -37, PosY = -19, NumFrames = 12},
		-- 	Broken =            { PosX = -37, PosY = -19 },
		-- 	Submerged =         { PosX = -37, PosY = -19 },
		-- 	SubmergedBroken =   { PosX = -37, PosY = -19 },
		-- 	Icon =              {},
		-- },
		-- {
		-- 	Type = "mech",
		-- 	Name = "HunterMech",
		-- 	Filename = "ronin_mech_hunter",
		-- 	Path = "img", 
		-- 	ResourcePath = "units/player",

		-- 	Default =           { PosX = -37, PosY = -19 },
		-- 	Animated =          { PosX = -37, PosY = -19, NumFrames = 4},
		-- 	Broken =            { PosX = -37, PosY = -19 },
		-- 	Submerged =         { PosX = -37, PosY = -19 },
		-- 	SubmergedBroken =   { PosX = -37, PosY = -19 },
		-- 	Icon =              {},
		-- }
	});

	require(self.scriptPath.."pawns")
	require(self.scriptPath.."weapons")
	require(self.scriptPath.."animations")
	--modApi:addWeapon_Texts(require(self.scriptPath.."weapons_text"))


	modApi:appendAsset("img/weapons/IcePunch.png",self.resourcePath.."img/weapons/IcePunch.png")
	modApi:appendAsset("img/weapons/iceBomb.png",self.resourcePath.."img/weapons/iceBomb.png")
	modApi:appendAsset("img/weapons/iceShot.png",self.resourcePath.."img/weapons/iceShot.png")
	modApi:appendAsset("img/weapons/phaseFrost.png",self.resourcePath.."img/weapons/phaseFrost.png")
	modApi:appendAsset("img/effects/gaia_zeta_iceblast_D.png",self.resourcePath.."img/effects/gaia_zeta_iceblast_D.png")
	modApi:appendAsset("img/effects/gaia_zeta_iceblast_U.png",self.resourcePath.."img/effects/gaia_zeta_iceblast_U.png")
	modApi:appendAsset("img/effects/gaia_zeta_iceblast_R.png",self.resourcePath.."img/effects/gaia_zeta_iceblast_R.png")
	modApi:appendAsset("img/effects/gaia_zeta_iceblast_L.png",self.resourcePath.."img/effects/gaia_zeta_iceblast_L.png")
end


--GetSkillEffect() is called before it does stuff (often several times), so you will need to set variables that stores the queued state via ret:AddScript()



local function load(self,options,version)

	--assert(package.loadlib(self.resourcePath .."/lib/utils.dll", "luaopen_utils"))()
	modApi:addSquadTrue({"Frost Throne","narD_FrostMech","narD_IcicleMech","narD_DrakoMech"},"Frost Throne","Tip) Ice + Fire = Water ",self.resourcePath.."/icon.png")

--modApi:addNextTurnHook(function()
	--DelayHeal:DelayRepair()
--end)

end



return {
	id = "Frost Throne", --스쿼드 id. 이름이랑 같게 해줘도 상관은 없음.
	name = "Frost Throne", --스쿼드 이름. 위의 이름과 동일하게 맞춰줄 것.
	version = "1.0.0", --버전.
	requirements = {},
	init = init,
	load = load,
	description = "" --설명 추가. 
}
