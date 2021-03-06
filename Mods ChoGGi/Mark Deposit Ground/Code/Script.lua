-- See LICENSE for terms

local mod_id = "ChoGGi_MarkDepositGround"
local mod = Mods[mod_id]
local mod_AlienAnomaly = mod.options and mod.options.AlienAnomaly or false
local mod_HideSigns = mod.options and mod.options.HideSigns or false
local mod_ShowConstruct = mod.options and mod_ShowConstruct or false

local AsyncRand = AsyncRand
local GridOpFree = GridOpFree
local AsyncSetTypeGrid = AsyncSetTypeGrid
local sqrt = sqrt
local MulDivRound = MulDivRound

local TerrainTextures = TerrainTextures

local table_find = table.find
local texture_metal = table_find(TerrainTextures, "name", "RockDark") + 1
local texture_mpres = table_find(TerrainTextures, "name", "GravelDark") + 1
local texture_water = table_find(TerrainTextures, "name", "Spider") + 1

local function UpdateDeposit(d)
	if d:IsKindOf("EffectDeposit") then
		return
	end

	local NoisePreset = DataInstances.NoisePreset
	local pattern = NoisePreset.ConcreteForm:GetNoise(128, AsyncRand())
	pattern:land_i(NoisePreset.ConcreteNoise:GetNoise(128, AsyncRand()))

	if d:IsKindOf("SubsurfaceDepositMetals") then
		pattern:mul_i(texture_metal, 1)
	elseif d:IsKindOf("SubsurfaceDepositPreciousMetals") then
		pattern:mul_i(texture_mpres, 1)
	elseif d:IsKindOf("SubsurfaceDepositWater") then
		pattern:mul_i(texture_water, 1)
	else
		return
	end

	pattern:sub_i(1, 1)
	pattern = GridOpFree(pattern, "repack", 8)

	local scale = 100
	if d.max_amount == 500000000 then
		scale = 200
	elseif d.max_amount == 100000000 then
		scale = 150
	elseif d.max_amount == 50000000 then
		scale = 135
	elseif d.max_amount == 25000000 then
		scale = 120
	else
		scale = sqrt(MulDivRound(d.max_amount/1000, 10, 10))
	end

	scale = scale + 20

	AsyncSetTypeGrid{
		type_grid = pattern,
		pos = d:GetPos(),
		scale = scale,
		centered = true,
		invalid_type = -1,
	}

	-- we only want it to fire once per deposit
	d.ground_is_marked = true
end

local function UpdateOpacity(label, value)
	value = value and 0 or 100
	local deposits = UICity.labels[label] or ""
	for i = 1, #deposits do
		local d = deposits[i]
		d:SetOpacity(value)
		if not d.ground_is_marked then
			UpdateDeposit(d)
		end
	end
end

-- update as they become visible
function OnMsg.SubsurfaceDepositRevealed(d)
	d:SetOpacity(mod_HideSigns and 0 or 100)
	if not d.ground_is_marked then
		UpdateDeposit(d)
	end
end

local orig_TerrainDepositMarker_SpawnDeposit = TerrainDepositMarker.SpawnDeposit
function TerrainDepositMarker:SpawnDeposit(...)
	local d = orig_TerrainDepositMarker_SpawnDeposit(self, ...)
	d:SetOpacity(mod_HideSigns and 0 or 100)
	return d
end

local orig_SubsurfaceAnomalyMarker_SpawnDeposit = SubsurfaceAnomalyMarker.SpawnDeposit
function SubsurfaceAnomalyMarker:SpawnDeposit(...)
	local a = orig_SubsurfaceAnomalyMarker_SpawnDeposit(self, ...)
	if mod_AlienAnomaly then
		-- needs a delay for some reason
		CreateRealTimeThread(function()
			Sleep(50)
			a.ChoGGi_alien = a:GetEntity()
			a:ChangeEntity("GreenMan")
			a:SetScale(500)
			a:SetAngle(AsyncRand())
		end)
	end
	return a
