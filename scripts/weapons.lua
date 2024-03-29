local wt2 = {	
	nard_frostMoaun_Upgrade1 = "+1 Min Damage",
	nard_frostMoaun_Upgrade2 = "+1 Max Damage",
	
	nard_Iceball_Upgrade1 = "+1 Min Damage",--"Building Immune", --"+2 Center Damage",
	nard_Iceball_Upgrade2 = "+1 Max Damage",
	
	nard_DragonFire_Upgrade1 = "+ 1 Range",--"Gain Shield" ,--"+2 Range", --"+4 Range"
	nard_DragonFire_Upgrade2 = "+1 Damage", --"+2 Range", --"Side Push",
	
	nard_PhaseShield_Upgrade1 = "Shield Allies",
	nard_PhaseShield_Upgrade2 = "+2 Range", --"Full Phase",

	-- rework 
	nard_frostHammer_Upgrade1 = "IceBreak",--"Building Freeze",
	nard_frostHammer_Upgrade2 = "+2 Damage",

	--narD_SidePushShot_Upgrade1 = "Range scaling", --"Unstable shot" ,
	narD_SidePushShot_Upgrade1 = "IceBreak" ,--"Building Freeze" ,

}
for k,v in pairs(wt2) do Weapon_Texts[k] = v end

local function isTipImage()
	return Board:GetSize() == Point(6,6)
end


--Rework Prime Weapon 
nard_frostHammer = Skill:new{  
	Name = "Frost Hammer"; 
	Description =  "Smash the ground, creating ice tile and pushing adjacent tile.", 
	Class = "Prime",
	Icon = "weapons/frost_warhammer.png", 
	PathSize = 1,
	--MinDamage =0,
	Damage = 2,
	PowerCost = 1,
	Upgrades = 2,
	UpgradeCost = { 2,3 },
	BuildingFreeze = 0, 
	IceBreak = 0 ,
	--Limited = 1,
	LaunchSound = "/weapons/mercury_fist",
	TipImage = {
		Unit = Point(2,3),
		
		Enemy = Point(2,1),
		Target = Point(2,2)
	}
}

function nard_frostHammer:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local achieve_flag = false 

	ret:AddDamage(SoundEffect(p2,self.LaunchSound))
	
	damage = SpaceDamage(p2, 0) --  self.Damage)
	


	local makeIce = 0 
	if not Board:IsTerrain(p2,TERRAIN_LAVA) and Board:GetTerrain(p2) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(p2) and not Board:IsPod(p2) and not Board:IsSpawning(p2)  then	
		makeIce = 1
		if Board:GetTerrain(p2) ~= TERRAIN_ICE then
			damage.iTerrain = TERRAIN_ICE
			if Board:IsFire(p2) then
				damage.iTerrain = TERRAIN_WATER
			end
		end
	end
	ret:AddDamage(damage)

	damage = SpaceDamage(p2, 0)


	if Board:IsBuilding(p2) then --and self.BuildingFreeze == 1 then 
		-- damage.iDamage = 0
		-- damage.iFrozen = 1 
		achieve_flag = true
	end
	damage.sAnimation = "ice_smash_"..direction
	--"explosmash_"..direction
	
	--if not Board:IsTerrain(p2,TERRAIN_ICE) and not Board:IsBuilding(p2) then 
	if makeIce == 1 then
		damage.sImageMark = "combat/icons/narD_icon_ice_glow.png"
		
		if self.IceBreak == 1 then				
			damage.sImageMark = "combat/icons/narD_icon_icecrack_glowU.png"
			damage.iDamage = 1
		end

		if Board:IsFire(p2) then
			damage.sImageMark = "combat/icons/tosx_create_water_icon_glow.png"
		end
	end

	ret:AddDamage(damage)
	
	ret:AddDelay(0.1)
	ret:AddBounce(p2,3)
	ret:AddDelay(0.2)
	
	local damage = SpaceDamage(p2 + DIR_VECTORS[direction], self.Damage, direction)

	
	damage.sAnimation = "gaia_zeta_iceblast_"..direction

	-- if Board:IsBuilding(p2 + DIR_VECTORS[direction]) and self.BuildingFreeze == 1 then 
	-- 	damage.iDamage = 0 
	-- 	damage.iFrozen = 1
	-- 	achieve_flag = true
	-- end

	ret:AddDamage(damage)
	
	if achieve_flag == true then
		local countEnemy = Board:GetEnemyCount()
		ret:AddScript(string.format([[
			local fx = SkillEffect();
			fx:AddScript("if %s - Board:GetEnemyCount() >= 1 then narD_frost_Chievo('narD_frost_Slam') end")
			Board:AddEffect(fx);
		]], countEnemy))
	end

	
	local count = 0 
	for i = 0, 7 do
		for j = 0, 7  do
			local curr = Point(i,j)
			if Board:IsTerrain(curr,TERRAIN_ICE) then
				count = count + 1 
			end
		end
	end
	
	if count >= 30 then 
		ret:AddScript("narD_frost_Chievo('narD_frost_WIC')")
	end

	return ret
