return PlaceObj("ModDef", {
	"dependencies", {
		PlaceObj("ModDependency", {
			"id", "ChoGGi_Library",
			"title", "ChoGGi's Library",
			"version_major", 6,
			"version_minor", 6,
		}),
	},
--~	 "title", "RC Miner v1.8",
	"title", "RC Miner",
	"version", 18,
	"version_major", 1,
	"version_minor", 8,
	"saved", 1542974400,
	"image", "Preview.png",
	"tags", "Buildings",
	"id", "ChoGGi_PortableMiner",
	"author", "ChoGGi",
	"steam_id", "1411113412",
	"pops_any_uuid", "831c4ed8-d892-4815-bb77-3a028c3ea5b0",
	"lua_revision", 244677,
	"code", {
		"Code/Script.lua",
	},
	"has_options", true,
	"description", [[It's a rover that mines, tell it where to go and if there's a resource (Metals/Concrete) close by it'll start mining it.
Supports the Auto-mode added in Sagan (boosts the amount stored per stockpile when enabled).
Use mod options to tweak the settings.

Uses the Attack Rover model (check script.lua to change it to something else).



Affectionately known as the pooper shooter.]],
})
