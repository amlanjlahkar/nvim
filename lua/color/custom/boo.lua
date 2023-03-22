local none = "NONE"
local Black = "#000000"
local BlackShadeLight = "#131314"
local BlackShadeLighter = "#171313"
local Bg = "#0f0f10"
local BgShadeLight = "#201c1c"
local BgShadeLighter = "#211c1d"
local Fg = "#726464"
local FgShadeDark = "#849da2"
local FgShadeDarker = "#51494a"
local Red = "#d19299"
local RedShadeDark = "#6c494d"
local RedShadeLight = "#81363f"
local Green = "#63b0b0"
local Blue = "#a9d1df"
local Magenta = "#d5a8e3"
local White = "#ffffff"

local DiffAdd = "#0c1d0e"
local DiffDelete = "#2a080f"

local M = {}
-- stylua: ignore
M.custom = {
  { "StatusLineNC",               { bg = BlackShadeLight, fg = Fg } },
  { "StatusLine",                 { bg = BlackShadeLight, fg = FgShadeDarker } },
  { "StatusLineImp",              { bg = BlackShadeLight, fg = Fg } },
  { "StatusLineInd",              { bg = BlackShadeLight, fg = Red } },
  { "StatusLineDiagnosticError",  { bg = BlackShadeLight, fg = "#fe697d" } },
  { "StatusLineDiagnosticWarn",   { bg = BlackShadeLight, fg = "#dfb8bc" } },
  { "StatusLineDiagnosticHint",   { bg = BlackShadeLight, fg = "#694347" } },
  { "StatusLineDiagnosticInfo",   { bg = BlackShadeLight, fg = "#e4dcec" } },
  { "CursorLineNr",               { bg = Bg, fg = White, bold = false } },
  { "VertSplit",                  { fg = BgShadeLighter } },
  { "Pmenu",                      { bg = BlackShadeLighter , fg = Fg } },
  { "PmenuSel",                   { bg = BgShadeLighter, fg = Red } },
  { "PmenuSbar",                  { bg = BlackShadeLight  } },
  { "PmenuThumb",                 { bg = BgShadeLighter } },
  { "TabLineFill",                { bg = BlackShadeLight } },
  { "TabLine",                    { bg = BlackShadeLight, fg = FgShadeDarker } },
  { "TabLineSel",                 { bg = BgShadeLight, fg = Fg, bold = false } },
  { "TelescopeNormal",            { bg = Bg, fg = Fg } },
  { "TelescopeBorder",            { bg = Bg, fg = FgShadeDarker } },
  { "TelescopePromptTitle",       { bg = Bg, fg = FgShadeDarker } },
  { "TelescopePromptCounter",     { fg = FgShadeDarker } },
  { "TelescopeSelection",         { bg = BgShadeLighter, fg = Red } },
  { "TelescopeMatching",          { fg = "#e15774" } },
  { "FloatTitle",                 { bg = BlackShadeLighter, fg = White } },
  { "NormalFloat",                { bg = Bg, fg = Fg } },
  { "FloatBorder",                { bg = Bg, fg = FgShadeDarker } },
  { "NormalFloatAlt",             { bg = Bg, fg = Fg } },
  { "FloatBorderAlt",             { bg = Bg, fg = FgShadeDarker } },
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
  { "DiffDelete",                 { bg = DiffDelete, fg = RedShadeLight } },
  { "diffAdded",                  { bg = DiffAdd, fg = Green } },
  { "diffRemoved",                { bg = DiffDelete, fg = RedShadeLight } },
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
  { "MatchParen",                 { bg = none, fg = "#e15774", bold = true } },
  { "FidgetTask",                 { fg = Black } },
  { "MiniIndentScopeSymbol",      { fg = RedShadeDark } },
  { "Error",                      { bg = none, fg = none } }, -- causes weird paren,brace highlighting on floating windows by default
}

return M.custom
