local AddonName, Addon = ...

local Masque = LibStub and LibStub("Masque", true)
if not Masque then
	return
end

local MasqueGroup = Masque:Group("EmoteRadialMenu")

local function RegisterButton(button)
	if button.masqueRegistered then return end

	-- Create a separate texture for Masque's Icon layer
	-- so it doesn't override our visual background
	local masqueIcon = button:CreateTexture(nil, "ARTWORK")
	masqueIcon:SetSize(36, 36)
	masqueIcon:SetPoint("CENTER")
	masqueIcon:SetColorTexture(0, 0, 0, 0)

	MasqueGroup:AddButton(button, {
		Icon = masqueIcon,
		Normal = false,
		Highlight = button:GetHighlightTexture(),
	})

	-- Hide manual border since Masque provides its own
	if button.border then
		button.border:Hide()
	end

	button.masqueRegistered = true
end

local OriginalButtonNew = Addon.EmoteButton.New

function Addon.EmoteButton:New(parent, addon)
	local button = OriginalButtonNew(self, parent, addon)
	RegisterButton(button)
	return button
end

local function UpdateMasque()
	local addon = LibStub("AceAddon-3.0"):GetAddon("EmoteRadialMenu")
	if addon and addon.RadialMenu then
		for _, button in ipairs(addon.RadialMenu.buttons) do
			RegisterButton(button)
		end
		MasqueGroup:ReSkin()
	end
end

C_Timer.After(1, UpdateMasque)