end	

nard_frostHammer_A = nard_frostHammer:new{
	--Limited = 2,
	--UpgradeDescription = "This adjacent attack will freeze Grid Buildings.", --"Freeze the building.",
	UpgradeDescription = "Instead ice tile, create broken ice tile.", 
	--BuildingFreeze = 1, 

	IceBreak = 1,
	--MinDamage = 1,

	-- TipImage = {
	-- 	Unit = Point(2,3),
	-- 	Building = Point(2,2),
	-- 	Enemy = Point(2,1),
	-- 	Target = Point(2,2)
	-- }

}

nard_frostHammer_B = nard_frostHammer:new{
	UpgradeDescription = "Increases damage by 2.",--and Minimum damage by 1",
	--MinDamage = 1,
	Damage = 4,
}

nard_frostHammer_AB = nard_frostHammer_A:new{
	--BuildingFreeze = 1, 
	IceBreak = 1,
	--MinDamage = 1,
	Damage = 4,
	
}
--Rework Prime Weapon END 

--Rework Brute? Weapon 
narD_SidePushShot = TankDefault:new{  
	Name = "Frost Cannon",--"SidePush Cannon",
	Description = "Fire a non-damaging projectile that creates ice as it passes and pushes targets along both sides of the path. " , 
	Class = "Science", --"Science", --"Brute",
	Icon = "weapons/frost_range.png", 
	Damage = 0, --1,
	PowerCost = 1,
	--Phase = true,
	Push = 0,--1,
	Upgrades = 1, --2,
	UpgradeCost = {2} ,-- 2 },
	BuildingFreeze = 0, 
	--Limited = 1,
	IceBreak = 0, 
	Unstable = 0,
	BuildingFreeze = 0 , 
	--ProjectileArt = "effects/shot_phaseshot", 
	ProjectileArt = "effects/shot_frostShot", 
	LaunchSound = "/weapons/phase_shot",
	TipImage = {
		Unit = Point(2,4),
		--Enemy = Point(2,2),
		Enemy2 = Point(3,2),
		Enemy3 = Point(3,3),
		Enemy4 = Point(3,0),
		Target = Point(2,1),

		Building = Point (2,0), 
		
	}
}

