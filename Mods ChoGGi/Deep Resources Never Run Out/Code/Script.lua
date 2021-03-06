local MapGet = MapGet

--~ depth_layer: 2 = core, 1 = underground

-- change to false to have it work on all SubsurfaceDeposits
local apply_to_core_only = true

local function LargerDeposits(objs)
	objs = objs or MapGet("map", "SubsurfaceDepositWater", "SubsurfaceDepositMetals", "SubsurfaceDepositPreciousMetals")

	local max = 500000 * const.ResourceScale

	for i = 1, #objs do
		local o = objs[i]
		if apply_to_core_only then
			if o.depth_layer == 2 then
				o.max_amount = max
				o.grade = "Very High"
			end
		else
			o.max_amount = max
			o.grade = "Very High"
		end
	end
end

local function RefillAllDeposits(objs)
	objs = objs or MapGet("map", "SubsurfaceDepositWater", "SubsurfaceDepositMetals", "SubsurfaceDepositPreciousMetals")

	for i = 1, #objs do
		local o = objs[i]
		if apply_to_core_only then
			if o.depth_layer == 1 then
				o:CheatRefill()
			end
		else
			o:CheatRefill()
		end
	end
end

function OnMsg.LoadGame()
	local objs = MapGet("map", "SubsurfaceDepositWater", "SubsurfaceDepositMetals", "SubsurfaceDepositPreciousMetals")
	LargerDeposits(objs)
	RefillAllDeposits(objs)
end
OnMsg.NewDay = RefillAllDeposits
