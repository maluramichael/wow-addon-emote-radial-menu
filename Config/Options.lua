local AddonName, Addon = ...

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local function CreateOptionsTable(addon)
	local options = {
		name = "EmoteRadialMenu",
		type = "group",
		args = {
			behavior = {
				name = "Behavior",
				type = "group",
				order = 1,
				args = {
					closeOnUse = {
						name = "Close on Use",
						desc = "Automatically close menu after selecting an emote",
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
				name = "Menu Appearance",
				type = "group",
				order = 2,
				args = {
					alpha = {
						name = "Opacity",
						desc = "Transparency of the menu",
						type = "range",
						min = 0.1,
						max = 1.0,
						step = 0.05,
						order = 2,
						get = function()
							return addon.db.profile.menu.alpha
						end,
						set = function(_, val)
							addon.db.profile.menu.alpha = val
							if addon.RadialMenu:IsShown() then
								addon.RadialMenu:ApplySettings()
							end
						end,
					},
					buttonRadius = {
						name = "Button Radius",
						desc = "Distance from center to buttons",
						type = "range",
						min = 50,
						max = 200,
						step = 5,
						order = 3,
						get = function()
							return addon.db.profile.menu.buttonRadius
						end,
						set = function(_, val)
							addon.db.profile.menu.buttonRadius = val
							if addon.RadialMenu:IsShown() then
								addon.RadialMenu:ApplySettings()
							end
						end,
					},
					buttonSize = {
						name = "Button Size",
						desc = "Size of individual emote buttons",
						type = "range",
						min = 20,
						max = 80,
						step = 2,
						order = 4,
						get = function()
							return addon.db.profile.menu.buttonSize
						end,
						set = function(_, val)
							addon.db.profile.menu.buttonSize = val
							if addon.RadialMenu:IsShown() then
								addon.RadialMenu:ApplySettings()
							end
						end,
					},
				},
			},
			emotes = {
				name = "Emote Selection",
				type = "group",
				order = 3,
				args = {
					description = {
						name = "Select which emotes appear in the radial menu. Add or remove emotes as needed.",
						type = "description",
						order = 0,
					},
				},
			},
		},
	}

	local allEmotes = addon.EmoteManager:GetAllEmotes()
	table.sort(allEmotes)

	for i, emote in ipairs(allEmotes) do
		options.args.emotes.args[emote] = {
			name = emote:gsub("^%l", string.upper),
			type = "toggle",
			order = i,
			get = function()
				return addon.EmoteManager:IsEmoteEnabled(emote)
			end,
			set = function(_, val)
				if val then
					addon.EmoteManager:AddEmote(emote)
				else
					addon.EmoteManager:RemoveEmote(emote)
				end
				if addon.RadialMenu:IsShown() then
					addon.RadialMenu:ApplySettings()
				end
			end,
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
