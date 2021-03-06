-- See LICENSE for terms

local mod_id = "ChoGGi_RaresPerRocket"
local mod = Mods[mod_id]

local r = const.ResourceScale

-- if modoptions aren't a thing yet
local function GetModValue()
	if mod.options then
		return mod.options.AmountOfRares * r
	end
	return 90 * r
end

local function UpdateExistingRockets()
	if not GameState.gameplay then
		return
	end

	local value = GetModValue()

	local rockets = UICity.labels.AllRockets or ""
	for i = 1, #rockets do
		local rocket = rockets[i]
		if rocket.export_requests then
			ChoGGi.ComFuncs.SetTaskReqAmount(rocket, value, "export_requests", "max_export_storage")
		else
			rocket.max_export_storage = value
		end
	end
end

-- update on new/load game
OnMsg.CityStart = UpdateExistingRockets
OnMsg.LoadGame = UpdateExistingRockets

-- update on mod applied
function OnMsg.ApplyModOptions(id)
	if id == mod_id then
		UpdateExistingRockets()
	end
end

-- set when new rocket made
function OnMsg.BuildingInit(obj)
	if obj:IsKindOf("SupplyRocket") then
		obj.max_export_storage = GetModValue()
	end
end

