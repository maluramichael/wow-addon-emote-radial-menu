local AddonName, Addon = ...

local EmoteButton = {}
Addon.EmoteButton = EmoteButton

function EmoteButton:New(parent, addon)
	local button = CreateFrame("Button", nil, parent)
	button.addon = addon

	button:SetSize(40, 40)
	button:EnableMouse(true)
	button:SetFrameStrata("DIALOG")
	button:SetFrameLevel(11)

	local bg = button:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetColorTexture(0.3, 0.3, 0.3, 0.9)
	button.bg = bg

	local text = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	text:SetPoint("CENTER")
	button.text = text

	button:SetScript("OnEnter", function(self)
		local profile = addon.db.profile
		local c = profile.menu.buttonHoverColor
		self.bg:SetColorTexture(c[1], c[2], c[3], 0.9)
	end)

	button:SetScript("OnLeave", function(self)
		local profile = addon.db.profile
		local c = profile.menu.buttonColor
		self.bg:SetColorTexture(c[1], c[2], c[3], 0.9)
	end)

	button:SetScript("OnClick", function(self, mouseButton)
		if mouseButton == "LeftButton" and self.emote then
			addon.RadialMenu:Hide()
			addon.EmoteManager:ExecuteEmote(self.emote)
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

function EmoteButton:UpdateColors(button)
	local profile = button.addon.db.profile
	local c = profile.menu.buttonColor
	button.bg:SetColorTexture(c[1], c[2], c[3], 0.9)
end
