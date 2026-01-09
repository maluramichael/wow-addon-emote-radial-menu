local AddonName = ...
local L = {}

-- Keybindings
BINDING_HEADER_EmoteRadialMenu = "EmoteRadialMenu"
BINDING_NAME_EMOTEMENU_TOGGLE = "Toggle Emote Menu"

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
L["Spawn Position"] = "Spawn Position"
L["Use Fixed Position"] = "Use Fixed Position"
L["Menu spawns at anchor instead of mouse cursor"] = "Menu spawns at anchor instead of mouse cursor"
L["Anchor Point"] = "Anchor Point"
L["Screen position for fixed spawn"] = "Screen position for fixed spawn"
L["Anchor Offset X"] = "Anchor Offset X"
L["Horizontal offset from anchor point"] = "Horizontal offset from anchor point"
L["Anchor Offset Y"] = "Anchor Offset Y"
L["Vertical offset from anchor point"] = "Vertical offset from anchor point"
L["Layout"] = "Layout"
L["Choose between radial or grid layout"] = "Choose between radial or grid layout"
L["Radial"] = "Radial"
L["Grid"] = "Grid"
L["Button Radius"] = "Button Radius"
L["Distance from center to buttons"] = "Distance from center to buttons"
L["Columns"] = "Columns"
L["Number of columns in grid layout"] = "Number of columns in grid layout"
L["Rows"] = "Rows"
L["Number of rows in grid layout"] = "Number of rows in grid layout"
L["Gap"] = "Gap"
L["Space between buttons in grid layout"] = "Space between buttons in grid layout"

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
