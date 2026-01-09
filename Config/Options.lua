local AddonName, Addon = ...

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local L = Addon.L or {}

local function CreateOptionsTable(addon)
	local options = {
		name = "EmoteRadialMenu",
		type = "group",
		args = {
			behavior = {
				name = L["Behavior"],
				type = "group",
				order = 1,
				args = {
					closeOnUse = {
						name = L["Close on Use"],
						desc = L["Automatically close menu after selecting an emote"],
						type = "toggle",
						order = 1,
						get = function()
							return addon.db.profile.menu.closeOnUse
						end,
						set = function(_, val)
							addon.db.profile.menu.closeOnUse = val
						end,
					},
				},
			},
			general = {
				name = L["Menu Appearance"],
				type = "group",
				order = 2,
				args = {
					positionHeader = {
						name = L["Spawn Position"],
						type = "header",
						order = 1,
					},
					useAnchor = {
						name = L["Use Fixed Position"],
						desc = L["Menu spawns at anchor instead of mouse cursor"],
						type = "toggle",
						order = 2,
						get = function()
							return addon.db.profile.menu.useAnchor
						end,
						set = function(_, val)
							addon:ToggleAnchor(val)
						end,
					},
					anchorPoint = {
						name = L["Anchor Point"],
						desc = L["Screen position for fixed spawn"],
						type = "select",
						values = {
							CENTER = "CENTER",
							TOP = "TOP",
							BOTTOM = "BOTTOM",
							LEFT = "LEFT",
							RIGHT = "RIGHT",
							TOPLEFT = "TOPLEFT",
							TOPRIGHT = "TOPRIGHT",
							BOTTOMLEFT = "BOTTOMLEFT",
							BOTTOMRIGHT = "BOTTOMRIGHT",
						},
						order = 3,
						get = function()
							return addon.db.profile.menu.anchorPoint
						end,
						set = function(_, val)
							addon.db.profile.menu.anchorPoint = val
							addon:UpdateAnchorFrame()
						end,
					},
					anchorOffsetX = {
						name = L["Anchor Offset X"],
						desc = L["Horizontal offset from anchor point"],
						type = "range",
						min = -500,
						max = 500,
						step = 5,
						order = 4,
						get = function()
							return addon.db.profile.menu.anchorOffsetX
						end,
						set = function(_, val)
							addon.db.profile.menu.anchorOffsetX = val
							addon:UpdateAnchorFrame()
						end,
					},
					anchorOffsetY = {
						name = L["Anchor Offset Y"],
						desc = L["Vertical offset from anchor point"],
						type = "range",
						min = -500,
						max = 500,
						step = 5,
						order = 5,
						get = function()
							return addon.db.profile.menu.anchorOffsetY
						end,
						set = function(_, val)
							addon.db.profile.menu.anchorOffsetY = val
							addon:UpdateAnchorFrame()
						end,
					},
					appearanceHeader = {
						name = L["Menu Appearance"],
						type = "header",
						order = 10,
					},
					alpha = {
						name = L["Opacity"],
						desc = L["Transparency of the menu"],
						type = "range",
						min = 0.1,
						max = 1.0,
						step = 0.05,
						order = 11,
						get = function()
							return addon.db.profile.menu.alpha
						end,
						set = function(_, val)
							addon.db.profile.menu.alpha = val
							addon.RadialMenu:ShowAtAnchor()
						end,
					},
					layoutHeader = {
						name = L["Layout"],
						type = "header",
						order = 20,
					},
					layout = {
						name = L["Layout"],
						desc = L["Choose between radial or grid layout"],
						type = "select",
						values = {
							radial = L["Radial"],
							grid = L["Grid"],
						},
						order = 21,
						get = function()
							return addon.db.profile.menu.layout
						end,
						set = function(_, val)
							addon.db.profile.menu.layout = val
							addon.RadialMenu:ShowAtAnchor()
						end,
					},
					buttonRadius = {
						name = L["Button Radius"],
						desc = L["Distance from center to buttons"],
						type = "range",
						min = 50,
						max = 200,
						step = 5,
						order = 22,
						hidden = function()
							return addon.db.profile.menu.layout ~= "radial"
						end,
						get = function()
							return addon.db.profile.menu.buttonRadius
						end,
						set = function(_, val)
							addon.db.profile.menu.buttonRadius = val
							addon.RadialMenu:ShowAtAnchor()
						end,
					},
					columns = {
						name = L["Columns"],
						desc = L["Number of columns in grid layout"],
						type = "range",
						min = 1,
						max = 10,
						step = 1,
						order = 23,
						hidden = function()
							return addon.db.profile.menu.layout ~= "grid"
						end,
						get = function()
							return addon.db.profile.menu.columns
						end,
						set = function(_, val)
							addon.db.profile.menu.columns = val
							addon.RadialMenu:ShowAtAnchor()
						end,
					},
					rows = {
						name = L["Rows"],
						desc = L["Number of rows in grid layout"],
						type = "range",
						min = 1,
						max = 10,
						step = 1,
						order = 24,
						hidden = function()
							return addon.db.profile.menu.layout ~= "grid"
						end,
						get = function()
							return addon.db.profile.menu.rows
						end,
						set = function(_, val)
							addon.db.profile.menu.rows = val
							addon.RadialMenu:ShowAtAnchor()
						end,
					},
					gap = {
						name = L["Gap"],
						desc = L["Space between buttons in grid layout"],
						type = "range",
						min = 0,
						max = 20,
						step = 1,
						order = 25,
						hidden = function()
							return addon.db.profile.menu.layout ~= "grid"
						end,
						get = function()
							return addon.db.profile.menu.gap
						end,
						set = function(_, val)
							addon.db.profile.menu.gap = val
							addon.RadialMenu:ShowAtAnchor()
						end,
					},
				},
			},
			emotes = {
				name = L["Emote Selection"],
				type = "group",
				order = 3,
				args = {
					description = {
						name = L["Select which emotes appear in the radial menu."],
						type = "description",
						order = 0,
					},
				},
			},
		},
	}

	local emoteCategories = {
		positive = {
			name = L["Positive"],
			order = 1,
			emotes = {
				"agree", "applaud", "cheer", "clap", "comfort", "commend", "congratulate",
				"happy", "hug", "kiss", "love", "praise", "thank", "ty", "welcome"
			}
		},
		negative = {
			name = L["Negative"],
			order = 2,
			emotes = {
				"angry", "annoyed", "bored", "confused", "cry", "disappointed", "frown",
				"insult", "mad", "mourn", "no", "rude", "sad", "scared", "sigh", "tired"
			}
		},
		funny = {
			name = L["Funny"],
			order = 3,
			emotes = {
				"belch", "burp", "chicken", "cower", "dance", "fart", "flex", "flirt",
				"giggle", "laugh", "lol", "rofl", "silly", "surprised", "train", "wink"
			}
		},
		gestures = {
			name = L["Gestures"],
			order = 4,
			emotes = {
				"beckon", "bow", "bye", "greet", "hello", "kneel", "point", "raise",
				"salute", "shrug", "sit", "sleep", "stand", "wave", "yes"
			}
		},
		social = {
			name = L["Social"],
			order = 5,
			emotes = {
				"bounce", "calm", "curious", "followme", "laydown", "listen", "pet",
				"ponder", "pounce", "puzzle", "question", "read", "ready", "talk",
				"talkex", "talkq", "wait", "whistle", "work"
			}
		},
		playful = {
			name = L["Playful"],
			order = 6,
			emotes = {
				"bite", "blink", "blush", "chuckle", "cuddle", "eye", "grin", "kiss",
				"lick", "pat", "pinch", "poke", "purr", "sexy", "shimmy", "smile",
				"smirk", "snicker", "tease", "tickle", "tongue"
			}
		},
		combat = {
			name = L["Combat"],
			order = 7,
			emotes = {
				"charge", "flee", "ready", "roar", "surrender", "taunt", "threaten",
				"victory", "violin", "warn"
			}
		},
		other = {
			name = L["Other"],
			order = 8,
			emotes = {
				"afk", "amaze", "brb", "dnd", "doom", "drool", "drink", "eat",
				"golfclap", "grovel", "hungry", "incoming", "oom", "openfire",
				"rasp", "shoo", "shout", "sniff", "spit", "stare", "thirsty",
				"veto", "volunteer", "yawn"
			}
		}
	}

	for categoryKey, category in pairs(emoteCategories) do
		local categoryArgs = {
			header = {
				name = category.name,
				type = "header",
				order = 0,
			},
			selectAll = {
				name = L["Select All"],
				type = "execute",
				order = 1,
				func = function()
					for _, emote in ipairs(category.emotes) do
						addon.EmoteManager:AddEmote(emote)
					end
					addon.RadialMenu:ShowAtAnchor()
				end,
			},
			selectNone = {
				name = L["Select None"],
				type = "execute",
				order = 2,
				func = function()
					for _, emote in ipairs(category.emotes) do
						addon.EmoteManager:RemoveEmote(emote)
					end
					addon.RadialMenu:ShowAtAnchor()
				end,
			},
			spacer = {
				name = "",
				type = "description",
				order = 3,
			},
		}

		for i, emote in ipairs(category.emotes) do
			categoryArgs[emote] = {
				name = emote:gsub("^%l", string.upper),
				type = "toggle",
				order = 10 + i,
				get = function()
					return addon.EmoteManager:IsEmoteEnabled(emote)
				end,
				set = function(_, val)
					if val then
						addon.EmoteManager:AddEmote(emote)
					else
						addon.EmoteManager:RemoveEmote(emote)
					end
					addon.RadialMenu:ShowAtAnchor()
				end,
			}
		end

		options.args.emotes.args[categoryKey] = {
			name = category.name,
			type = "group",
			order = category.order,
			args = categoryArgs,
		}
	end

	return options
end

local EmoteRadialMenu = LibStub("AceAddon-3.0"):GetAddon("EmoteRadialMenu")

if EmoteRadialMenu then
	local options = CreateOptionsTable(EmoteRadialMenu)
	AceConfig:RegisterOptionsTable("EmoteRadialMenu", options)
	AceConfigDialog:AddToBlizOptions("EmoteRadialMenu", "EmoteRadialMenu")
end
