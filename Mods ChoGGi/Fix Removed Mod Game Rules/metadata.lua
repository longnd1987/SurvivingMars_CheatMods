return PlaceObj("ModDef", {
	"title", "Fix: Removed Mod Game Rules",
	"version_major", 0,
	"version_minor", 1,
	"saved", 1545134400,
	"image", "Preview.png",
	"id", "ChoGGi_FixRemovedModGameRules",
	"steam_id", "1594337615",
	"author", "ChoGGi",
	"lua_revision", LuaRevision or 244124,
	"code", {
		"Code/Script.lua",
	},
	"description", [[If you removed modded rules then the Mission Profile dialog will be blank.
You don't need to leave this enabled afterwards.

Thanks to LukeH for finding it.]],
})
