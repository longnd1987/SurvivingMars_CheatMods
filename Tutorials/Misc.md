### Random info about random stuff.

```lua
--~ Be careful when using CreateGameTimeThread(), as they are persistent.
--~ If you have one with an inf loop the next time you load a game it'll still be there.
--~ Store a ref and check with IsValidThread(thread) and DeleteThread(thread)

--~ To get your mod path (if user renames your mod folder):
CurrentModPath
--~ Your (if any) mod options
CurrentModOptions
--~ To Access another mods stuff use
Mods.MOD_ID.env.CurrentModPath

--~ If working with a large amount of entity objects:
SuspendPassEdits("SomeIdToUse")
MapDelete("map", "Building")
ResumePassEdits("SomeIdToUse")
--~ Add ,true to suspend if you're changing the terrain?

--~ List all objects:
~MapGet(true)
--~ Just domes:
~MapGet(true,"Dome")
--~ Just get objects on the map (colonists in a building are off the map):
MapGet("map","ResourceStockpile","ResourceStockpileLR")
--~ Skip attachments
MapGet("map","attached", false)
--~ Filter out which objects are returned:
MapGet("map", "Building", function(o)
	return o.ui_working
end)

--~ Add cargo to the initial rocket:
--~ https://steamcommunity.com/workshop/discussions/18446744073709551615/1694923613869322889/?appid=464920

--~ Hash a value:
Encode16(SHA256(value))

--~ Access varargs (...):
--~ Use select(3,...) 3 being the argument you want to select, or run it through a for loop with
for i = 1, select("#",...) do
	local arg = select(i,...)
end
--~ Or use: local varargs = {...}
--~ and you can access them like a regular table

--~ Countdown timer (use CreateGameTimeThread to have it follow the speed of the game):
local countdown = CreateRealTimeThread(function()
	Sleep(10000)
	-- do something after 10 seconds
end)
if you_want_stop_it_from_outside then
	DeleteThread(countdown)
end
if you want to use a realtime and pause it:
local we_paused
function OnMsg.MarsPause()
	we_paused = true
end
CreateRealTimeThread(function()
	while true do
		if we_paused then
			WaitMsg("MarsResume")
			we_paused = false
		end
		-- other stuff
		Sleep(1000)
	end
end

--~ Loop backwards through a table (good for deleting as you go):
for i = #some_table, 1, -1 do
	print(some_table[i])
	table.remove(some_table,i)
end

--~ Use particles on any object:
--~ Change the obj.fx_actor_class to match the "Actor" name then PlayFX will work.
--~ Don't forget to backup the original, so you can restore it after.

--~ Only do stuff once the game is loaded
--~ This will return in the new game menu and the main menu
if not GameState.gameplay then
	return
end

--~ Don't pass vars on the end of varargs
-- works
SomeFunc(var1,var2,...)
-- doesn't work (it'll only take the first var arg)
SomeFunc(var1,...,var2)

--~ for all funcs of a class obj: print the func name when it fires
function OnMsg.ClassesBuilt()
	-- the obj in question
	local obj_to_print = ChoGGi_OHexSpot
	-- local some globals
	local print = print
	local type,pairs,getmetatable = type,pairs,getmetatable
	-- the "magic"
	local function ReplaceFuncs(list)
		for key,value in pairs(list) do
			-- replacing _ funcs means bad things
			if key:sub(1,1) ~= "_" and type(value) == "function" then
				obj_to_print[key] = function(...)
					-- add the ... to also print args
					print(key)
					return value(...)
				end
			end
		end
	end

	-- loop through all the metatables and call our replace func
	local mt = getmetatable(obj_to_print)
	while mt do
		ReplaceFuncs(mt)
		if type(mt.__index) == "table" then
			ReplaceFuncs(mt.__index)
		end
		-- next one up the ladder
		mt = getmetatable(mt)
	end
end

--~ Info from other people:

--~ Crysm: 7200 units per revolution. So units = (degrees * 20)
--~ 21600 / 360

--~ BullettMAGNETTs CustomAssetDocs
--~ https://docs.google.com/document/d/1LcZMS8UeRAQZZsPE-bsx75ZMGPUFGdbS-M9jDBMFEYs

--~ StGaby: Return the played time
function TimeToDayHourMinSec(time)
	time = time or GameTime()
	local seconds = time * 60 / const.MinuteDuration % 60
	local minutes = time / const.MinuteDuration % const.MinutesPerHour
	local hours = City.hour + time / const.HourDuration
	local days = City.day + hours / const.HoursPerDay
	return days, hours % const.HoursPerDay, minutes, seconds
end
```