return PlaceObj("ModDef", {
	"dependencies", {
		PlaceObj("ModDependency", {
			"id", "ChoGGi_Library",
			"title", "ChoGGi's Library",
			"version_major", 6,
			"version_minor", 6,
		}),
	},
	"title", "Construction: Show Dome Passage Line",
	"version", 9,
	"version_major", 0,
	"version_minor", 9,
	"saved", 1544702400,
	"id", "ChoGGi_ConstructionShowDomePassageLine",
	"author", "ChoGGi",
	"image", "Preview.png",
	"steam_id", "1428027914",
	"pops_any_uuid", "33973dda-42d6-49a0-ba55-3ec431602574",
	"lua_revision", 244677,
	"code", {
		"Code/Script.lua",
	},
	"has_options", true,
	"description", [[Shows lines between domes when they're close enough for passages to connect.

I use straight lines, instead of the angled passages, so it isn't perfect.
There is a chance that you'll be able to connect a dome that's another 1-3 hexes further away (dependant on the angle).
I chose to use a safe distance that'll always be close enough to connect.

Toggle in-game with mod options.

This doesn't take into account entrances, corners, or buildings.]],
})