function narD_SidePushShot:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local dir2 = GetDirection(p1 - p2)
	
	local target = GetProjectileEnd(p1,p2,pathing)  
	
	local distance = p1:Manhattan(target) 

	
	local damage = SpaceDamage(target, self.Damage)
	if self.Push == 1 then
		damage = SpaceDamage(target, self.Damage, dir)
	end
	

	ret:AddProjectile(damage, self.ProjectileArt, NO_DELAY)
	
	for i = 1, distance  do
		ret:AddDelay(0.06)
		ret:AddBounce(p1 + DIR_VECTORS[dir]*i, -3)
		local curr = p1 + DIR_VECTORS[dir]*i
		local damage = SpaceDamage( curr , 0 )  
		local makeIce = 0 
		
		if not Board:IsTerrain(curr,TERRAIN_LAVA) and Board:GetTerrain(curr) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(curr) and not Board:IsPod(curr) and not Board:IsSpawning(curr)  then	
			makeIce  = 1
			if Board:GetTerrain(curr) ~= TERRAIN_ICE then
				damage.iTerrain = TERRAIN_ICE
				damage.sImageMark = "combat/icons/narD_icon_ice_glow.png"				
				if Board:IsFire(curr) then
					damage.iTerrain = TERRAIN_WATER
					damage.sImageMark = "combat/icons/tosx_create_water_icon_glow.png"
				end
			end
		end
		
		if Board:IsBuilding(curr) and self.BuildingFreeze == 1 then 
			damage.iFrozen = 1	
		end

		ret:AddDamage(damage)

		--if self.IceBreak > 0 and not Board:IsTerrain(curr,TERRAIN_LAVA) and Board:GetTerrain(curr) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(curr) and not Board:IsPod(curr) and not Board:IsSpawning(curr) then --  i ~=distance and
		if self.IceBreak > 0 and makeIce == 1 then
			damage = SpaceDamage(curr , self.IceBreak) 		
			if not Board:IsTerrain(curr,TERRAIN_ICE) and not Board:IsTerrain(curr,TERRAIN_LAVA) and not Board:IsSpawning(curr)  then
				damage.sImageMark = "combat/icons/narD_icon_icecrack_glowU.png"
			end
			if Board:IsFire(curr) then
				damage.sImageMark = "combat/icons/tosx_create_water_icon_glowU.png"
			end
			ret:AddDamage(damage)
		end
		makeIce = 0 
		
		damage = SpaceDamage(p1 + DIR_VECTORS[dir]*i + DIR_VECTORS[(dir+1)%4], 0, (dir+1)%4)
		damage.sAnimation = "gaia_zeta_iceblast_"..(dir+1)%4
		ret:AddDamage(damage)
		damage = SpaceDamage(p1 + DIR_VECTORS[dir]*i + DIR_VECTORS[(dir-1)%4], 0, (dir-1)%4)
		damage.sAnimation = "gaia_zeta_iceblast_"..(dir-1)%4 -- exploout0_
		ret:AddDamage(damage)

	end

	-- if self.Unstable == 1 then
	-- 	damage = SpaceDamage(target, 0, dir)
	-- 	if not Board:IsTerrain(target,TERRAIN_LAVA) and Board:GetTerrain(target) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(target) and not Board:IsPod(target) and not Board:IsSpawning(target) and Board:GetTerrain(target) ~= TERRAIN_ICE then	
	-- 		damage.sImageMark = "combat/icons/narD_icon_ice_glowU.png"
	-- 	end
	-- 	ret:AddDamage(damage)
	-- end


	local count = 0 
	for i = 0, 7 do
		for j = 0, 7  do
			local curr = Point(i,j)
			if Board:IsTerrain(curr,TERRAIN_ICE) then
				count = count + 1 
			end
		end
	end
	
	if count >= 30 then 
		ret:AddScript("narD_frost_Chievo('narD_frost_WIC')")
	end

	

	return ret
	
end

narD_SidePushShot_A = narD_SidePushShot:new{
--narD_SidePushShot_B = narD_SidePushShot:new{
	--Limited = 2,
	UpgradeDescription = "Instead ice tile, create broken ice tile." , 
	IceBreak = 1, 
	
}

-- narD_SidePushShot_A = narD_SidePushShot:new{
-- 	UpgradeDescription = "Range scaling", 
-- 	--"Pushing shooter and target in opposite directions.",--"This attack will freeze Grid Buildings.",

-- 	--BuildingFreeze = 1, 
-- 	--Unstable = 1, 
-- 	Zeroing = 1,

-- 	TipImage = {
-- 		Unit = Point(2,4),
-- 		--Enemy = Point(2,2),
-- 		Enemy2 = Point(3,2),
-- 		Enemy3 = Point(3,3),
-- 		Enemy4 = Point(3,0),
-- 		Target = Point(2,2),

-- 		Building = Point (2,0), 
-- 	}
-- }

-- narD_SidePushShot_AB = narD_SidePushShot:new{
-- 	--Damage = 2, 
-- 	IceBreak  = 1, 
-- 	--Unstable = 1,
-- 	Zeroing = 1, 
-- 	--BuildingFreeze = 1, 
-- }

---rework end 


nard_frostMoaun = Skill:new{
	Name = "Frost Hammer(old)",
	Description = "Damage 2 adjacent tiles, pushing them apart and creating Ice tiles. Deals more damage to Ice tiles.",
	--Description = "Punch an adjacent tiles, pushing them to the left and right. More Damage to units on the Ice Tile.",-- \n\n (Full Upgrade Bonus :\n ???) ", 
	--"Push target tile and Make tiles to Ice. More Damage to units that already on Ice Tile. \n\n (Full Upgrade Bonus :\n ???)", 
	Class = "Prime", 
	Icon = "weapons/frost_warhammer.png", 
	Rarity = 2, 
	Shield = 0, 
	MinDamage = 1, 
	IceDamage = 2,
	Damage = 3,
	FriendlyDamage = true, 
	Cost = "low", 
	PowerCost = 1, 
	Upgrades = 2, 
	UpgradeCost = {2,2}, 
	Range = 1, 
	PathSize = 1,
	Projectile = false, 
	Freeze = 0,
	Backhit = 0,
	Push = 1,
	LaunchSound = "/weapons/shift", --"/weapons/flamethrower", --"/weapons/shield_bash",  
	Full_Upgrade  = 0,
	--TipImage = StandardTips.Melee, --
	
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(1,1),
		Enemy2 = Point(2,1),
		Enemy3 = Point(3,1),
		Target = Point(2,1),
		Mountain = Point(4,1),
		Building = Point(0,1),

		Second_Origin = Point(2,2),
		Second_Target = Point(2,1),
	},
	
	
	--IceIcon = "combat/tile_icon/tile_lava.png",
}

