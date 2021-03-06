-- See LICENSE for terms

local mod_id = "ChoGGi_ChangeDroneType"
local mod = Mods[mod_id]
local mod_Aerodynamics = mod.options and mod.options.Aerodynamics or false
local mod_AlwaysWasp = mod.options and mod.options.AlwaysWasp or false

local function ModOptions()
	mod_Aerodynamics = mod.options.Aerodynamics
	mod_AlwaysWasp = mod.options.AlwaysWasp
end

-- fired when option is changed
function OnMsg.ApplyModOptions(id)
	if id ~= mod_id then
		return
	end

	ModOptions()
end

-- for some reason mod options aren't retrieved before this script is loaded...
OnMsg.CityStart = ModOptions
OnMsg.LoadGame = ModOptions

-- function called when a drone is created
function City:CreateDrone()
	if mod_AlwaysWasp then
		return FlyingDrone:new{city = self}
	end
	local classdef = g_Classes[self.drone_class] or Drone
	return classdef:new{city = self}
end

-- devs made PickEntity always default to whatever has been spawned already, which we don't want
local IsValidEntity = IsValidEntity
local function PickEntity(self)
	local new_entity = g_Classes[self.class].entity
	if new_entity ~= self:GetEntity() and IsValidEntity(new_entity) then
		self:ChangeEntity(new_entity)
	end
end

Drone.PickEntity = PickEntity
FlyingDrone.PickEntity = PickEntity

-- drones have a func to set skins of all drones in same cc
function Drone:ChangeSkin(skin, palette)
	self:OnSkinChanged(skin, palette)
	local cc = self.command_center
	local drones = cc and cc.drones or ""
	for i = 1, #drones do
		local drone = drones[i]
		if drone ~= self and not drone:IsKindOf("FlyingDrone") then
			drone:OnSkinChanged(skin, palette)
		end
	end
end

-- add button to selection panels
function OnMsg.ClassesBuilt()
	local Translate = ChoGGi.ComFuncs.Translate
	local Strings = ChoGGi.Strings

	local type_str = Strings[302535920000266--[[Spawn--]]] .. ": %s"
	local name_table = {
		FlyingDrone = Translate(10278--[[Wasp Drone--]]),
		Drone = Translate(1681--[[Drone--]]),
	}

	local template_table = {
		RolloverTitle = [[Change Spawn Type]],
		RolloverText = [[Spawn wasp drones or regular drones.]],
		Title = [[Drone Type]],
		Icon = "UI/Icons/Sections/drone.tga",

		__condition = function()
			if mod_Aerodynamics then
				return UICity:IsTechResearched("MartianAerodynamics")
			else
				return true
			end
		end,

		OnContextUpdate = function(self, context)
			local city = context.city or UICity
			self:SetTitle(type_str:format(
				name_table[city.drone_class or "Drone"]
			))
		end,

		func = function(self, context)
			---
			local city = context.city or UICity
			if city.drone_class == "Drone" then
				city.drone_class = "FlyingDrone"
			else
				city.drone_class = "Drone"
			end
			self:SetTitle(type_str:format(name_table[city.drone_class]))
			---
		end,
	}

	template_table.__context_of_kind = "RCRover"
	ChoGGi.ComFuncs.AddXTemplate("ChangeDroneType", "ipRover", template_table)

	template_table.__context_of_kind = "DroneHub"
	ChoGGi.ComFuncs.AddXTemplate("ChangeDroneType", "ipBuilding", template_table)

end

-- set default drone type
local GetMissionSponsor = GetMissionSponsor
local function StartupCode()
	local city = UICity
	if mod_AlwaysWasp then
		city.drone_class = "FlyingDrone"
	else
		city.drone_class = city.drone_class or GetMissionSponsor().drone_class or "Drone"
	end
end

OnMsg.CityStart = StartupCode
OnMsg.LoadGame = StartupCode
