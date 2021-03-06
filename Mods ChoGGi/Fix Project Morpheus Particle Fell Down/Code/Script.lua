-- See LICENSE for terms

local IsValid = IsValid
local WaitMsg = WaitMsg

local function CheckMorph()
	local morphs = UICity.labels.ProjectMorpheus or ""
	for i = 1, #morphs do
		local obj = morphs[i]
		-- if it's turned off then pretty sure it won't fall off
		if obj.ui_working and IsValid(obj) then
			obj:ForEachAttach("ParSystem", function(a)
				-- if there's not spot name then it's fallen down
				if a:GetParticlesName() == "ProjectMorpheus_Projector" and a:GetAttachSpotName() == "" then
					CreateGameTimeThread(function()
						local working = obj.ui_working
						obj:SetUIWorking(not working)
						-- wait for it...
						while obj:GetStateText() ~= "end" do
							WaitMsg("OnRender")
						end
						obj:SetUIWorking(working)
					end)
				end
			end)
		end
	end
end

OnMsg.NewDay = CheckMorph
OnMsg.LoadGame = CheckMorph
