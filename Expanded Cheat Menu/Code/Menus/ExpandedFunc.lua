-- See LICENSE for terms

local type,tostring = type,tostring

function OnMsg.ClassesGenerate()
	local TableConcat = ChoGGi.ComFuncs.TableConcat
	local RetName = ChoGGi.ComFuncs.RetName
	local S = ChoGGi.Strings
	local Trans = ChoGGi.ComFuncs.Translate

	do -- BuildGridList
		local IsValid = IsValid
		local function BuildGrid(grid,list)
			local g_str = Trans(11629--[[GRID <i>--]])
			for i = 1, #grid do
				for j = 1, #grid[i].elements do
					local bld = grid[i].elements[j].building
					local name,display_name = RetName(bld),Trans(bld.display_name)

					if name == display_name then
						list[g_str:gsub("<i>",i) .. " - " .. name .. " h: " .. bld.handle] = bld
					else
						list[g_str:gsub("<i>",i) .. " - " .. display_name .. " " .. name .. " h: " .. bld.handle] = bld
					end
				end
			end
		end
		local function FilterExamineList(ex_dlg,class)
			-- loop through and remove any matching objects, as well as the hyperlink table
			local obj_ref = ex_dlg.obj_ref
			for key,value in pairs(obj_ref) do
				if value.ChoGGi_AddHyperLink then
					obj_ref[key] = nil
				elseif IsValid(value) and value.class == class then
					obj_ref[key] = nil
				end
			end
			ex_dlg:RefreshExamine()
		end

		function ChoGGi.MenuFuncs.BuildGridList()
			local UICity = UICity
			local grid_list = {
				air = objlist:new(),
				water = objlist:new(),
				electricity = objlist:new(),
			}
			grid_list.air.name = Trans(891--[[Air--]])
			grid_list.electricity.name = Trans(79--[[Power--]])
			grid_list.electricity.__HideCables = {
				ChoGGi_AddHyperLink = true,
				name = S[302535920000142--[[Hide--]]] .. " " .. Trans(881--[[Power Cables--]]),
				func = function(ex_dlg)
					FilterExamineList(ex_dlg,"ElectricityGridElement")
				end,
			}
			grid_list.water.name = Trans(681--[[Water--]])
			grid_list.water.__HidePipes = {
				ChoGGi_AddHyperLink = true,
				name = S[302535920000142--[[Hide--]]] .. " " .. Trans(882--[[Pipes--]]),
				func = function(ex_dlg)
					FilterExamineList(ex_dlg,"LifeSupportGridElement")
				end,
			}

			BuildGrid(UICity.air,grid_list.air)
			BuildGrid(UICity.electricity,grid_list.electricity)
			BuildGrid(UICity.water,grid_list.water)
			ChoGGi.ComFuncs.OpenInExamineDlg(grid_list,nil,S[302535920001307--[[Grid Info--]]])
		end
	end -- do

	do -- ViewObjInfo_Toggle
		local PlaceObject = PlaceObject
		local GetStateName = GetStateName
		local IsValid = IsValid
		local TableFind = table.find
		local r = ChoGGi.Consts.ResearchPointsScale
		local RetAllOfClass = ChoGGi.ComFuncs.RetAllOfClass
		local update_info_thread = {}
		local viewing_obj_info = {}

		local function Dome_GetWorkingSpace(obj)
			local max_workers = 0
			local objs = obj.labels.Workplaces or ""
			for i = 1, #objs do
				if not objs[i].destroyed then
					max_workers = max_workers + objs[i].max_workers
				end
			end
			return max_workers
		end

		local function GetService(dome,label)
			local use,max,handles = 0,0,{}
			local services = dome.labels[label] or ""
			for i = 1, #services do
				use = use + #services[i].visitors
				max = max + services[i].max_visitors
				handles[services[i].handle] = true
			end
			return use,max,handles
		end

		local GetInfo = {
	--~ 		Colonist = function(obj)
	--~ 		end,
	--~ 		Power = function(obj)
	--~ 		end,
	--~ 		["Life-Support"] = function(obj)
	--~ 		end,
--~ 			OutsideBuildings = function(obj)
--~ 				print("OutsideBuildings")
--~ 				return "- " .. RetName(obj) .. " -\n" .. S[302535920000035--[[Grids--]]]
--~ 					.. ": " .. Trans(682--[[Oxygen--]])
--~ 					.. "(" .. (TableFind(UICity.air,obj.air.grid) or Trans(6774--[[Error--]])) .. ") "
--~ 					.. Trans(681--[[Water--]]) .. "("
--~ 					.. tostring(obj.water and obj.water.grid.ChoGGi_GridHandle) .. ") "
--~ 					.. Trans(79--[[Power--]]) .. "("
--~ 					.. tostring(obj.electricity and obj.electricity.grid.ChoGGi_GridHandle) .. ")"
--~ 			end,
			Deposit = function(obj)
				if not obj:IsKindOfClasses("SubsurfaceDeposit","TerrainDeposit") then
					return ""
				end
				return "- " .. RetName(obj) .. " -\n" .. Trans(6--[[Depth Layer--]])
					.. ": " .. obj.depth_layer .. ", " .. Trans(7--[[Is Revealed--]])
					.. ": " .. tostring(obj.revealed) .. "\n" .. Trans(16--[[Grade--]]) .. ": "
					.. obj.grade .. ", " .. Trans(1000100--[[Amount--]]) .. ": "
					.. ((obj.amount or obj.max_amount) / r) .. "/" .. (obj.max_amount / r)
			end,
			DroneControl = function(obj)
				return "- " .. RetName(obj) .. " -\n" .. Trans(517--[[Drones--]])
					.. ": " .. #(obj.drones or "") .. "/" .. obj:GetMaxDronesCount()
					.. "\n"
					.. Trans(295--[[Idle <right>--]]):gsub("<right>",": " .. obj:GetIdleDronesCount())
					.. ", " .. S[302535920000081--[[Workers--]]] .. ": " .. obj:GetMiningDronesCount()
					.. ", " .. Trans(293--[[Broken <right>--]]):gsub("<right>",": " .. obj:GetBrokenDronesCount())
					.. ", " .. Trans(294--[[Discharged <right>--]]):gsub("<right>",": " .. obj:GetDischargedDronesCount())
			end,
			Drone = function(obj)
				local amount = obj.amount and obj.amount / r or 0
				local res = obj.resource
				return "- " .. RetName(obj) .. " -\n"
					.. Trans(584248706535--[[Carrying<right><ResourceAmount>--]]):gsub("<right><ResourceAmount>",": " .. amount) .. (res and " (" .. res .. "), " or ", ")
					.. Trans(3722--[[State--]]) .. ": " .. GetStateName(obj:GetState()) .. ", "
					.. "\n" .. Trans(4448--[[Dust--]]) .. ": " .. (obj.dust / r) .. "/" .. (obj.dust_max / r)
					.. ", " .. S[302535920001532--[[Battery--]]] .. ": " .. (obj.battery / r) .. "/" .. (obj.battery_max / r)
			end,
			Production = function(obj)
				local prod = type(obj.GetProducerObj) == "function" and obj:GetProducerObj()
				if not prod then
					return ""
				end

				local predprod
				local prefix
				local waste = obj.wasterock_producer or ""
				if waste ~= "" then
					predprod = tostring(waste:GetPredictedProduction())
					prefix = "0."
					if #predprod > 3 or predprod == "0" then
						prefix = ""
						predprod = prod:GetPredictedProduction() / r
					end
					waste = "- " .. Trans(4518--[[Waste Rock--]]) .. " -\n"
					.. Trans(80--[[Production--]]) .. ": " .. prefix .. " " .. predprod .. ", "
					.. Trans(6729--[[Daily Production <n>--]]):gsub("<n>",": " .. (waste:GetPredictedDailyProduction() / r))
					.. ", "
					.. Trans(434--[[Lifetime<right><lifetime>--]]):gsub("<right><lifetime>",": " .. (waste.lifetime_production / r))
					.. "\n" .. Trans(519--[[Storage--]]) .. ": "
					.. (waste:GetAmountStored() / r) .. "/" .. (waste.max_storage / r)
				end
				predprod = tostring(prod:GetPredictedProduction())
				prefix = "0."
				if #predprod > 3 or predprod == "0" then
					prefix = ""
					predprod = prod:GetPredictedProduction() / r
				end

				return TableConcat({"- " .. RetName(obj) .. " -\n" .. Trans(80--[[Production--]])
					.. ": " .. prefix .. predprod .. ", "
					.. Trans(6729--[[Daily Production <n>--]]):gsub("<n>",": " .. (prod:GetPredictedDailyProduction() / r))
					.. ", "
					.. Trans(434--[[Lifetime<right><lifetime>--]]):gsub("<right><lifetime>",": " .. (prod.lifetime_production / r))
					.. "\n" .. Trans(519--[[Storage--]]) .. ": "
					.. (prod:GetAmountStored() / r) .. "/" .. (prod.max_storage / r)
					,waste},"\n")
			end,
			Dome = function(obj)
				if not obj.air then
					return ""
				end
				local medic_use,medic_max,medic_handles = GetService(obj,"needMedical")
				local food_use,food_max,food_handles = GetService(obj,"needFood")
				local food_need,medic_need = 0,0
				local c = obj.labels.Colonist
				for i = 1, #c do
					if c[i].command == "VisitService" then
						local h = c[i].goto_target and c[i].goto_target.handle
						if medic_handles[h] then
							medic_need = medic_need + 1
						elseif food_handles[h] then
							food_need = food_need + 1
						end
					end
				end

				-- the .. below is (too long/too many ..) for ZeroBrane compile (used to find some stuff to clean up), so this is to shorten it
				local go_to = Trans(4439--[[Going to--]]):gsub("<right><h SelectTarget InfopanelSelect><Target></h>","%%s")
				local a,e,w = Trans(682--[[Oxygen--]]),Trans(79--[[Power--]]),Trans(681--[[Water--]])
				local city = obj.city or UICity

				local ga = obj.air
				local ge = obj.electricity
				local gw = obj.water
				local ga_id = TableFind(city.air,ga.grid) or Trans(6774--[[Error--]])
				local ge_id = TableFind(city.electricity,ge.grid) or Trans(6774--[[Error--]])
				local gw_id = TableFind(city.water,gw.grid) or Trans(6774--[[Error--]])
				local l = obj.labels

				return "- " .. RetName(obj) .. " -\n"
					.. Trans(547--[[Colonists--]]) .. ": " .. #(l.Colonist or "")
					.. "\n" .. Trans(6859--[[Unemployed--]]) .. ": " .. #(l.Unemployed or "") .. "/" .. Dome_GetWorkingSpace(obj)
					.. ", " .. Trans(7553--[[Homeless--]]) .. ": " .. #(l.Homeless or "") .. "/" .. obj:GetLivingSpace()
					.. "\n" .. Trans(7031--[[Renegades--]]) .. ": " .. #(l.Renegade or "")
					.. ", " .. Trans(5647--[[Dead Colonists: <count>--]]):gsub("<count>",#(l.DeadColonist or ""))
					.. "\n" .. Trans(6647--[[Guru--]]) .. ": " .. #(l.Guru or "")
					.. ", " .. Trans(6640--[[Genius--]]) .. ": " .. #(l.Genius or "")
					.. ", " .. Trans(6642--[[Celebrity--]]) .. ": " .. #(l.Celebrity or "")
					.. ", " .. Trans(6644--[[Saint--]]) .. ": " .. #(l.Saint or "")
					.. "\n\n" .. e .. ": " .. (ge.current_consumption / r) .. "/" .. (ge.consumption / r)
					.. ", " .. a .. ": " .. (ga.current_consumption / r) .. "/" .. (ga.consumption / r)
					.. ", " .. w .. ": " .. (gw.current_consumption / r) .. "/" .. (gw.consumption / r)
					.. "\n" .. Trans(1022--[[Food--]]) .. " (" .. #(l.needFood or "") .. "): "
					.. go_to:format(": " .. food_need)
					.. ", " .. Trans(526--[[Visitors--]]) .. ": " .. food_use .. "/" .. food_max
					.. "\n" .. Trans(3862--[[Medic--]]) .. " (" .. #(l.needMedical or "") .. "): "
					.. go_to:format(": " .. medic_need)
					.. ", " .. Trans(526--[[Visitors--]]) .. ": " .. medic_use .. "/" .. medic_max
					.. "\n\n" .. S[302535920000035--[[Grids--]]] .. ": "
					.. a .. "(" .. ga_id .. ") "
					.. w .. "(" .. gw_id .. ") "
					.. e .. "(" .. ge_id .. ")"
			end,
		}

		local ptz8000 = point(0,0,8000)
		local ptz2000 = point(0,0,2000)
		local function AddViewObjInfo(label)
			local objs = RetAllOfClass(label)
			for i = 1, #objs do
				local obj = objs[i]
				-- only check for valid pos if it isn't a colonist (inside building = invalid pos)
				local pos = true
				if label ~= "Colonist" then
					pos = obj ~= InvalidPos
				end
				-- skip any missing objects
				if IsValid(obj) and pos then
					local text_obj = PlaceObject("ChoGGi_OText")
--~ 					local orient_obj = PlaceObject("ChoGGi_OOrientation")
--~ 					orient_obj.ChoGGi_ViewObjInfo_o = true
					text_obj:SetText(GetInfo[label](obj))
					text_obj:SetCenter(true)
					obj.ChoGGi_ViewObjInfo_text = text_obj

					obj:Attach(text_obj)
--~ 					obj:Attach(orient_obj)
					if label == "Dome" then
						text_obj:SetAttachOffset(ptz8000)
					elseif label ~= "Drone" then
						text_obj:SetAttachOffset(ptz2000)
					end
				end
			end
		end

		local function RemoveViewObjInfo(cls)
			-- clear out the text objects
			local objs = RetAllOfClass(cls)
			for i = 1, #objs do
				local obj = objs[i]
				if IsValid(obj.ChoGGi_ViewObjInfo_text) then
					obj.ChoGGi_ViewObjInfo_text:delete()
					obj.ChoGGi_ViewObjInfo_text = nil
				end
			end
		end

		local function UpdateViewObjInfo(cls)
			-- fire an update every second
			update_info_thread[cls] = CreateGameTimeThread(function()
				local cameraRTS_GetPos = cameraRTS.GetPos
				local InvalidPos = ChoGGi.Consts.InvalidPos

				local objs = RetAllOfClass(cls)
				local thread = update_info_thread[cls]
				while thread do
					local cam_pos = cameraRTS_GetPos()

					-- update text loop
					for i = 1, #objs do
						local obj = objs[i]
						if IsValid(obj) and IsValid(obj.ChoGGi_ViewObjInfo_text) then
							local obj_pos = obj:GetVisualPos()
							local too_far_from_cam = obj_pos ~= InvalidPos and obj_pos:Dist2D(cam_pos) > 100000

							-- too far means hide the text and don't bother updating it
							if too_far_from_cam then
								obj.ChoGGi_ViewObjInfo_text:SetOpacityInterpolation(0)
							else
								obj.ChoGGi_ViewObjInfo_text:SetOpacityInterpolation(100)
								obj.ChoGGi_ViewObjInfo_text:SetText(GetInfo[cls](obj))
							end
						end

					end -- for
					Sleep(1000)
				end
			end)
		end

		function ChoGGi.MenuFuncs.BuildingInfo_Toggle()
			local ItemList = {
				{text = Trans(83--[[Domes--]]),value = "Dome"},
				{text = Trans(3982--[[Deposits--]]),value = "Deposit"},
				{text = Trans(80--[[Production--]]),value = "Production"},
				{text = Trans(517--[[Drones--]]),value = "Drone"},
				{text = Trans(5433--[[Drone Control--]]),value = "DroneControl"},
--~ 				{text = Trans(4290--[[Colonist--]]),value = "Colonist"},
--~ 				{text = Trans(885971788025--[[Outside Buildings--]]),value = "OutsideBuildings"},

	--~ 			 {text = Trans(79--[[Power--]]),value = "Power"},
	--~			 {text = Trans(81--[[Life Support--]]),value = "Life-Support"},
			}

			local function CallBackFunc(choice)
				if choice.nothing_selected then
					return
				end
				local value = choice[1].value

				-- cleanup
				if viewing_obj_info[value] then
					viewing_obj_info[value] = nil
					RemoveViewObjInfo(value)
					DeleteThread(update_info_thread[value])
					update_info_thread[value] = nil
				else
					-- add signs
					viewing_obj_info[value] = true
					AddViewObjInfo(value)
				end

				-- auto-refresh
				if viewing_obj_info[value] then
					UpdateViewObjInfo(value)
				end
			end

			ChoGGi.ComFuncs.OpenInListChoice{
				callback = CallBackFunc,
				items = ItemList,
				title = S[302535920000333--[[Building Info--]]],
				hint = S[302535920001280--[[Double-click to toggle text (updates every second).--]]],
				custom_type = 7,
			}
		end

	end -- do

	function ChoGGi.MenuFuncs.MonitorInfo()
		local ChoGGi = ChoGGi
		local ItemList = {
			{text = S[302535920000936--[[Something you'd like to see added?--]]],value = "New"},
			{text = "",value = "New"},
			{text = S[302535920000035--[[Grids--]]] .. ": " .. Trans(891--[[Air--]]),value = "Air"},
			{text = S[302535920000035--[[Grids--]]] .. ": " .. Trans(79--[[Power--]]),value = "Power"},
			{text = S[302535920000035--[[Grids--]]] .. ": " .. Trans(681--[[Water--]]),value = "Water"},
			{text = S[302535920000035--[[Grids--]]] .. ": " .. Trans(891--[[Air--]]) .. "/" .. Trans(79--[[Power--]]) .. "/" .. Trans(681--[[Water--]]),value = "Grids"},
			{text = S[302535920000042--[[City--]]],value = "City"},
			{text = Trans(547--[[Colonists--]]),value = "Colonists",hint = S[302535920000937--[[Laggy with lots of colonists.--]]]},
			{text = Trans(5238--[[Rockets--]]),value = "Rockets"},
		}
		if ChoGGi.testing then
			ItemList[#ItemList+1] = {text = Trans(311--[[Research--]]),value = "Research"}
		end

		local function CallBackFunc(choice)
			if choice.nothing_selected then
				return
			end
			local value = choice[1].value
			if value == "New" then
				ChoGGi.ComFuncs.MsgWait(
					S[302535920000033--[[Post a request on Nexus or Github or send an email to: %s--]]]:format(ChoGGi.email),
					S[302535920000034--[[Request--]]]
				)
			else
				ChoGGi.ComFuncs.DisplayMonitorList(value)
			end
		end

		ChoGGi.ComFuncs.OpenInListChoice{
			callback = CallBackFunc,
			items = ItemList,
			title = S[302535920000555--[[Monitor Info--]]],
			hint = S[302535920000940--[[Select something to monitor.--]]],
			custom_type = 7,
			custom_func = function(sel)
				ChoGGi.ComFuncs.DisplayMonitorList(sel[1].value,sel[1].parentobj)
			end,
			skip_sort = true,
		}
	end

end
