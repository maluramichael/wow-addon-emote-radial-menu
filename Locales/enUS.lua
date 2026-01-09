local AddonName = ...
local L = {}

-- General
L["EmoteRadialMenu loaded. Bind a key to toggle the menu."] = "EmoteRadialMenu loaded. Bind a key to toggle the menu."
L["Cannot open menu during combat"] = "Cannot open menu during combat"

-- Config UI
L["Behavior"] = "Behavior"
L["Close on Use"] = "Close on Use"
L["Automatically close menu after selecting an emote"] = "Automatically close menu after selecting an emote"

L["Menu Appearance"] = "Menu Appearance"
L["Opacity"] = "Opacity"
L["Transparency of the menu"] = "Transparency of the menu"
L["Button Radius"] = "Button Radius"
L["Distance from center to buttons"] = "Distance from center to buttons"
L["Button Size"] = "Button Size"
L["Size of individual emote buttons"] = "Size of individual emote buttons"

L["Emote Selection"] = "Emote Selection"
L["Select which emotes appear in the radial menu."] = "Select which emotes appear in the radial menu."
L["Select All"] = "Select All"
L["Select None"] = "Select None"

-- Categories
L["Positive"] = "Positive"
L["Negative"] = "Negative"
L["Funny"] = "Funny"
L["Gestures"] = "Gestures"
L["Social"] = "Social"
L["Playful"] = "Playful"
L["Combat"] = "Combat"
L["Other"] = "Other"

-- Set as default locale
if GetLocale() == "enUS" or GetLocale() == "enGB" then
	EmoteRadialMenu_Locale = L
end

return L
