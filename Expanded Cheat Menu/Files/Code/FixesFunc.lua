--See LICENSE for terms

local GetObjects = GetObjects
---------fixes
function ChoGGi.MenuFuncs.FireMostFixes()
  local ChoGGi = ChoGGi
  ChoGGi.MenuFuncs.RemoveUnreachableConstructionSites()
  ChoGGi.MenuFuncs.ParticlesWithNullPolylines()
  ChoGGi.MenuFuncs.StutterWithHighFPS()

  ChoGGi.MenuFuncs.AttachBuildingsToNearestWorkingDome()
  ChoGGi.MenuFuncs.DronesKeepTryingBlockedAreas()
  ChoGGi.MenuFuncs.RemoveYellowGridMarks()
  ChoGGi.MenuFuncs.CablesAndPipesRepair()
  ChoGGi.MenuFuncs.MirrorSphereStuck()
  ChoGGi.MenuFuncs.ProjectMorpheusRadarFellDown()
end

function ChoGGi.MenuFuncs.ColonistsStuckOutsideRocket()
  local UICity = UICity
  local FindNearestObject = FindNearestObject
  local GenerateColonistData = GenerateColonistData
  local Msg = Msg
  local DoneObject = DoneObject

  local function SpawnColonist(old_c,rocket,pos)
    local dome = FindNearestObject(UICity.labels.Dome or empty_table,old_c or rocket)
    if not dome then
      return
    end

    local colonist
    if old_c then
      colonist = GenerateColonistData(UICity, old_c.age_trait, false, old_c.gender, old_c.entity_gender, true)
      --we set all the set gen doesn't (it's more for random gen after all
      colonist.birthplace = old_c.birthplace
      colonist.death_age = old_c.death_age
      colonist.name = old_c.name
      colonist.race = old_c.race
      colonist.specialist = old_c.specialist
      for trait_id, _ in pairs(old_c.traits) do
        if trait_id and trait_id ~= "" then
          colonist:AddTrait(trait_id,true)
        end
      end
      --if spec is different then updates to new entity
      colonist:ChooseEntity()
    else
      --GenerateColonistData(city, age_trait, martianborn, gender, entity_gender, no_traits)
      colonist = GenerateColonistData(UICity)
    end

    colonist.dome = dome
    colonist.current_dome = dome
    Colonist:new(colonist)
    Msg("ColonistBorn", colonist)
    colonist:SetPos(pos or dome:PickColonistSpawnPt())
    dome:UpdateUI()
    return colonist
  end

  local rockets = GetObjects({class="SupplyRocket"})
  local pos
  for i = 1, #rockets do
    pos = rockets[i]:GetPos()
    local Attaches = type(rockets[i].GetAttaches) == "function" and rockets[i]:GetAttaches() or empty_table
    Attaches = ChoGGi.ComFuncs.FilterFromTable(Attaches,nil,{Colonist=true},"class")
    if #Attaches > 0 then
      for j = #Attaches, 1, -1 do
        local c = Attaches[j]
        if not pcall(function()
          c:Detach()
          pos = type(c.GetPos) == "function" and c:GetPos() or pos
          SpawnColonist(c,rockets[i],pos)
        end) then
          SpawnColonist(nil,rockets[i],pos)
          --something messed up with so just spawn random colonist
        end
        if type(c.Done) == "function" then
          c:Done()
        end
        DoneObject(c)
      end
    end
  end

end

function ChoGGi.MenuFuncs.ParticlesWithNullPolylines()
  local objs = GetObjects({class = "ParSystem"}) or empty_table
  for i = 1, #objs do
    if type(objs[i].polyline) == "string" and objs[i].polyline:find("\0") then
      objs[i]:delete()
    end
  end
end

function ChoGGi.MenuFuncs.RemoveMissingClassObjects()
  local ChoGGi = ChoGGi
  local objs = GetObjects({class = "UnpersistedMissingClass"}) or empty_table
  for i = 1, #objs do
    ChoGGi.CodeFuncs.DeleteObject(objs[i])
  end
end

function ChoGGi.MenuFuncs.MirrorSphereStuck()
  local ChoGGi = ChoGGi
  local objs = GetObjects({class = "MirrorSphere"}) or empty_table
  for i = 1, #objs do
    if not IsValid(objs[i].target) then
      ChoGGi.CodeFuncs.DeleteObject(objs[i])
    end
  end
  objs = GetObjects({class = "ParSystem"}) or empty_table
  for i = 1, #objs do
    if objs[i]:GetProperty("ParticlesName") == "PowerDecoy_Captured" and
        type(objs[i].polyline) == "string" and objs[i].polyline:find("\0") then
      objs[i]:delete()
    end
  end
