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

	local bg = button:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetColorTexture(0.15, 0.15, 0.18, 0.95)
	button.bg = bg

	local border = button:CreateTexture(nil, "BORDER")
	border:SetAllPoints()
	border:SetColorTexture(0.4, 0.4, 0.45, 1)
	border:SetPoint("TOPLEFT", button, "TOPLEFT", -1, 1)
	border:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 1, -1)
	button.border = border

	local highlight = button:CreateTexture(nil, "ARTWORK")
	highlight:SetAllPoints(bg)
	highlight:SetColorTexture(0.4, 0.7, 1.0, 0.5)
	highlight:SetBlendMode("ADD")
	highlight:Hide()
	button.highlight = highlight

	local glow = button:CreateTexture(nil, "OVERLAY")
	glow:SetPoint("TOPLEFT", button, "TOPLEFT", -8, 8)
	glow:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 8, -8)
	glow:SetColorTexture(0.5, 0.8, 1.0, 0.3)
	glow:SetBlendMode("ADD")
	glow:Hide()
	button.glow = glow

	local text = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	text:SetPoint("CENTER")
	text:SetTextColor(1, 0.9, 0.5, 1)
	button.text = text

	button:SetScript("OnEnter", function(self)
		self.highlight:Show()
		self.glow:Show()
		self:SetScale(1.15)
		self.text:SetTextColor(1, 1, 1, 1)
	end)

	button:SetScript("OnLeave", function(self)
		self.highlight:Hide()
		self.glow:Hide()
		self:SetScale(1.0)
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

function EmoteButton:UpdateColors(button)
	local profile = button.addon.db.profile
	local c = profile.menu.buttonColor
	button.bg:SetColorTexture(c[1], c[2], c[3], 0.9)
end
