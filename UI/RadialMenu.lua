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

	local profile = self.addon.db.profile
	local x, y

	if profile.menu.useAnchor then
		x, y = self:GetAnchorPosition()
	else
		local scale = UIParent:GetEffectiveScale()
		x, y = GetCursorPosition()
		x = x / scale
		y = y / scale
	end

	self.cursorX = x
	self.cursorY = y

	self.frame:ClearAllPoints()
	self.frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y)

	self:RebuildButtons()
	self:PositionButtons()

	self.frame:Show()
	self.clickFrame:Show()
end

function RadialMenu:ShowAtAnchor()
	if not self.frame then
		self:CreateFrames()
	end

	local x, y = self:GetAnchorPosition()
	self.cursorX = x
	self.cursorY = y

	self.frame:ClearAllPoints()
	self.frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y)

	self:RebuildButtons()
	self:PositionButtons()

	self.frame:Show()
	self.clickFrame:Show()
end

function RadialMenu:GetAnchorPosition()
	local profile = self.addon.db.profile
	local anchorPoint = profile.menu.anchorPoint
	local offsetX = profile.menu.anchorOffsetX
	local offsetY = profile.menu.anchorOffsetY

	local screenWidth = UIParent:GetWidth()
	local screenHeight = UIParent:GetHeight()
	local x, y

	if anchorPoint == "CENTER" then
		x = screenWidth / 2
		y = screenHeight / 2
	elseif anchorPoint == "TOP" then
		x = screenWidth / 2
		y = screenHeight
	elseif anchorPoint == "BOTTOM" then
		x = screenWidth / 2
		y = 0
	elseif anchorPoint == "LEFT" then
		x = 0
		y = screenHeight / 2
	elseif anchorPoint == "RIGHT" then
		x = screenWidth
		y = screenHeight / 2
	elseif anchorPoint == "TOPLEFT" then
		x = 0
		y = screenHeight
	elseif anchorPoint == "TOPRIGHT" then
		x = screenWidth
		y = screenHeight
	elseif anchorPoint == "BOTTOMLEFT" then
		x = 0
		y = 0
	elseif anchorPoint == "BOTTOMRIGHT" then
		x = screenWidth
		y = 0
	end

	return x + offsetX, y + offsetY
end

function RadialMenu:Hide()
	if self.frame then
		self.frame:Hide()
	end
	if self.clickFrame then
		self.clickFrame:Hide()
	end

	for _, button in ipairs(self.buttons) do
		button:Hide()
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
	local buttonSize = 40
	local alpha = profile.menu.alpha

	for i, emote in ipairs(emotes) do
		local button = self.buttons[i]
		if button then
			Addon.EmoteButton:SetEmote(button, emote)
			button:SetSize(buttonSize, buttonSize)
			button:SetAlpha(alpha)
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
	local layout = profile.menu.layout
	local scale = UIParent:GetEffectiveScale()
	local centerX, centerY = GetCursorPosition()
	centerX = centerX / scale
	centerY = centerY / scale

	if layout == "grid" then
		self:PositionButtonsGrid(numButtons, centerX, centerY)
	else
		self:PositionButtonsRadial(numButtons, centerX, centerY)
	end
end

function RadialMenu:PositionButtonsRadial(numButtons, centerX, centerY)
	local profile = self.addon.db.profile
	local radius = profile.menu.buttonRadius

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

function RadialMenu:PositionButtonsGrid(numButtons, centerX, centerY)
	local profile = self.addon.db.profile
	local columns = profile.menu.columns
	local rows = profile.menu.rows
	local gap = profile.menu.gap
	local buttonSize = 40

	local totalWidth = (columns * buttonSize) + ((columns - 1) * gap)
	local totalHeight = (rows * buttonSize) + ((rows - 1) * gap)
	local startX = centerX - (totalWidth / 2) + (buttonSize / 2)
	local startY = centerY + (totalHeight / 2) - (buttonSize / 2)

	for i = 1, numButtons do
		local button = self.buttons[i]
		if button and button:IsShown() then
			local col = ((i - 1) % columns)
			local row = math.floor((i - 1) / columns)

			local x = startX + (col * (buttonSize + gap))
			local y = startY - (row * (buttonSize + gap))

			button:ClearAllPoints()
			button:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y)
		end
	end
end

function RadialMenu:ApplySettings()
	local profile = self.addon.db.profile
	local alpha = profile.menu.alpha

	for _, button in ipairs(self.buttons) do
		if button then
			button:SetAlpha(alpha)
		end
	end

	if self:IsShown() then
		self:RebuildButtons()
		self:PositionButtons()
	end
end
