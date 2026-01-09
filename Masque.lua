local AddonName, Addon = ...

local Masque = LibStub and LibStub("Masque", true)
if not Masque then
	return
end

local MasqueGroup = Masque:Group("EmoteRadialMenu")

local OriginalButtonNew = Addon.EmoteButton.New

function Addon.EmoteButton:New(parent, addon)
	local button = OriginalButtonNew(self, parent, addon)

	if not button.masqueRegistered then
		MasqueGroup:AddButton(button, {
			Icon = button.bg,
			Normal = button.bg,
			Highlight = button.highlight,
			Border = button.border,
		})
		button.masqueRegistered = true
	end

	return button
end

local function UpdateMasque()
	local addon = LibStub("AceAddon-3.0"):GetAddon("EmoteRadialMenu")
	if addon and addon.RadialMenu then
		for _, button in ipairs(addon.RadialMenu.buttons) do
			if button:IsShown() and not button.masqueRegistered then
				MasqueGroup:AddButton(button, {
					Icon = button.bg,
					Normal = button.bg,
					Highlight = button.highlight,
					Border = button.border,
				})
				button.masqueRegistered = true
			end
		end
		MasqueGroup:ReSkin()
	end
end

C_Timer.After(1, UpdateMasque)