end

-- startup
local function HideSigns()
	mod_AlienAnomaly = mod.options.AlienAnomaly
	mod_HideSigns = mod.options.HideSigns
	SuspendPassEdits("ChoGGi.MarkDepositGround.HideSigns")

	if mod_HideSigns then
		-- gotta use SetOpacity as SetVisible is set when you zoom out
		local value = mod_HideSigns and 0 or 100

		UpdateOpacity("SubsurfaceDeposit", value)
		UpdateOpacity("EffectDeposit", value)

		local deposits = UICity.labels.TerrainDeposit or ""
		for i = 1, #deposits do
			deposits[i]:SetOpacity(value)
		end
	end

	if mod_AlienAnomaly then
		deposits = UICity.labels.EffectDeposit or ""
		for i = 1, #deposits do
			local d = deposits[i]
			if d.ChoGGi_alien then
				d:ChangeEntity(d.ChoGGi_alien)
				d:SetScale(100)
				d:SetAngle(0)
				d.ChoGGi_alien = nil
			end
		end
	end
	ResumePassEdits("ChoGGi.MarkDepositGround.HideSigns")
end

OnMsg.CityStart = HideSigns
OnMsg.LoadGame = HideSigns

local function ChangeMarks(label, entity, value)
	local anomalies = UICity.labels[label] or ""
	if value then
		for i = 1, #anomalies do
			local a = anomalies[i]
			if entity == "AlienAnomaly" and not a.ChoGGi_alien then
				a.ChoGGi_alien = a:GetEntity()
			end
			a:ChangeEntity(entity)
			a:SetScale(500)
			a:SetAngle(AsyncRand())
		end
	else
		local g_Classes = g_Classes
		for i = 1, #anomalies do
			local a = anomalies[i]
			a:ChangeEntity(a.ChoGGi_alien or g_Classes[a.class]:GetEntity())
			a.ChoGGi_alien = nil
			a:SetScale(100)
			a:SetAngle(0)
		end
	end
end

local function UpdateOptions()
	-- update signs
	if GameState.gameplay then
		if mod_AlienAnomaly ~= mod.options.AlienAnomaly then
			mod_AlienAnomaly = mod.options.AlienAnomaly
			ChangeMarks("Anomaly", "GreenMan", mod_AlienAnomaly)
		end
		if mod_HideSigns ~= mod.options.HideSigns then
			mod_HideSigns = mod.options.HideSigns
			UpdateOpacity("SubsurfaceDeposit", mod_HideSigns)
			UpdateOpacity("EffectDeposit", mod_HideSigns)
			UpdateOpacity("TerrainDeposit", mod_HideSigns)
		end
	end
end

-- fired when option is changed
function OnMsg.ApplyModOptions(id)
	if id ~= mod_id then
		return
	end
	UpdateOptions()
end

-- for some reason mod options aren't retrieved before this script is loaded...
local function StartupCode()
	UpdateOptions()
end

OnMsg.CityStart = StartupCode
OnMsg.LoadGame = StartupCode

local orig_CursorBuilding_GameInit = CursorBuilding.GameInit
function CursorBuilding:GameInit()
	if mod_ShowConstruct and mod_HideSigns then
		UpdateOpacity("SubsurfaceDeposit", false)
		UpdateOpacity("EffectDeposit", false)
		UpdateOpacity("TerrainDeposit", false)
	end
	return orig_CursorBuilding_GameInit(self)
end

local orig_CursorBuilding_Done = CursorBuilding.Done
function CursorBuilding:Done()
	if mod_ShowConstruct and mod_HideSigns then
		UpdateOpacity("SubsurfaceDeposit", true)
		UpdateOpacity("EffectDeposit", true)
		UpdateOpacity("TerrainDeposit", true)
	end
	return orig_CursorBuilding_Done(self)
end
