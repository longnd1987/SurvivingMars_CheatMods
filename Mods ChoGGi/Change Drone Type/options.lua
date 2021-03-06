DefineClass("ModOptions_ChoGGi_ChangeDroneType", {
	__parents = {
		"ModOptionsObject",
	},
	properties = {
		{
			default = false,
			editor = "bool",
			id = "Aerodynamics",
			name = [[Martian Aerodynamics]],
			desc = [[Only show button when Martian Aerodynamics has been researched.]],
		},
		{
			default = false,
			editor = "bool",
			id = "AlwaysWasp",
			name = [[Always Wasp Drones]],
			desc = [[Override drone type to always wasps.]],
		},
	},
})