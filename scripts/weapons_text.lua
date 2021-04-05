--[[
_Name = "",
_Description = "", 
_Upgrade1 = "",
_Upgrade2 = "",
_A_UpgradeDescription = "",
_B_UpgradeDescription = "",
]]--

-- 위의 표준에 맞춰서 적으면 게임상의 무기 툴팁에 그대로 표시된다. 
local  Weapon_Texts = {

nard_frostMoaun_Name = "FrostFist",
nard_frostMoaun_Description = "Push target tile and Make tiles to Ice. More Damage to units that already on Ice Tile. \n\n (Full Upgrade Bonus :\n +1 Range)", 
nard_frostMoaun_Upgrade1 = "+1 Damage",
nard_frostMoaun_Upgrade2 = "+1 Range",
nard_frostMoaun_A_UpgradeDescription = "Increases damage by 1.",
nard_frostMoaun_B_UpgradeDescription = "Increases range by 1.",

nard_Iceball_Name = "Frost-Launcher", 
nard_Iceball_Description = "Artillery attack and make Ice tile and pushes two adjacent tiles. \n\n (Full Upgrade Bonus :\n Building Immune)", 
nard_Iceball_Upgrade1 = "+2 Size",
nard_Iceball_Upgrade2 = "+1 Damage",
nard_Iceball_A_UpgradeDescription = "Add additional missiles to hit adjacent tiles.", 
nard_Iceball_B_UpgradeDescription = "Increases damage by 1.",

nard_DragonFire_Name = "Frost Bombs",
nard_DragonFire_Description =  "Fly over a target,  flipping its attack direction and make Ice tile. \n\n ( Full Upgrade Bonus :\n +2 Range)", 
nard_DragonFire_Upgrade1 = "+2 Range",
nard_DragonFire_Upgrade2 = "SidePush",
nard_DragonFire_A_UpgradeDescription = "Allows jumping over and attacking an additional targets.",
nard_DragonFire_B_UpgradeDescription = "pushing adjacent tiles away.",

nard_PhaseShield_Name = "Phase Shield",
nard_PhaseShield_Description =  "Shoot a projectile that phases through objects and Applies a Shield to buildings it passes through. \n\n (Full Upgrade Bonus :\n Unlimited Use)", 
nard_PhaseShield_Upgrade1 = "+ LeftShot",
nard_PhaseShield_Upgrade2 = "+ RightShot",
nard_PhaseShield_A_UpgradeDescription = "Allows fire additional projectile in your left directions.",
nard_PhaseShield_B_UpgradeDescription = "Allows fire additional projectile in your right directions.",

}

return  Weapon_Texts
