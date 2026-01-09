local AddonName, Addon = ...

local Database = {}
Addon.Database = Database

Database.defaults = {
	profile = {
		menu = {
			scale = 1.0,
			alpha = 0.95,
			buttonRadius = 120,
			buttonSize = 50,
			backgroundColor = {0.1, 0.1, 0.12},
			buttonColor = {0.15, 0.15, 0.18},
			buttonHoverColor = {0.25, 0.35, 0.5},
			borderColor = {0.4, 0.4, 0.45},
			holdToShow = false,
			closeOnUse = true,
		},
		keybinding = {
			enabled = false,
			key = "",
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
