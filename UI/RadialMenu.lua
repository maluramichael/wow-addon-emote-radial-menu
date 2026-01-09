local AddonName, Addon = ...

local RadialMenu = {}
Addon.RadialMenu = RadialMenu

function RadialMenu:New(addon)
	local menu = {}
	setmetatable(menu, { __index = self })
	menu.addon = addon
	menu.buttons = {}
	menu.frame = nil
	menu.clickFrame = nil
	return menu
end

function RadialMenu:CreateFrames()
	local frame = CreateFrame("Frame", "EmoteRadialMenuFrame", UIParent)
	frame:SetFrameStrata("DIALOG")
	frame:SetFrameLevel(10)
	frame:SetClampedToScreen(true)
	frame:SetSize(400, 400)
	frame:Hide()

	local centerCircle = CreateFrame("Frame", nil, UIParent)
	centerCircle:SetFrameStrata("DIALOG")
	centerCircle:SetFrameLevel(10)
	centerCircle:SetSize(60, 60)
	centerCircle:Hide()

	local centerBg = centerCircle:CreateTexture(nil, "BACKGROUND")
	centerBg:SetAllPoints()
	centerBg:SetColorTexture(0.1, 0.1, 0.12, 0.95)

	local centerBorder = centerCircle:CreateTexture(nil, "BORDER")
	centerBorder:SetColorTexture(0.4, 0.4, 0.45, 1)
	centerBorder:SetPoint("TOPLEFT", centerCircle, "TOPLEFT", -2, 2)
	centerBorder:SetPoint("BOTTOMRIGHT", centerCircle, "BOTTOMRIGHT", 2, -2)

	local centerIcon = centerCircle:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	centerIcon:SetPoint("CENTER")
	centerIcon:SetText("...")
	centerIcon:SetTextColor(0.6, 0.6, 0.65, 1)

	self.centerCircle = centerCircle
	self.frame = frame

	local clickFrame = CreateFrame("Frame", nil, UIParent)
	clickFrame:SetAllPoints(UIParent)
	clickFrame:SetFrameStrata("DIALOG")
	clickFrame:SetFrameLevel(9)
	clickFrame:EnableMouse(true)
	clickFrame:Hide()

	clickFrame:SetScript("OnMouseDown", function(frame, button)
		if button == "RightButton" then
			self:Hide()
		end
	end)

	clickFrame:SetScript("OnMouseUp", function(frame, button)
		if button == "LeftButton" then
			self:Hide()
		end
	end)

	self.clickFrame = clickFrame

	for i = 1, 24 do
		local button = Addon.EmoteButton:New(UIParent, self.addon)
		table.insert(self.buttons, button)
	end
end

function RadialMenu:Show()
	if not self.frame then
		self:CreateFrames()
	end

	local scale = UIParent:GetEffectiveScale()
	local x, y = GetCursorPosition()
	x = x / scale
	y = y / scale

	self.cursorX = x
	self.cursorY = y

	self.frame:ClearAllPoints()
	self.frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y)

	self.centerCircle:ClearAllPoints()
	self.centerCircle:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y)

	local profile = self.addon.db.profile
	self.frame:SetScale(profile.menu.scale)
	self.frame:SetAlpha(profile.menu.alpha)
	self.centerCircle:SetScale(profile.menu.scale)
	self.centerCircle:SetAlpha(profile.menu.alpha)

	self:RebuildButtons()
	self:PositionButtons()

	self.frame:Show()
	self.centerCircle:Show()
	self.clickFrame:Show()
end

function RadialMenu:Hide()
	if self.frame then
		self.frame:Hide()
	end
	if self.centerCircle then
		self.centerCircle:Hide()
	end
	if self.clickFrame then
		self.clickFrame:Hide()
	end

	for _, button in ipairs(self.buttons) do
		button:EnableMouse(false)
	end
end

function RadialMenu:IsShown()
	return self.frame and self.frame:IsShown()
end

function RadialMenu:RebuildButtons()
	for _, button in ipairs(self.buttons) do
		button:Hide()
		button:EnableMouse(false)
	end

	local emotes = self.addon.EmoteManager:GetEnabledEmotes()
	local profile = self.addon.db.profile
	local buttonSize = profile.menu.buttonSize

	for i, emote in ipairs(emotes) do
		local button = self.buttons[i]
		if button then
			Addon.EmoteButton:SetEmote(button, emote)
			Addon.EmoteButton:UpdateColors(button)
			button:SetSize(buttonSize, buttonSize)
			button:Show()
			button:EnableMouse(true)
		end
	end
end

function RadialMenu:PositionButtons()
	local emotes = self.addon.EmoteManager:GetEnabledEmotes()
	local numButtons = #emotes
	if numButtons == 0 then
		return
	end

	local profile = self.addon.db.profile
	local radius = profile.menu.buttonRadius
	local scale = UIParent:GetEffectiveScale()
	local centerX, centerY = GetCursorPosition()
	centerX = centerX / scale
	centerY = centerY / scale

	for i = 1, numButtons do
		local button = self.buttons[i]
		if button and button:IsShown() then
			local angle = ((i - 1) * 2 * math.pi / numButtons) - (math.pi / 2)
			local x = centerX + (radius * math.cos(angle))
			local y = centerY + (radius * math.sin(angle))

			button:ClearAllPoints()
			button:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y)
		end
	end
end

function RadialMenu:ApplySettings()
	if not self:IsShown() then
		return
	end

	local profile = self.addon.db.profile
	self.frame:SetScale(profile.menu.scale)
	self.frame:SetAlpha(profile.menu.alpha)

	self:RebuildButtons()
	self:PositionButtons()
end
