local AddonName = ...
local L = EmoteRadialMenu_Locale or {}

if GetLocale() ~= "deDE" then return end

-- General
L["EmoteRadialMenu loaded. Bind a key to toggle the menu."] = "EmoteRadialMenu geladen. Weise eine Taste zu, um das Menü zu öffnen."
L["Cannot open menu during combat"] = "Menü kann im Kampf nicht geöffnet werden"

-- Config UI
L["Behavior"] = "Verhalten"
L["Close on Use"] = "Bei Benutzung schließen"
L["Automatically close menu after selecting an emote"] = "Menü automatisch nach Auswahl eines Emotes schließen"

L["Menu Appearance"] = "Menü-Aussehen"
L["Opacity"] = "Deckkraft"
L["Transparency of the menu"] = "Transparenz des Menüs"
L["Button Radius"] = "Button-Radius"
L["Distance from center to buttons"] = "Abstand vom Zentrum zu den Buttons"
L["Button Size"] = "Button-Größe"
L["Size of individual emote buttons"] = "Größe der einzelnen Emote-Buttons"

L["Emote Selection"] = "Emote-Auswahl"
L["Select which emotes appear in the radial menu."] = "Wähle aus, welche Emotes im Radialmenü erscheinen."
L["Select All"] = "Alle auswählen"
L["Select None"] = "Keine auswählen"

-- Categories
L["Positive"] = "Positiv"
L["Negative"] = "Negativ"
L["Funny"] = "Lustig"
L["Gestures"] = "Gesten"
L["Social"] = "Sozial"
L["Playful"] = "Verspielt"
L["Combat"] = "Kampf"
L["Other"] = "Sonstiges"

EmoteRadialMenu_Locale = L
return L
