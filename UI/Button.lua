local AddonName, Addon = ...

local EmoteButton = {}
Addon.EmoteButton = EmoteButton

function EmoteButton:New(parent, addon)
	local button = CreateFrame("Button", nil, parent)
	button.addon = addon

	button:SetSize(40, 40)
	button:EnableMouse(true)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:SetFrameStrata("DIALOG")
	button:SetFrameLevel(11)

	-- Icon/background (Masque skins this as the Icon layer)
	local icon = button:CreateTexture(nil, "BACKGROUND")
	icon:SetAllPoints()
	icon:SetColorTexture(0.15, 0.15, 0.18, 0.95)
	button.icon = icon

	-- Border (visible without Masque, hidden when Masque is active)
	local border = button:CreateTexture(nil, "BORDER")
	border:SetColorTexture(0.4, 0.4, 0.45, 1)
	border:SetPoint("TOPLEFT", button, "TOPLEFT", -1, 1)
	border:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 1, -1)
	button.border = border

	-- Highlight via WoW API so Masque can replace it
	local highlight = button:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetAllPoints()
	highlight:SetColorTexture(0.4, 0.7, 1.0, 0.3)
	highlight:SetBlendMode("ADD")
	button:SetHighlightTexture(highlight)

	-- Text label
	local text = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	text:SetPoint("CENTER")
	text:SetTextColor(1, 0.9, 0.5, 1)
	button.text = text

	button:SetScript("OnEnter", function(self)
		self.text:SetTextColor(1, 1, 1, 1)
	end)

	button:SetScript("OnLeave", function(self)
		self.text:SetTextColor(1, 0.9, 0.5, 1)
	end)

	button:SetScript("OnClick", function(self, mouseButton)
		if mouseButton == "LeftButton" and self.emote then
			addon.EmoteManager:ExecuteEmote(self.emote)
			if addon.db.profile.menu.closeOnUse then
				addon.RadialMenu:Hide()
			end
		end
	end)

	button:Hide()
	return button
end

function EmoteButton:SetEmote(button, emote)
	button.emote = emote
	local displayName = emote:gsub("^%l", string.upper)
	button.text:SetText(displayName)
end