function nard_frostMoaun:GetTargetArea(point) --주황색 범위체크.
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 1, self.PathSize do
			local curr = DIR_VECTORS[i]*k + point
			ret:push_back(curr)
			if not Board:IsValid(curr) or Board:GetTerrain(curr) == TERRAIN_MOUNTAIN then
				break
			end
		end
	end

	-- if isTipImage() then
	-- 	Board:SetTerrain(Point(2,1), TERRAIN_ICE)
	-- end 

	return ret
end


function nard_frostMoaun:GetSkillEffect(p1, p2) --스킬 이펙트 부분.
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local distance = p1:Manhattan(p2)
			 
	--local exploding = Board:IsPawnSpace(p2) and (Board:GetTerrain(p2) == TERRAIN_ICE)
	local damage = SpaceDamage(p2,self.MinDamage, ((dir-1)%4)*self.Push)
	--damage.sAnimation = "explopunch1_"..((dir-1)%4)
	damage.sAnimation =  "gaia_zeta_iceblast_"..((dir-1)%4)
	
	-- if exploding then 
	if (Board:GetTerrain(p2) == TERRAIN_ICE) then
		damage.iDamage = damage.iDamage + self.IceDamage
	end


	for i = 0, 1 do
			
		local curr = p2 + DIR_VECTORS[((dir+1)%4)]*i  
		local spaceDamage2 = SpaceDamage(curr, 0 ) 
		
		--if Board:GetTerrain(p2) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(p2) and not Board:IsPod(p2) and not Board:IsSpawning(p2) and Board:GetTerrain(p2) ~= TERRAIN_ICE then
		if not Board:IsTerrain(curr,TERRAIN_LAVA) and Board:GetTerrain(curr) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(curr) and not Board:IsPod(curr) and not Board:IsSpawning(curr) and Board:GetTerrain(curr) ~= TERRAIN_ICE then	
			spaceDamage2.iTerrain = TERRAIN_ICE
			if Board:IsFire(curr) then
				--spaceDamage.iSmoke =1
				--spaceDamage2.iAcid = 1 
				spaceDamage2.iTerrain = TERRAIN_WATER
			end
		end
		
		if (self.Full_Upgrade == 1 ) and Board:IsFrozen(curr) then
			spaceDamage2.iDamage = DAMAGE_DEATH		
		end
		
		ret:AddDamage(spaceDamage2)
	end

	
	local damage2 = SpaceDamage(p2 + DIR_VECTORS[((dir+1)%4)], self.MinDamage ,  ((dir+1)%4) )  -- SpaceDamage(curr, 0 ,  ((dir+1)%4) ) 

	--  Board:IsPawnSpace(p2 + DIR_VECTORS[((dir+1)%4)]) and 
	if (Board:GetTerrain(p2 + DIR_VECTORS[((dir+1)%4)]) == TERRAIN_ICE) then
		damage2.iDamage = damage2.iDamage + self.IceDamage
	end 

	damage2.sAnimation =  "gaia_zeta_iceblast_"..((dir+1)%4)


	ret:AddDamage(damage)
	ret:AddDamage(damage2)

	

	return ret
end

nard_frostMoaun_A = nard_frostMoaun:new{ --
	UpgradeDescription = "Increases minimum damage by 1.",
	--Damage =4, 
	MinDamage = 2,
	IceDamage = 1,  
}

nard_frostMoaun_B = nard_frostMoaun:new{ --
	UpgradeDescription = "Increases max damage by 1.",
	Damage = 4,
	IceDamage = 3, 
	
}

nard_frostMoaun_AB = nard_frostMoaun:new{ --세번째 업그레이드를 적용한 경우. 
	Damage = 4, --4,
	IceDamage = 2,
	MinDamage = 2 , 
	

}

----

