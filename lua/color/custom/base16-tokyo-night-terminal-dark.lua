local Bg = "#16161e"
local BgShadeLight = "#1a1b26"
local BgShadeLighter = "#2a2f41"
local Fg = "#787c99"
local FgShadeDark = "#5b607f"
local FgShadeDarker = "#555b79"
local Black = "#13131b"
local Red = "#f7768e"
local Green = "#41a6b5"
local Yellow = "#e0af68"
local Orange = "#ff9e64"
local Blue = "#7aa2f7"
local Magenta = "#bb9af7"
local Cyan = "#7dcfff"
local White = "#b0b8e0"

local M = {}
-- stylua: ignore
M.custom = {
  { "StatusLineNC",               { bg = BgShadeLight, fg = "NONE" } },
  { "StatusLine",                 { bg = BgShadeLight, fg = FgShadeDarker } },
  { "StatusLineImp",              { bg = BgShadeLight, fg = Fg } },
  { "StatusLineInd",              { bg = BgShadeLight, fg = Green } },
  { "StatusLineDiagnosticError",  { bg = BgShadeLight, fg = Red } },
  { "StatusLineDiagnosticWarn",   { bg = BgShadeLight, fg = Magenta } },
  { "StatusLineDiagnosticHint",   { bg = BgShadeLight, fg = Cyan } },
  { "StatusLineDiagnosticInfo",   { bg = BgShadeLight, fg = Fg } },
  { "LineNr",                     { bg = "NONE", fg = FgShadeDarker } },
  { "CursorLineNr",               { bg = BgShadeLight, fg = Fg, bold = false } },
  { "WinBar",                     { bg = BgShadeLight, fg = FgShadeDark } },
  { "WinBarNC",                   { bg = BgShadeLight, fg = FgShadeDark } },
  { "VertSplit",                  { fg = "#272834" } },
  { "PmenuSel",                   { bg = BgShadeLighter , fg = White } },
  { "PmenuSbar",                  { bg = Bg  } },
  { "PmenuThumb",                 { bg = BgShadeLighter } },
  { "TabLineFill",                { bg = "NONE" } },
  { "TabLine",                    { bg = "NONE", fg = FgShadeDarker } },
  { "TabLineSel",                 { bg = "NONE", fg = White } },
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
  { "TroubleText",                { bg = "NONE", fg = Fg } },
  { "TroubleFoldIcon",            { bg = "NONE", fg = Fg } },
  { "GitSignsChangeInline",       { bg = Bg, fg = White, bold = true } },
  { "GitSignsDeleteInline",       { bg = Bg, fg = White, bold = true } },
  { "DiffAdd",                    { bg = Green, fg = Bg } },
  { "DiffDelete",                 { bg = Red, fg = Bg } },
  { "Error",                      { bg = "NONE", fg = "NONE" } }, -- causes weird paren,brace highlighting on floating windows by default
}

return M.custom
