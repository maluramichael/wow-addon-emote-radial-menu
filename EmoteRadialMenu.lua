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
	self:SetupKeyListener()
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
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")
	AceConfigDialog:Open("EmoteRadialMenu")
end

function EmoteRadialMenu:SetupKeyListener()
	if not self.keyListenerFrame then
		local frame = CreateFrame("Frame")
		frame:SetScript("OnUpdate", function(self, elapsed)
			local addon = EmoteRadialMenu
			if addon.db.profile.menu.holdToShow and addon.RadialMenu.keyPressed then
				local keyDown = IsModifierKeyDown() or GetMouseButtonClicked()
				if not keyDown then
					addon.RadialMenu.keyPressed = false
					addon.RadialMenu:Hide()
				end
			end
		end)
		self.keyListenerFrame = frame
	end
end

function EmoteRadialMenu_ToggleMenu(keystate)
	local addon = LibStub("AceAddon-3.0"):GetAddon("EmoteRadialMenu")

	if not addon then
		return
	end

	if InCombatLockdown() then
		addon:Print("Cannot open menu during combat")
		return
	end

	local holdMode = addon.db.profile.menu.holdToShow

	if holdMode then
		if keystate == "down" or not keystate then
			addon.RadialMenu.keyPressed = true
			addon.RadialMenu:Show()
		else
			addon.RadialMenu.keyPressed = false
			addon.RadialMenu:Hide()
		end
	else
		if addon.RadialMenu:IsShown() then
			addon.RadialMenu:Hide()
		else
			addon.RadialMenu:Show()
		end
	end
end
