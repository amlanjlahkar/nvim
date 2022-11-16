local Bg = "#16161e"
local BgShadeDark = "#111118"
local BgShadeLight = "#1a1b26"
local BgShadeLighter = "#202431"
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

local DiffDelete = "#3a0411"
local DiffAdd = "#10292d"

local M = {}
-- stylua: ignore
M.custom = {
  { "StatusLineNC",               { bg = BgShadeDark, fg = "NONE" } },
  { "StatusLine",                 { bg = BgShadeDark, fg = FgShadeDarker } },
  { "StatusLineImp",              { bg = BgShadeDark, fg = Fg } },
  { "StatusLineInd",              { bg = BgShadeDark, fg = Green } },
  { "StatusLineDiagnosticError",  { bg = BgShadeDark, fg = Red } },
  { "StatusLineDiagnosticWarn",   { bg = BgShadeDark, fg = Magenta } },
  { "StatusLineDiagnosticHint",   { bg = BgShadeDark, fg = Cyan } },
  { "StatusLineDiagnosticInfo",   { bg = BgShadeDark, fg = Fg } },
  { "SignColumn",                 { bg = BgShadeLighter } },
  { "LineNr",                     { bg = BgShadeDark, fg = FgShadeDarker } },
  { "CursorLineNr",               { bg = BgShadeLighter, fg = White, bold = false } },
  { "WinBar",                     { bg = BgShadeLighter, fg = "#6b779e" } },
  { "WinBarNC",                   { bg = BgShadeLighter, fg = "#6b779e" } },
  { "VertSplit",                  { fg = "#272834" } },
  { "PmenuSel",                   { bg = BgShadeLighter , fg = White } },
  { "PmenuSbar",                  { bg = Bg  } },
  { "PmenuThumb",                 { bg = BgShadeLighter } },
  { "TabLineFill",                { bg = BgShadeDark } },
  { "TabLine",                    { bg = BgShadeDark, fg = FgShadeDarker } },
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
  { "TroubleText",                { bg = "NONE", fg = Fg } },
  { "TroubleFoldIcon",            { bg = "NONE", fg = Fg } },
  { "TroubleIndent",              { bg = "NONE", fg = FgShadeDark } },
  { "TroubleLocation",            { bg = "NONE", fg = FgShadeDark } },
  { "DiffAdd",                    { bg = DiffAdd, fg = Fg } },
  { "DiffDelete",                 { bg = DiffDelete, fg = Fg } },
  { "GitGutterAdd",               { bg = BgShadeLighter, fg = Green } },
  { "GitGutterChange",            { bg = BgShadeLighter, fg = Blue } },
  { "GitGutterChangeDelete",      { bg = BgShadeLighter, fg = Magenta } },
  { "GitGutterDelete",            { bg = BgShadeLighter, fg = Red } },
  { "GitSignsAddInline",          { bg = DiffAdd, fg = Green, bold = true } },
  { "GitSignsDeleteInline",       { bg = DiffDelete, fg = Red, italic = false } },
  { "diffAdded",                  { bg = DiffAdd, fg = Green, bold = true } },
  { "diffRemoved",                { bg = DiffDelete, fg = Red, italic = false } },
  { "Error",                      { bg = "NONE", fg = "NONE" } }, -- causes weird paren,brace highlighting on floating windows by default
}

return M.custom