end

function ChoGGi.MenuFuncs.StutterWithHighFPS()
  local objs = GetObjects({class = "Unit"}) or empty_table
  --CargoShuttle
  for i = 1, #objs do
    -- 102 is from :GetMoveAnim(), 0 is stopped or idle?
    if objs[i]:GetAnim() > 0 and objs[i]:GetPathLen() == 0 then
      --trying to move with no path = lag
      objs[i]:InterruptCommand()
    end
  end

  objs = UICity.labels.Colonist or empty_table
  for i = 1, #objs do
    --only need to do people walking outside (pathing issue), and if they don't have a path (not moving or walking into an invis wall)
    if objs[i]:IsValidPos() and not objs[i]:GetPath() then
      --too close and they keep doing the human centipede
      local x,y,_ = objs[i]:GetVisualPosXYZ()
      objs[i]:SetCommand("Goto", GetPassablePointNearby(point(x+5000,y+5000)))
    end
  end

end

function ChoGGi.MenuFuncs.DronesKeepTryingBlockedAreas()
  local ChoGGi = ChoGGi
  local function ResetPriorityQueue(Class)
    local Hubs = GetObjects({class=Class}) or empty_table
    for i = 1, #Hubs do
      --clears out the queues
      Hubs[i].priority_queue = {}
      for priority = -1, const.MaxBuildingPriority do
        Hubs[i].priority_queue[priority] = {}
      end
    end
  end
  ResetPriorityQueue("SupplyRocket")
  ResetPriorityQueue("RCRover")
  ResetPriorityQueue("DroneHub")
  --toggle working state on all ConstructionSite (wakes up drones else they'll wait at hub)
  local Sites = GetObjects({class="ConstructionSite"}) or empty_table
  for i = 1, #Sites do
    ChoGGi.CodeFuncs.ToggleWorking(Sites[i])
  end
end

function ChoGGi.MenuFuncs.AlignAllBuildingsToHexGrid()
  local Table = GetObjects({class="Building"})
  if Table[1] and Table[1].class then
    for i = 1, #Table do
      Table[i]:SetPos(HexGetNearestCenter(Table[i]:GetPos()))
    end
    ChoGGi.ComFuncs.MsgPopup("Buildings aligned to grid.","Grid")
  end
end

function ChoGGi.MenuFuncs.RemoveUnreachableConstructionSites()
  local Table
  local function RemoveUnreachable(Class)
    Table = GetObjects({class=Class}) or empty_table
    for i = 1, #Table do
      for Bld,_ in pairs(Table[i].unreachable_buildings or empty_table) do
        if Bld:IsKindOf("ConstructionSite") then
          Bld:Cancel()
        end
      end
      Table[i].unreachable_buildings = empty_table
    end
  end

  Table = GetObjects({class="Drone"}) or empty_table
  for i = 1, #Table do
    Table[i]:CleanUnreachables()
  end
  RemoveUnreachable("DroneHub")
  RemoveUnreachable("RCRover")
  RemoveUnreachable("SupplyRocket")
  ChoGGi.ComFuncs.MsgPopup("Removed unreachable","Sites")
end

function ChoGGi.MenuFuncs.RemoveYellowGridMarks()
  local Table = GetObjects({class="GridTile"})
  if Table[1] and Table[1].class and Table[1].class == "GridTile" then
    for i = 1, #Table do
      Table[i]:delete()
    end
  end
  ChoGGi.ComFuncs.MsgPopup("Grid marks removed","Grid")
end

function ChoGGi.MenuFuncs.ProjectMorpheusRadarFellDown()
  local tab = UICity.labels.ProjectMorpheus or empty_table
  for i = 1, #tab do
    tab[i]:ChangeWorkingStateAnim(false)
    tab[i]:ChangeWorkingStateAnim(true)
  end
end

function ChoGGi.MenuFuncs.RebuildWalkablePointsInDomes()
	ForEach({
		class = "Dome",
		exec = function(d)
      d.walkable_points = false
      d:GenerateWalkablePoints()
		end
	})
end

function ChoGGi.MenuFuncs.AttachBuildingsToNearestWorkingDome()
  local ChoGGi = ChoGGi
  local Table = UICity.labels.InsideBuildings or empty_table
  for i = 1, #Table do
    ChoGGi.CodeFuncs.AttachToNearestDome(Table[i])
  end

  ChoGGi.ComFuncs.MsgPopup("Buildings attached.",
    "Buildings","UI/Icons/Sections/basic.tga"
  )
end

function ChoGGi.MenuFuncs.ColonistsFixBlackCube()
  local tab = UICity.labels.Colonist or empty_table
  for i = 1, #tab do
    local colonist = tab[i]
    if colonist.entity:find("Child",1,true) then
      colonist.specialist = "none"

      colonist.traits.Youth = nil
      colonist.traits.Adult = nil
      colonist.traits["Middle Aged"] = nil
      colonist.traits.Senior = nil
      colonist.traits.Retiree = nil

      colonist.traits.Child = true
      colonist.age_trait = "Child"
      colonist.age = 0
      colonist:ChooseEntity()
      colonist:SetResidence(false)
      colonist:UpdateResidence()
    end
  end
  ChoGGi.ComFuncs.MsgPopup("Fixed black cubes",
    "Colonists",UsualIcon2
  )
end

function ChoGGi.MenuFuncs.RepairBrokenShit(BrokenShit)
  local JustInCase = 0
  while #BrokenShit > 0 do

    for i = 1, #BrokenShit do
      pcall(function()
        BrokenShit[i]:Repair()
      end)
    end

    if JustInCase == 10000 then
      break
    end
    JustInCase = JustInCase + 1

  end
end

function ChoGGi.MenuFuncs.CablesAndPipesRepair()
  local ChoGGi = ChoGGi
  local g_BrokenSupplyGridElements = g_BrokenSupplyGridElements
  ChoGGi.MenuFuncs.RepairBrokenShit(g_BrokenSupplyGridElements.electricity)
  ChoGGi.MenuFuncs.RepairBrokenShit(g_BrokenSupplyGridElements.water)
end

------------------------- toggles
--[[
fixed in curiosity

function ChoGGi.MenuFuncs.NoRestingBonusPsychologistFix_Toggle()
  local ChoGGi = ChoGGi
  ChoGGi.UserSettings.NoRestingBonusPsychologistFix = not ChoGGi.UserSettings.NoRestingBonusPsychologistFix

  local commander_profile = GetCommanderProfile()
  if ChoGGi.UserSettings.NoRestingBonusPsychologistFix then
    if commander_profile.id == "psychologist" then
      commander_profile.param1 = 5
    end
  else --don't know why you'd want to disable the bonus
    if commander_profile.id == "psychologist" then
      commander_profile.param1 = 0
    end
  end

  ChoGGi.SettingFuncs.WriteSettings()
  ChoGGi.ComFuncs.MsgPopup("No resting bonus psychologist: " .. tostring(UserSettings.NoRestingBonusPsychologistFix),
    "Psychologist"
  )
end
--]]

function ChoGGi.MenuFuncs.RoverInfiniteLoopCuriosity_Toggle()
  local ChoGGi = ChoGGi
  ChoGGi.UserSettings.RoverInfiniteLoopCuriosity = not ChoGGi.UserSettings.RoverInfiniteLoopCuriosity
  ChoGGi.SettingFuncs.WriteSettings()
  ChoGGi.ComFuncs.MsgPopup("Rover Infinite Loop: " .. tostring(ChoGGi.UserSettings.RoverInfiniteLoopCuriosity),
    "Rovers"
  )
end

function ChoGGi.MenuFuncs.DroneResourceCarryAmountFix_Toggle()
  local ChoGGi = ChoGGi
  ChoGGi.UserSettings.DroneResourceCarryAmountFix = not ChoGGi.UserSettings.DroneResourceCarryAmountFix
  ChoGGi.SettingFuncs.WriteSettings()
  ChoGGi.ComFuncs.MsgPopup("Drone Carry Fix: " .. tostring(ChoGGi.UserSettings.DroneResourceCarryAmountFix),
    "Drones","UI/Icons/IPButtons/drone.tga"
  )
end

function ChoGGi.MenuFuncs.SortCommandCenterDist_Toggle()
  local ChoGGi = ChoGGi
  ChoGGi.UserSettings.SortCommandCenterDist = not ChoGGi.UserSettings.SortCommandCenterDist
  ChoGGi.SettingFuncs.WriteSettings()
  ChoGGi.ComFuncs.MsgPopup("Sorting cc dist: " .. tostring(ChoGGi.UserSettings.SortCommandCenterDist),
    "Buildings"
  )
end
