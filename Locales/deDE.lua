local AddonName = ...
local L = EmoteRadialMenu_Locale or {}

if GetLocale() ~= "deDE" then return end

-- Keybindings
BINDING_HEADER_EmoteRadialMenu = "EmoteRadialMenu"
BINDING_NAME_EMOTEMENU_TOGGLE = "Emote-Menü umschalten"

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
L["Spawn Position"] = "Spawn-Position"
L["Where the menu appears when opened"] = "Wo das Menü beim Öffnen erscheint"
L["Mouse Cursor"] = "Mauszeiger"
L["Fixed Position"] = "Feste Position"
L["Anchor Point"] = "Ankerpunkt"
L["Screen position for fixed spawn"] = "Bildschirmposition für feste Spawn"
L["Anchor Offset X"] = "Anker-Versatz X"
L["Horizontal offset from anchor point"] = "Horizontaler Versatz vom Ankerpunkt"
L["Anchor Offset Y"] = "Anker-Versatz Y"
L["Vertical offset from anchor point"] = "Vertikaler Versatz vom Ankerpunkt"
L["Layout"] = "Layout"
L["Choose between radial or grid layout"] = "Wähle zwischen radial oder Gitter-Layout"
L["Radial"] = "Radial"
L["Grid"] = "Gitter"
L["Button Radius"] = "Button-Radius"
L["Distance from center to buttons"] = "Abstand vom Zentrum zu den Buttons"
L["Columns"] = "Spalten"
L["Number of columns in grid layout"] = "Anzahl der Spalten im Gitter-Layout"
L["Rows"] = "Zeilen"
L["Number of rows in grid layout"] = "Anzahl der Zeilen im Gitter-Layout"
L["Gap"] = "Abstand"
L["Space between buttons in grid layout"] = "Abstand zwischen Buttons im Gitter-Layout"

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