nard_Iceball  = Ranged_BackShot:new {-- LineArtillery:new{
	Name = "Icycle Launcher",
	--Description = "Artillery that creates 2 Ice tiles, pushing one left and one right. Deals more damage to Ice tiles.",
	Description = "Artillery that creates 2 Ice tiles, pushing back/forward.  Deals more damage to Ice tiles.",
	--Description = "Deals damage and makes ice to two tiles, pushing one left and one right.More Damage to units on the Ice Tile.",
	Class = "Ranged",
	Icon = "weapons/frost_range.png",
	Sound = "",
	ArtilleryStart = 2,
	ArtillerySize = 8,
	Explosion = "",
	PowerCost = 1,
	BounceAmount = 1,
	--SelfDamage = 1,
	MinDamage = 0 ,
	Damage = 2,
	--CenterDamage = 0, 
	LaunchSound = "/weapons/ice_throw",
	ImpactSound = "/impact/generic/ice",
	Upgrades = 2,
	Push = false,
	-- BuildingDamage = true,
	-- Sides = false,
	Full_Upgrade = 0,

	UpgradeCost = {1,2},
	
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Mountain = Point(4,1),
		Mountain = Point(2,3),
		Target = Point(2,2), --(2,1),

		
		Second_Origin = Point(2,4),
		Second_Target = Point(2,1),
	}
}

function nard_Iceball:GetTargetArea(point)
	
	if isTipImage() then
		Board:SetTerrain(Point(2,1), TERRAIN_ICE)
		--Board:SetTerrain(Point(2,4), TERRAIN_ICE)
		Board:SetTerrain(Point(2,2), TERRAIN_FIRE)
	end 

	return ArtilleryDefault:GetTargetArea(point)

end


function nard_Iceball:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	

	--local IceDamage = self.Damage 


	ret:AddBounce(p1, 1)
	
	local p3 = p2 + DIR_VECTORS[dir]
	
	local p2dam = self.Damage--(Board:IsBuilding(p2) and not self.BuildingDamage) and 0 or self.Damage
	local p3dam = self.Damage--(Board:IsBuilding(p3) and not self.BuildingDamage) and 0 or self.Damage
	

	local spaceDamage2 = SpaceDamage(p2,0) 
	ret:AddArtillery(spaceDamage2,self.UpShot1,NO_DELAY)

	local spaceDamage3 = SpaceDamage(p3,0) 
	ret:AddArtillery(spaceDamage3,self.UpShot2)

	--Board:GetTerrain(p2) ~= TERRAIN_LAVA

	if not Board:IsTerrain(p2,TERRAIN_LAVA)  and Board:GetTerrain(p2) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(p2) and not Board:IsPod(p2) and not Board:IsSpawning(p2) and Board:GetTerrain(p2) ~= TERRAIN_ICE then
		spaceDamage2.iTerrain = TERRAIN_ICE
		if Board:IsFire(p2) then
			spaceDamage2.iTerrain = TERRAIN_WATER
		end
		
		ret:AddDamage(spaceDamage2) 		
	end
	
	if not Board:IsTerrain(p3,TERRAIN_LAVA) and Board:GetTerrain(p3) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(p3) and not Board:IsPod(p3) and not Board:IsSpawning(p3) and Board:GetTerrain(p3) ~= TERRAIN_ICE then
		spaceDamage3.iTerrain = TERRAIN_ICE
		if Board:IsFire(p3) then
			spaceDamage3.iTerrain = TERRAIN_WATER
		end
		
		ret:AddDamage(spaceDamage3) 		
	end


	-- local damage = SpaceDamage(p2,p2dam,(dir+1)%4)
	-- damage.sAnimation = "gaia_zeta_iceblast_"..(dir+1)%4
	
	local damage = SpaceDamage(p2,p2dam,(dir+2)%4)
	damage.sAnimation = "gaia_zeta_iceblast_"..(dir+2)%4
	
	
	if Board:GetTerrain(p2) ~= TERRAIN_ICE then 
		--IceDamage = 0  
		damage.iDamage = self.MinDamage --1 + self.CenterDamage 
		
		-- if not self.BuildingDamage and Board:IsBuilding(p2) then
		-- 	damage.iDamage = 0 
		-- end

		if (self.Full_Upgrade == 1) and (Board:GetTerrain(p2) == TERRAIN_WATER) then
			damage.iFrozen = EFFECT_CREATE
		end
	end

	if (self.Full_Upgrade == 1 ) and Board:IsFrozen(p2) then
		damage.iDamage = DAMAGE_DEATH		
	end

	--ret:AddArtillery(damage,self.UpShot1,NO_DELAY)
	ret:AddDamage(damage)


	-- damage = SpaceDamage(p3,p3dam,(dir-1)%4)
	damage = SpaceDamage(p3,p3dam,(dir)%4)

	if Board:GetTerrain(p3) ~= TERRAIN_ICE then 
		--IceDamage = 0  
		damage.iDamage = self.MinDamage --1 + self.CenterDamage 
		
		-- if not self.BuildingDamage and Board:IsBuilding(p2) then
		-- 	damage.iDamage = 0 
		-- end

		if (self.Full_Upgrade == 1) and (Board:GetTerrain(p3) == TERRAIN_WATER) then
			damage.iFrozen = EFFECT_CREATE
		end
	end

	if (self.Full_Upgrade == 1 ) and Board:IsFrozen(p3) then
		damage.iDamage = DAMAGE_DEATH		
	end

	damage.bHidePath = true
	-- damage.sAnimation = "gaia_zeta_iceblast_"..(dir-1)%4
	damage.sAnimation = "gaia_zeta_iceblast_"..(dir)%4
	--ret:AddArtillery(damage,self.UpShot2)
	ret:AddDamage(damage)

	ret:AddBounce(p2, self.BounceAmount)
	ret:AddBounce(p3, self.BounceAmount)
	
	return ret
