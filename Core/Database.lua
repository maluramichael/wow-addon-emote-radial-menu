local AddonName, Addon = ...

local Database = {}
Addon.Database = Database

Database.defaults = {
	profile = {
		menu = {
			alpha = 0.95,
			layout = "radial",
			buttonRadius = 120,
			columns = 4,
			rows = 3,
			gap = 5,
			closeOnUse = true,
		},
		emotes = {
			"dance", "cheer", "wave", "bow", "thank", "applaud",
			"laugh", "cry", "shrug", "point", "salute", "roar"
		},
		enabledEmotes = {
			[1] = true, [2] = true, [3] = true, [4] = true,
			[5] = true, [6] = true, [7] = true, [8] = true,
			[9] = true, [10] = true, [11] = true, [12] = true,
		},
	}
}
