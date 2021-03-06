-- See LICENSE for terms

local AsyncRand = AsyncRand
local CreateRealTimeThread = CreateRealTimeThread
local AddCustomOnScreenNotification = AddCustomOnScreenNotification
local ChangeFunding = ChangeFunding

function OnMsg.NewDay()
	local amount = (UICity.funding / 1000000) * 0.01 -- 0.01 = 1%
	ChangeFunding(amount)

	local msg = "You've received: " .. amount .. " M"
	local id = AsyncRand()
	-- returns translated text corresponding to number if we don't do tostring for numbers
	CreateRealTimeThread(function()
		AddCustomOnScreenNotification(
			id, [[1 Percenter]], msg, "UI/Icons/Notifications/placeholder.tga", nil, {expiration=8000}
		)
		-- since I use AsyncRand for the id, I don't want this getting too large.
		g_ShownOnScreenNotifications[id] = nil
	end)
end
