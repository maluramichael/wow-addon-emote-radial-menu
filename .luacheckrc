std = "lua51"
codes = true
quiet = 1
max_line_length = false
exclude_files = { ".release/", "libs/", "Libs/" }

ignore = {
    "21.",          -- All unused variable warnings (W211, W212, W213)
    "231",          -- Variable never accessed
    "311",          -- Value assigned to variable is unused
    "43.",          -- Shadowing warnings (W431, W432)
    "631",          -- Line too long
}

globals = {
    "_G",
    "EmoteRadialMenu", "EmoteRadialMenu_ToggleMenu", "EmoteRadialMenu_Locale",
    "BINDING_HEADER_EMOTERADIALMENU", "BINDING_NAME_EMOTEMENU_TOGGLE",
    "BINDING_HEADER_EmoteRadialMenu",
}

read_globals = {
    "LibStub",
    "CreateFrame", "UIParent", "GameTooltip", "Settings",
    "DoEmote", "GetCursorPosition", "GetLocale",
    "InterfaceOptionsFrame_OpenToCategory",
    "InCombatLockdown", "C_Timer", "BackdropTemplateMixin",
    "pairs", "ipairs", "select", "string", "table", "math", "format",
    "tonumber", "tostring", "type", "unpack",
}
