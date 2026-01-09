local AddonName, Addon = ...

local EmoteRadialMenu = LibStub("AceAddon-3.0"):NewAddon(Addon, AddonName, "AceEvent-3.0", "AceConsole-3.0")

function EmoteRadialMenu:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("EmoteRadialMenuDB", Addon.Database.defaults, true)

	self.EmoteManager = Addon.EmoteManager:New(self)
	self.RadialMenu = Addon.RadialMenu:New(self)

	self:RegisterChatCommand("emote", "SlashCommand")
	self:RegisterChatCommand("erm", "SlashCommand")

	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
end

function EmoteRadialMenu:OnEnable()
	self.RadialMenu:CreateFrames()
	self:Print("EmoteRadialMenu loaded. Bind a key to toggle the menu.")
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
	if input == "config" or input == "options" then
		local AceConfigDialog = LibStub("AceConfigDialog-3.0")
		AceConfigDialog:Open("EmoteRadialMenu")
	else
		self:Print("Commands:")
		self:Print("/emote config - Open configuration")
		self:Print("Bind a key to toggle the radial menu")
	end
end

function EmoteRadialMenu_ToggleMenu()
	local addon = LibStub("AceAddon-3.0"):GetAddon("EmoteRadialMenu")

	if not addon then
		return
	end

	if InCombatLockdown() then
		addon:Print("Cannot open menu during combat")
		return
	end

	if addon.RadialMenu:IsShown() then
		addon.RadialMenu:Hide()
	else
		addon.RadialMenu:Show()
	end
end
