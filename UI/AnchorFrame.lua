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

	local frame = CreateFrame("Frame", "EmoteRadialMenuAnchor", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
	frame:SetSize(180, 40)
	frame:SetFrameStrata("DIALOG")
	frame:SetFrameLevel(100)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetClampedToScreen(true)
	frame:Hide()

	if frame.SetBackdrop then
		frame:SetBackdrop({
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 8,
			edgeSize = 12,
			insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
		frame:SetBackdropColor(0.1, 0.1, 0.2, 0.9)
		frame:SetBackdropBorderColor(0.4, 0.4, 0.5, 1)
	end

	local text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	text:SetText("EmoteRadialMenu Anchor")
	text:SetPoint("LEFT", 10, 0)

	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetSize(24, 24)
	close:SetPoint("RIGHT", -2, 0)
	close:SetScript("OnClick", function()
		frame:Hide()
	end)

	local anchorObj = self

	frame:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			self:StartMoving()
		end
	end)

	frame:SetScript("OnMouseUp", function(self)
		self:StopMovingOrSizing()
		anchorObj:UpdatePosition()
	end)

	self.frame = frame
	self.text = text
	self.close = close
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