end

nard_Iceball_A = nard_Iceball:new{
	--Sides = true,
	UpgradeDescription = "Increases minimum damage by 1.",--"Building Immune",
	MinDamage = 1,
	
} 

nard_Iceball_B = nard_Iceball:new{
	
	UpgradeDescription = "Increases max damage by 1.",
	Damage = 3,
	
} 

nard_Iceball_AB = nard_Iceball:new{
	BuildingDamage = false,
	MinDamage = 1,
	Damage = 3,	
} 



nard_DragonFire = Skill:new{
	Name = "Frost Bombs",
	Description =  "Fly over targets, flipping their attack direction and creating Ice tiles.", --" And Push tiles on either side when jumping.",-- \n\n ( Full Upgrade Bonus :\n ???)", 
	Class = "Brute", --"Science",
	Icon =  "weapons/iceBomb.png",
	Rarity = 3,
	AttackAnimation = "ExploRepulse3",--"ExploRaining1",
	Sound = "/general/combat/stun_explode",
	MinMove = 2,
	Range = 2,--3,    -- n : n-1 칸 
	Damage = 1,--0,
	Damage2 = 0,
	AnimDelay = 0.2,
	
	SidePush = false, --true, 
	Full_Upgrade = 0, 
	
	Shield = 0 , 
	PowerCost = 1,
	DoubleAttack = 0, --does it attack again after stopping moving
	Upgrades = 2,
	UpgradeCost = {1,2},
	LaunchSound = "/weapons/enhanced_tractor",----"/weapons/bomb_strafe",
	BombSound = "/impact/generic/tractor_beam",--"/impact/generic/explosion",

	--CustomTipImage = "MyWeaponTip",

	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		--Enemy2 = Point(2,2),
		Enemy3 = Point(3,3),
		Target = Point(2,2),--Point(2,1),
		CustomEnemy = "Firefly2", --"Scorpion2",
		Building = Point(4,2),
		Length = 4,
			
	}

}

MyWeaponTip = nard_DragonFire:new{}

function MyWeaponTip:GetSkillEffect(p1, p2)
	local enemy = Board:GetPawn(self.TipImage.Enemy)

    
    if enemy then
		enemy:FireWeapon(self.TipImage.Unit, 1)
    end
	
    return nard_DragonFire:GetSkillEffect(p1, p2)
end


function nard_DragonFire:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = self.MinMove, self.Range do
			if not Board:IsBlocked(DIR_VECTORS[i]*k + point, Pawn:GetPathProf()) then
				ret:push_back(DIR_VECTORS[i]*k + point)
			end
		end
	end
	
	return ret
end


