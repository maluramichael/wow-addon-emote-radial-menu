local AddonName, Addon = ...

local Database = {}
Addon.Database = Database

Database.defaults = {
	profile = {
		menu = {
			scale = 1.0,
			alpha = 0.9,
			buttonRadius = 100,
			buttonSize = 40,
			backgroundColor = {0.1, 0.1, 0.1},
			buttonColor = {0.3, 0.3, 0.3},
			buttonHoverColor = {0.5, 0.5, 0.5},
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
