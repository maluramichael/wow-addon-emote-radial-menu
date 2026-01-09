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
		frame.timeSinceLastCheck = 0
		frame.wasShown = false

		frame:SetScript("OnUpdate", function(self, elapsed)
			self.timeSinceLastCheck = self.timeSinceLastCheck + elapsed

			if self.timeSinceLastCheck < 0.05 then
				return
			end

			self.timeSinceLastCheck = 0

			local addon = EmoteRadialMenu
			local menu = addon.RadialMenu

			if addon.db.profile.menu.holdToShow and menu.keyPressed then
				if not menu:IsShown() then
					menu.keyPressed = false
					return
				end

				local binding = GetBindingKey("EMOTEMENU_TOGGLE")
				local stillPressed = false

				if binding then
					local key = binding
					if key:find("ALT") or key:find("CTRL") or key:find("SHIFT") then
						stillPressed = IsModifierKeyDown()
					end
				end

				if not stillPressed then
					menu.keyPressed = false
					menu:Hide()
				end
			end
		end)

		self.keyListenerFrame = frame
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

	local holdMode = addon.db.profile.menu.holdToShow

	if holdMode then
		if not addon.RadialMenu:IsShown() then
			addon.RadialMenu.keyPressed = true
			addon.RadialMenu:Show()
		end
	else
		if addon.RadialMenu:IsShown() then
			addon.RadialMenu:Hide()
		else
			addon.RadialMenu:Show()
		end
	end
end