function nard_DragonFire:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	
	local distance = p1:Manhattan(p2)
	
	ret:AddBounce(p1,2)
	if distance == 1 then
		ret:AddLeap(move, 0.5)--small delay between move and the damage, attempting to make the damage appear when jet is overhead
	else
		ret:AddLeap(move, 0.25)
	end
		
	for k = 1, (self.Range -1) do
		
		local curr = p1 + DIR_VECTORS[dir]*k 
		if curr == p2  then -- + DIR_VECTORS[dir] then
		 	break --k = self.Range 
		end	
		
		local damage = SpaceDamage(curr, self.Damage , DIR_FLIP)
		
		local makeIce = 0 
		-- if (curr == p1) or (curr == p2) then
		-- 	damage = SpaceDamage(curr, self.Damage)
		-- end

		damage.sAnimation = self.AttackAnimation
		damage.sSound = self.BombSound
		
		local spaceDamage3 = SpaceDamage(curr, 0) 
		
		if not Board:IsTerrain(curr,TERRAIN_LAVA) and Board:GetTerrain(curr) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(curr) and not Board:IsPod(curr) and not Board:IsSpawning(curr) and Board:GetTerrain(curr) ~= TERRAIN_ICE then
			makeIce = 1
			spaceDamage3.iTerrain = TERRAIN_ICE
			if Board:IsFire(curr) then
				spaceDamage3.iTerrain = TERRAIN_WATER
			end

			ret:AddDamage(spaceDamage3) 
		end

		-- if (self.Full_Upgrade == 1 ) and Board:IsFrozen(curr) then
		-- 	damage.iDamage = DAMAGE_DEATH		
		-- end

		if k ~= 1 then
			ret:AddDelay(self.AnimDelay) --was 0.2
		end
		
		if makeIce == 1  then				
			damage.sImageMark = "combat/icons/narD_icon_icecrack_glowU.png"
			if Board:IsFire(curr) then
				damage.sImageMark = "combat/icons/tosx_create_water_icon_glowU.png"
			end
		end
		ret:AddDamage(damage)
		ret:AddBounce(curr,3)
		
		
		damage = SpaceDamage(p2, 0) 
		damage.iShield = self.Shield  
		ret:AddDamage(damage) 
	
		-- if self.SidePush  then
		-- 	local damage2 = SpaceDamage(curr + DIR_VECTORS[(dir+1)%4], 0, (dir+1)%4)
		-- 	damage2.sAnimation =  "exploout0_"..(dir+1)%4  --"gaia_zeta_iceblast_"..((dir+1)%4)--
		-- 	ret:AddDamage(damage2)
		-- 	damage2 = SpaceDamage(curr + DIR_VECTORS[(dir-1)%4], 0, (dir-1)%4)
		-- 	damage2.sAnimation = "exploout0_"..(dir-1)%4 --"gaia_zeta_iceblast_"..((dir-1)%4)--
		-- 	ret:AddDamage(damage2)
		-- end

	end

	local countEnemy = Board:GetEnemyCount()
	ret:AddScript(string.format([[
		local fx = SkillEffect();
		fx:AddScript("if %s - Board:GetEnemyCount() > 1 then narD_frost_Chievo('narD_frost_IceBreaker') end")
		Board:AddEffect(fx);
	]], countEnemy))


	local count = 0 
	for i = 0, 7 do
		for j = 0, 7  do
			local curr = Point(i,j)
			if Board:IsTerrain(curr,TERRAIN_ICE) then
				count = count + 1 
			end
		end
	end
	
	if count >= 30 then 
		ret:AddScript("narD_frost_Chievo('narD_frost_WIC')")
	end

	return ret
end

nard_DragonFire_A = nard_DragonFire:new{
	UpgradeDescription = "Increase range by 1",--"Gain Shield",
	--Shield = 1, 
	Range = 3 ,

	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Enemy2 = Point(2,2),
		Enemy3 = Point(3,3),
		Target = Point(2,1),
		CustomEnemy = "Firefly2", --"Scorpion2",
		Building = Point(4,2),
		Length = 4,
			
	}


}

nard_DragonFire_B = nard_DragonFire:new{
	--UpgradeDescription = "Push tiles on either side when jumping.",
	UpgradeDescription = "Increase damage by 1" , --"Allows jumping over any number of additional targets.",
	Damage = 2, 
	
}

nard_DragonFire_AB = nard_DragonFire:new{

	Damage = 2, 
	Range = 3 ,  -- 
	
	--Shield = 1, 
	
}


