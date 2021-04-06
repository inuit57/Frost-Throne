-- 매크들을 여기서 정의한다. 


narD_FrostMech = Pawn:new { 
	Name = "Frost Mech",
	Class = "Prime",
	Health = 3,
	MoveSpeed = 3,  
	Image = "FrostMech", --"MechPunch", 
	ImageOffset = 6,
	SkillList = { "nard_frostHammer"},-- "nard_frostMoaun"} ,-- , "Prime_RightHook"}, --  
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}

AddPawn("narD_FrostMech")

narD_DrakoMech = Pawn:new  {
	Name = "Drako Mech",
	Class = "Brute", --Brute
	Health = 2,
	Image = "DrakoMech",
	ImageOffset = 6,
	MoveSpeed = 4,
	SkillList = { "nard_DragonFire"  }, -- , "nard_PhaseShield" },  --Brute_Jetmech
	Flying = true ,
	SoundLocation = "/mech/flying/jet_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
	
AddPawn("narD_DrakoMech") 

narD_IcicleMech = Pawn:new {
	Name = "Icicle Mech",
	Class = "Science", --"Science",--"Ranged",
	Health = 2,
	Image = "IcycleMech",
	ImageOffset = 6,
	Flying = true,
	MoveSpeed = 4,
	Flying = false,
	SkillList = { "narD_SidePushShot" },--, "nard_Iceball"  },
	SoundLocation = "/mech/science/science_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}

AddPawn("narD_IcicleMech") 
