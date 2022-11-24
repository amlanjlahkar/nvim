local none = "NONE"
local Bg = "#16161e"
local BgShadeLight = "#1a1b26"
local BgShadeLighter = "#202431"
local Fg = "#787c99"
local FgShadeDark = "#5b607f"
local FgShadeDarker = "#555b79"
local Black = "#111118"
local Red = "#f7768e"
local Green = "#41a6b5"
local Yellow = "#e0af68"
local Orange = "#ff9e64"
local Blue = "#7aa2f7"
local Magenta = "#bb9af7"
local Cyan = "#7dcfff"
local White = "#b0b8e0"

local DiffDelete = "#3a0411"
local DiffAdd = "#10292d"

local M = {}
-- stylua: ignore
M.custom = {
  { "StatusLineNC",               { bg = Black, fg = none } },
  { "StatusLine",                 { bg = Black, fg = FgShadeDarker } },
  { "StatusLineImp",              { bg = Black, fg = Fg } },
  { "StatusLineInd",              { bg = Black, fg = Green } },
  { "StatusLineDiagnosticError",  { bg = Black, fg = Red } },
  { "StatusLineDiagnosticWarn",   { bg = Black, fg = Magenta } },
  { "StatusLineDiagnosticHint",   { bg = Black, fg = Cyan } },
  { "StatusLineDiagnosticInfo",   { bg = Black, fg = Fg } },
  { "SignColumn",                 { bg = Bg } },
  { "LineNr",                     { bg = Bg, fg = FgShadeDarker } },
  { "CursorLineNr",               { bg = Bg, fg = White, bold = false } },
  { "WinBar",                     { bg = BgShadeLighter, fg = "#6b779e" } },
  { "WinBarNC",                   { bg = BgShadeLighter, fg = "#6b779e" } },
  { "VertSplit",                  { fg = BgShadeLighter } },
  { "PmenuSel",                   { bg = BgShadeLighter , fg = White } },
  { "PmenuSbar",                  { bg = Bg  } },
  { "PmenuThumb",                 { bg = BgShadeLighter } },
  { "TabLineFill",                { bg = Black } },
  { "TabLine",                    { bg = Black, fg = FgShadeDarker } },
  { "TabLineSel",                 { bg = BgShadeLighter, fg = "#b5bbcf", bold = false } },
  { "TelescopeSelection",         { bg = BgShadeLighter , fg = White } },
  { "TelescopeNormal",            { bg = BgShadeLight } },
  { "TelescopeBorder",            { bg = BgShadeLight, fg = BgShadeLight } },
  { "TelescopeResultsTitle",      { bg = BgShadeLight, fg = BgShadeLight } },
  { "FloatTitle",                 { bg = Bg, fg = White } },
  { "NormalFloat",                { bg = Bg, fg = Fg } },
  { "FloatBorder",                { bg = Bg, fg = BgShadeLighter } },
  { "NormalFloatAlt",             { bg = BgShadeLight, fg = Fg } },
  { "FloatBorderAlt",             { bg = BgShadeLight, fg = BgShadeLight } },
  { "LspReference",               { bg = BgShadeLighter } },
  { "VimModeNormal",              { bg = "#041b4d", fg = Blue } },
  { "VimModeInsert",              { bg = "#16373c", fg = Green } },
  { "VimModeVisual",              { bg = "#521e00", fg = Orange } },
  { "VimModeCommand",             { bg = "#1e064b", fg = Magenta } },
  { "VimModeExtra",               { bg = "#4d0412", fg = Red } },
  { "SnipChoiceNode",             { bg = BgShadeLight, fg = Orange } },
  { "SnipInsertNode",             { bg = BgShadeLight, fg = Green } },
  { "TroubleText",                { bg = none, fg = Fg } },
  { "TroubleFoldIcon",            { bg = none, fg = Fg } },
  { "TroubleIndent",              { bg = none, fg = FgShadeDark } },
  { "TroubleLocation",            { bg = none, fg = FgShadeDark } },
  { "DiffAdd",                    { bg = DiffAdd, fg = Green } },
  { "DiffDelete",                 { bg = DiffDelete, fg = Red } },
  { "GitGutterAdd",               { bg = Bg, fg = Green } },
  { "GitGutterChange",            { bg = Bg, fg = Blue } },
  { "GitGutterChangeDelete",      { bg = Bg, fg = Magenta } },
  { "GitGutterDelete",            { bg = Bg, fg = Red } },
  { "GitSignsAddInline",          { bg = DiffAdd, fg = Green, bold = true } },
  { "GitSignsDeleteInline",       { bg = DiffDelete, fg = Red, italic = false } },
  { "Error",                      { bg = none, fg = none } }, -- causes weird paren,brace highlighting on floating windows by default
}

return M.custom
