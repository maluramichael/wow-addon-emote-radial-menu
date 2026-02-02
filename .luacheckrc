std = "lua51"
codes = true
quiet = 1
max_line_length = false
exclude_files = { ".release/", "libs/", "Libs/" }

globals = {
    "EmoteRadialMenu", "EmoteRadialMenu_ToggleMenu",
    "BINDING_HEADER_EMOTERADIALMENU", "BINDING_NAME_EMOTEMENU_TOGGLE",
}

read_globals = {
    "_G", "LibStub",
    "CreateFrame", "UIParent", "GameTooltip", "Settings",
    "DoEmote", "GetCursorPosition", "UIParent",
    "InterfaceOptionsFrame_OpenToCategory",
    "pairs", "ipairs", "select", "string", "table", "math", "format",
    "tonumber", "tostring", "type", "unpack",
}
