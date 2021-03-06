-- See LICENSE for terms

local white = white
local GridSpacing = const.GridSpacing
local HexSize = const.HexSize
local ShowHexRanges = ShowHexRanges

local mod_id = "ChoGGi_ShowMaxRadiusRange"
local mod = Mods[mod_id]

local function AddRadius(self, radius)
	local circle = Circle:new()
	circle:SetRadius(radius)
	circle:SetColor(white)
	self:Attach(circle)
end

local cls_saved_settings = {"TriboelectricScrubber", "SubsurfaceHeater", "CoreHeatConvector", "ForestationPlant"}
local cls_heaters = {"SubsurfaceHeater", "CoreHeatConvector"}

local orig_CursorBuilding_GameInit = CursorBuilding.GameInit
function CursorBuilding:GameInit()
	if not mod.options.ShowConstruct then
		return orig_CursorBuilding_GameInit(self)
	end

	if self.template:IsKindOfClasses(cls_saved_settings) then
		-- if ecm is active we check for custom range, otherwise use default
		local uirange
		local idx = table.find(ModsLoaded, "id", "ChoGGi_Library")
		if idx then
			local bs = ChoGGi.UserSettings.BuildingSettings[self.template.template_name]
			if bs and bs.uirange then
				uirange = bs.uirange
			end
		end
		uirange = uirange or self.template:GetPropertyMetadata("UIRange").max

		-- update with max size
		self.GetSelectionRadiusScale = uirange
		-- and call this again to update grid marker
		ShowHexRanges(UICity, false, self, "GetSelectionRadiusScale")

		if self.template:IsKindOfClasses(cls_heaters) then
			AddRadius(self, (uirange * GridSpacing) + HexSize)
		end

	elseif self.template:IsKindOf("MoholeMine") then
		AddRadius(self, MoholeMine.GetHeatRange(self.template))
	elseif self.template:IsKindOf("ArtificialSun") then
		AddRadius(self, ArtificialSun.GetHeatRange(self.template))
	elseif self.template:IsKindOf("AdvancedStirlingGenerator") then
		AddRadius(self, AdvancedStirlingGenerator.GetHeatRange(self.template))
	end

--~ 	ex(self)
	return orig_CursorBuilding_GameInit(self)
end

-- since the circle gets attached to the CursorBuilding it'll be removed when it's removed, no need to fiddle with :Close()
