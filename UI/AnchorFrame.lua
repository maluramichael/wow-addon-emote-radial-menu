local AddonName, Addon = ...

local AnchorFrame = {}
Addon.AnchorFrame = AnchorFrame

function AnchorFrame:New(addon)
	local anchor = {}
	setmetatable(anchor, { __index = self })
	anchor.addon = addon
	anchor.frame = nil
	return anchor
end

function AnchorFrame:Create()
	if self.frame then
		return
	end

	local frame = CreateFrame("Frame", "EmoteRadialMenuAnchor", UIParent)
	frame:SetSize(60, 60)
	frame:SetFrameStrata("DIALOG")
	frame:SetFrameLevel(100)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetClampedToScreen(true)
	frame:Hide()

	local bg = frame:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetColorTexture(0.2, 0.6, 1.0, 0.5)

	local border = frame:CreateTexture(nil, "BORDER")
	border:SetColorTexture(1, 1, 1, 0.8)
	border:SetPoint("TOPLEFT", frame, "TOPLEFT", -2, 2)
	border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 2, -2)

	local text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	text:SetPoint("CENTER")
	text:SetText("⚓")
	text:SetTextColor(1, 1, 1, 1)

	frame:SetScript("OnDragStart", function(self)
		self:StartMoving()
	end)

	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		anchor:UpdatePosition()
	end)

	self.frame = frame
	self.bg = bg
	self.text = text
end

function AnchorFrame:Show()
	if not self.frame then
		self:Create()
	end

	local x, y = self.addon.RadialMenu:GetAnchorPosition()
	self.frame:ClearAllPoints()
	self.frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y)

	self.frame:Show()
	self.addon.RadialMenu:ShowAtAnchor()
end

function AnchorFrame:Hide()
	if self.frame then
		self.frame:Hide()
	end
end

function AnchorFrame:IsShown()
	return self.frame and self.frame:IsShown()
end

function AnchorFrame:UpdatePosition()
	if not self.frame or not self.frame:IsShown() then
		return
	end

	local profile = self.addon.db.profile
	local anchorPoint = profile.menu.anchorPoint

	local centerX, centerY = self.frame:GetCenter()
	local screenWidth = UIParent:GetWidth()
	local screenHeight = UIParent:GetHeight()

	local baseX, baseY = 0, 0

	if anchorPoint == "CENTER" then
		baseX = screenWidth / 2
		baseY = screenHeight / 2
	elseif anchorPoint == "TOP" then
		baseX = screenWidth / 2
		baseY = screenHeight
	elseif anchorPoint == "BOTTOM" then
		baseX = screenWidth / 2
		baseY = 0
	elseif anchorPoint == "LEFT" then
		baseX = 0
		baseY = screenHeight / 2
	elseif anchorPoint == "RIGHT" then
		baseX = screenWidth
		baseY = screenHeight / 2
	elseif anchorPoint == "TOPLEFT" then
		baseX = 0
		baseY = screenHeight
	elseif anchorPoint == "TOPRIGHT" then
		baseX = screenWidth
		baseY = screenHeight
	elseif anchorPoint == "BOTTOMLEFT" then
		baseX = 0
		baseY = 0
	elseif anchorPoint == "BOTTOMRIGHT" then
		baseX = screenWidth
		baseY = 0
	end

	profile.menu.anchorOffsetX = math.floor(centerX - baseX + 0.5)
	profile.menu.anchorOffsetY = math.floor(centerY - baseY + 0.5)

	if self.addon.RadialMenu:IsShown() then
		self.addon.RadialMenu:ShowAtAnchor()
	end
end
