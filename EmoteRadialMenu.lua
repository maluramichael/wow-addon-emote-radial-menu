local AddonName, Addon = ...

local EmoteRadialMenu = LibStub("AceAddon-3.0"):NewAddon(Addon, AddonName, "AceEvent-3.0", "AceConsole-3.0")
local L = EmoteRadialMenu_Locale or {}

Addon.L = L

function EmoteRadialMenu:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("EmoteRadialMenuDB", Addon.Database.defaults, true)

	self.EmoteManager = Addon.EmoteManager:New(self)
	self.RadialMenu = Addon.RadialMenu:New(self)
	self.AnchorFrame = Addon.AnchorFrame:New(self)

	self:RegisterChatCommand("emote", "SlashCommand")
	self:RegisterChatCommand("erm", "SlashCommand")

	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
end

function EmoteRadialMenu:OnEnable()
	self.RadialMenu:CreateFrames()
	self:Print(L["EmoteRadialMenu loaded. Bind a key to toggle the menu."])
end

function EmoteRadialMenu:OnDisable()
	if self.RadialMenu then
		self.RadialMenu:Hide()
	end
end

function EmoteRadialMenu:RefreshConfig()
	if self.RadialMenu and self.RadialMenu:IsShown() then
		self.RadialMenu:ApplySettings()
	end
end

function EmoteRadialMenu:SlashCommand(input)
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")
	AceConfigDialog:Open("EmoteRadialMenu")
	self:ShowAnchorFrame()
end

function EmoteRadialMenu:ShowAnchorFrame()
	self.AnchorFrame:Show()
end

function EmoteRadialMenu:HideAnchorFrame()
	self.AnchorFrame:Hide()
end

function EmoteRadialMenu:ToggleAnchor(enabled)
	self.db.profile.menu.useAnchor = enabled
	if enabled then
		self:ShowAnchorFrame()
	else
		self:HideAnchorFrame()
	end
end

function EmoteRadialMenu:UpdateAnchorFrame()
	if self.AnchorFrame:IsShown() then
		self.AnchorFrame:UpdatePosition()
	end
	if self.RadialMenu:IsShown() then
		self.RadialMenu:ShowAtAnchor()
	end
end

function EmoteRadialMenu_ToggleMenu()
	local addon = LibStub("AceAddon-3.0"):GetAddon("EmoteRadialMenu")

	if not addon then
		return
	end

	if InCombatLockdown() then
		local L = Addon.L
		addon:Print(L["Cannot open menu during combat"])
		return
	end

	if addon.RadialMenu:IsShown() then
		addon.RadialMenu:Hide()
	else
		addon.RadialMenu:Show()
	end
end