nard_PhaseShield =  Skill:new{
	Name = "Cryo-Phaser",
	--Description =  "Shoot a projectile that phases through allies and Buildings. Buildings are Frozen.",
	Description =  "Shoot a projectile that phases through all obstacles. Buildings are Frozen.",
	--Description =  "Shoot a projectile that phases through objects and Freeze to buildings it passes through." , -- \n\n (Full Upgrade Bonus :\n ???)", 
	Class = "Science",
	Icon = "weapons/phaseFrost.png",
	Explosion = "",
	Explo = "gaia_zeta_iceblast_", --"explopush1_",
	Sound = "/general/combat/explode_small",
	ProjectileArt = "effects/shot_phaseshot",
	Damage = 0,
	Push = 0,
	PowerCost = 1,
	Range = 2, 
	Upgrades = 2,
	Limited = 2,
	Phase = true,

	AllyShield = false, 
	Full_Phase = true, -- false, 

	--PhaseShield = true,
	SelfDamage = 0, 
	LeftShot = false,
	RightShot = false,
	
	UpgradeCost = {2,2},
	LaunchSound = "/weapons/phase_shot",
	ImpactSound = "/impact/generic/explosion",
	--TipImage = StandardTips.Ranged
	TipImage = {
		Unit = Point(2,3),
		Building = Point(2,2),
		Building2 = Point(3,3),
		Building3 = Point(1,3),
		Target = Point(2,2)
	}
}

function nard_PhaseShield:GetTargetArea(p1)

	if not self.Phase then
		return Board:GetSimpleReachable(p1, self.PathSize, self.CornersAllowed)
	else
		local ret = PointList()
	
		for dir = DIR_START, DIR_END do
			for i = 1, self.Range do
				local curr = Point(p1 + DIR_VECTORS[dir] * i)
				if not Board:IsValid(curr) then
					break
				end
				
				ret:push_back(curr)
				
				if not self.Full_Phase and  Board:IsBlocked(curr,PATH_PHASING) then
					break
				end
			end
		end
	
	return ret
	
	end
end

function nard_PhaseShield:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)

	local pathing = self.Phase and PATH_PHASING or PATH_PROJECTILE
	local target = GetProjectileEnd(p1,p2,pathing)  

	
	if self.Full_Phase then
		target = p1 
		--while Board:IsValid(target) do
		for i=1, self.Range do 
			target = target + DIR_VECTORS[dir]
			if not Board:IsValid(target) then 
				target = target - DIR_VECTORS[dir]
				break
			end
		end
		--target = target - DIR_VECTORS[dir] -- (n-1 ). 
	end
	
	local damage = SpaceDamage(target, self.Damage)

	damage.sAnimation = self.Explo..dir
	if self.Push == 1 then
		damage.iPush = dir
	end


	if self.Phase and Board:IsBuilding(target) then
		damage.sAnimation = ""
	end
	
	ret:AddProjectile(damage, self.ProjectileArt, NO_DELAY)--"effects/shot_mechtank")

	local temp = p1 + DIR_VECTORS[dir]
	while true do
		if Board:IsBuilding(temp) then -- or (Board:GetPawnTeam(temp) == TEAM_PLAYER) then
			damage = SpaceDamage(temp, 0)
			--damage.iShield = 1
			damage.iFrozen = 1
			ret:AddDamage(damage)
		end
	
		if self.AllyShield and (Board:GetPawnTeam(temp) == TEAM_PLAYER) then
			damage = SpaceDamage(temp, 0)
			damage.iShield = 1
			--damage.iFrozen = 1
			ret:AddDamage(damage)
		end

		if temp == target then
			break
		end
		
		temp = temp + DIR_VECTORS[dir]
	end

	
	return ret
end




nard_PhaseShield_A = nard_PhaseShield:new{
	UpgradeDescription =  "Applies a Shield to allies it passes through.",
	AllyShield = true, 
	--UpgradeDescription = "Allows fire additional projectile in your left directions. But decrease use conut.",
	--LeftShot = 1,
	--Limited = 1,
	--tool tip 
}

nard_PhaseShield_B = nard_PhaseShield:new{
	--UpgradeDescription =  "The projectile phases through all obstacles.",
	UpgradeDescription =  "The projectile range has been extended by 4.",
	Range = 4, 
	--Full_Phase = true, 
	
	--UpgradeDescription = "Allows fire additional projectile in your right directions. But decrease use conut. ",
	--RightShot = 1,
	--Limited = 1, 
	-- tool tip 
}

nard_PhaseShield_AB = nard_PhaseShield:new{
	--LeftShot = 1,
	--RightShot = 1,
	AllyShield = true,
	Range = 4, 
	--Full_Phase = true, 

	--Limited = 0, -- 2 ,  --full upgrade bonus
	--SelfDamage = 1, -- full upgrade bonus 
}
