local none = "NONE"
local Bg = "#0f0f10"
local BgShadeLight = "#201c1c"
local BgShadeLighter = "#211c1d"
local Fg = "#726464"
local FgShadeDark = "#849da2"
local FgShadeDarker = "#51494a"
local Black = "#000000"
local BlackAlt = "#131314"
local Red = "#d19299"
local RedAlt = "#81363f"
local Green = "#63b0b0"
local Blue = "#a9d1df"
local Magenta = "#d5a8e3"
local White = "#ffffff"

local DiffAdd = "#0c1d0e"
local DiffDelete = "#2a080f"

local M = {}
-- stylua: ignore
M.custom = {
  { "StatusLineNC",               { bg = BlackAlt, fg = Fg } },
  { "StatusLine",                 { bg = BlackAlt, fg = FgShadeDarker } },
  { "StatusLineImp",              { bg = BlackAlt, fg = Fg } },
  { "StatusLineInd",              { bg = BlackAlt, fg = Red } },
  { "StatusLineDiagnosticError",  { bg = BlackAlt, fg = "#fe697d" } },
  { "StatusLineDiagnosticWarn",   { bg = BlackAlt, fg = "#dfb8bc" } },
  { "StatusLineDiagnosticHint",   { bg = BlackAlt, fg = "#694347" } },
  { "StatusLineDiagnosticInfo",   { bg = BlackAlt, fg = "#e4dcec" } },
  { "CursorLineNr",               { bg = Bg, fg = White, bold = false } },
  { "VertSplit",                  { fg = BgShadeLighter } },
  { "Pmenu",                      { bg = Black , fg = Fg } },
  { "PmenuSel",                   { bg = BgShadeLighter, fg = Red } },
  { "PmenuSbar",                  { bg = BlackAlt  } },
  { "PmenuThumb",                 { bg = BgShadeLighter } },
  { "TabLineFill",                { bg = BlackAlt } },
  { "TabLine",                    { bg = BlackAlt, fg = FgShadeDarker } },
  { "TabLineSel",                 { bg = BgShadeLight, fg = Fg, bold = false } },
  { "TelescopeNormal",            { bg = Black, fg = Fg } },
  { "TelescopeBorder",            { bg = Black, fg = Black } },
  { "TelescopePromptTitle",       { bg = Black, fg = Fg } },
  { "TelescopePromptCounter",     { fg = Fg } },
  { "TelescopeSelection",         { bg = BgShadeLighter, fg = Red } },
  { "TelescopeMatching",          { fg = "#e15774" } },
  { "FloatTitle",                 { bg = Black, fg = White } },
  { "NormalFloat",                { bg = Black, fg = Fg } },
  { "FloatBorder",                { bg = Black, fg = Black } },
  { "NormalFloatAlt",             { bg = Black, fg = Fg } },
  { "FloatBorderAlt",             { bg = Black, fg = Black } },
  { "LspReference",               { bg = BgShadeLighter, fg = "#d9d6cf", underline = false } },
  { "VimModeNormal",              { bg = BgShadeLighter, fg = Red } },
  { "VimModeInsert",              { bg = BgShadeLighter, fg = Red } },
  { "VimModeVisual",              { bg = BgShadeLighter, fg = Red } },
  { "VimModeCommand",             { bg = BgShadeLighter, fg = Red } },
  { "VimModeExtra",               { bg = BgShadeLighter, fg = Red } },
  { "SnipChoiceNode",             { bg = BgShadeLight, fg = Blue } },
  { "SnipInsertNode",             { bg = BgShadeLight, fg = Green } },
  { "TroubleText",                { bg = none, fg = Fg } },
  { "TroubleFoldIcon",            { bg = none, fg = Fg } },
  { "TroubleIndent",              { bg = none, fg = FgShadeDark } },
  { "TroubleLocation",            { bg = none, fg = FgShadeDark } },
  { "DiffAdd",                    { bg = DiffAdd, fg = Green } },
  { "DiffDelete",                 { bg = DiffDelete, fg = RedAlt } },
  { "diffAdded",                  { bg = DiffAdd, fg = Green } },
  { "diffRemoved",                { bg = DiffDelete, fg = RedAlt } },
  { "GitGutterAdd",               { fg = Green } },
  { "GitGutterChange",            { fg = Blue } },
  { "GitGutterChangeDelete",      { fg = Magenta } },
  { "GitGutterDelete",            { fg = Red } },
  { "GitSignsAddInline",          { bg = DiffAdd, fg = Green, bold = false } },
  { "GitSignsDeleteInline",       { bg = DiffDelete, fg = Red, italic = false } },
  { "Visual",                     { bg = BgShadeLighter, fg = White } },
  { "CmpItemKind",                { fg = FgShadeDark } },
  { "CmpItemMenu",                { fg = FgShadeDarker } },
  { "QuickFixLine",               { bg = BgShadeLighter } },
  { "NonText",                    { fg = FgShadeDarker } },
  { "Error",                      { bg = none, fg = none } }, -- causes weird paren,brace highlighting on floating windows by default
}

return M.custom
