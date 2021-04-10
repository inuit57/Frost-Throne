
local this = {}

local path = mod_loader.mods[modApi.currentMod].resourcePath
local achvApi = require(path .."scripts/achievements/api")

function narD_frost_Chievo(id)
	-- exit if not our squad
	if GAME.squadTitles["TipTitle_"..GameData.ach_info.squad] ~= "Frost Throne" then return end
	-- exit if current one is unlocked
	if achvApi:GetChievoStatus(id) then	return end
	achvApi:TriggerChievo(id)
	-- if id == "narD_acid_falling" then
	-- 	achvApi:TriggerChievo("narD_acid_secret", {aa = true})
	-- elseif id == "narD_acid_crowded" then
	-- 	achvApi:TriggerChievo("narD_acid_secret", {bb = true})
	-- elseif id == "narD_acid_goride" then
	-- 	achvApi:TriggerChievo("narD_acid_secret", {cc = true})
	-- end
	-- if achvApi:IsChievoProgress("narD_acid_secret", {reward = true }) then return end
	-- if achvApi:IsChievoProgress("narD_acid_secret", {aa = true, bb = true, cc = true,}) then	
	-- 	achvApi:TriggerChievo("narD_acid_secret", {reward = true })	
	-- 	achvApi:ToastUnlock(tosx_windUnlock())
	-- end
end

local imgs = {
	"ach_2clear",
	"ach_3clear",
	"ach_4clear",
	"ach_perfect",
	"IceBreaker",
	"Slam",
	"WIC_2",
	-- "secret",
}

local achname = "narD_frost_"
for _, img in ipairs(imgs) do
	modApi:appendAsset("img/achievements/".. achname..img ..".png", path .."img/achievements/".. img ..".png")
	modApi:appendAsset("img/achievements/".. achname..img .."_gray.png", path .."img/achievements/".. img .."_gray.png")
end

achvApi:AddChievo{
	id = "narD_frost_IceBreaker",
	name = "IceBreaker",
	tip = "Kill 2 enemies with a single attack of the Frost Bombs with the Frost Throne squad",
	img = "img/achievements/narD_frost_IceBreaker.png",
}

achvApi:AddChievo{
	id = "narD_frost_Slam",
	name = "Ice Snap",
	tip = "Freeze 1 Building and kill 1 enemy with a singhle attack of the Frost Hammer with the Frost Throne squad.",
	img = "img/achievements/narD_frost_Slam.png",
}

achvApi:AddChievo{
	id = "narD_frost_WIC",
	name = "Winter Is Coming",
	tip = "Make 12 Broken Ice tiles with the Frost Throne squad",
	img = "img/achievements/narD_frost_WIC_2.png",
}

-- achvApi:AddChievo{
-- 		id = "narD_acid_secret",
-- 		name = "Secret Reward",
-- 		tip = "Complete all 3 squad achievements.\n\nFear of Falling: $aa\nCrowded Sky: $bb\nGoing for a Ride: $cc\n\nReward: $reward",
-- 		img = "img/achievements/narD_acid_secret.png",
-- 		objective = {
-- 			aa = true,
-- 			bb = true,
-- 			cc = true,
-- 			reward = "?|Secret Structure"
-- 		}
-- }

achvApi:AddChievo{
		id = "narD_frost_2clear",
		name = "Frost Throne 2 Island Victory",
		tip = "Complete 2 corporate islands then win the game.\n\nEasy: $easy\nNormal: $normal\nHard: $hard",
		img = "img/achievements/narD_acid_ach_2clear.png",
		objective = {
			easy = true,
			normal = true,
			hard = true,
		}
}

achvApi:AddChievo{
		id = "narD_frost_3clear",
		name = "Frost Throne 3 Island Victory",
		tip = "Complete 3 corporate islands then win the game.\n\nEasy: $easy\nNormal: $normal\nHard: $hard",
		img = "img/achievements/narD_acid_ach_3clear.png",
		objective = {
			easy = true,
			normal = true,
			hard = true,
		}
}

achvApi:AddChievo{
		id = "narD_frost_4clear",
		name = "Frost Throne 4 Island Victory",
		tip = "Complete 4 corporate islands then win the game.\n\nEasy: $easy\nNormal: $normal\nHard: $hard",
		img = "img/achievements/narD_acid_ach_4clear.png",
		objective = {
			easy = true,
			normal = true,
			hard = true,
		}
}

achvApi:AddChievo{
		id = "narD_frost_perfect",
		name = "Frost Throne Perfect",
		tip = "Win the game and obtain the highest possible score.",
		img = "img/achievements/narD_acid_ach_perfect.png"
}

-- function tosx_windUnlock()
-- 	return {
-- 		unlockTitle = 'Structure Unlocked!',
-- 		name = 'Secret Aerodrome',
-- 		tip = 'Aerodrome unlocked. This structure can now appear in missions.',
-- 		img = 'img/achievements/'..achname..'secret.png',
-- 	}
-- end

return this