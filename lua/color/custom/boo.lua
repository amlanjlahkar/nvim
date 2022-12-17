local none = "NONE"
local Bg = "#0f0f10"
local BgShadeLight = "#201c1c"
local BgShadeLighter = "#372f30"
local Fg = "#726464"
local FgShadeDark = "#849da2"
local FgShadeDarker = "#51494a"
local Black = "#000000"
local Red = "#d19299"
local Green = "#63b0b0"
local Blue = "#a9d1df"
local Magenta = "#d5a8e3"
local White = "#ffffff"

local DiffAdd = "#0c1d0e"
local DiffDelete = "#2a080f"

local M = {}
-- stylua: ignore
M.custom = {
  { "StatusLineNC",               { bg = Black, fg = none } },
  { "StatusLine",                 { bg = Black, fg = FgShadeDarker } },
  { "StatusLineImp",              { bg = Black, fg = Fg } },
  { "StatusLineInd",              { bg = Black, fg = Red } },
  { "StatusLineDiagnosticError",  { bg = Black, fg = "#fe697d" } },
  { "StatusLineDiagnosticWarn",   { bg = Black, fg = "#dfb8bc" } },
  { "StatusLineDiagnosticHint",   { bg = Black, fg = "#694347" } },
  { "StatusLineDiagnosticInfo",   { bg = Black, fg = "#e4dcec" } },
  { "CursorLineNr",               { bg = Bg, fg = White, bold = false } },
  { "VertSplit",                  { fg = BgShadeLighter } },
  { "Pmenu",                      { bg = BgShadeLight , fg = Fg } },
  { "PmenuSel",                   { bg = BgShadeLighter, fg = Red } },
  { "PmenuSbar",                  { bg = Bg  } },
  { "PmenuThumb",                 { bg = BgShadeLighter } },
  { "TabLineFill",                { bg = Black } },
  { "TabLine",                    { bg = Black, fg = FgShadeDarker } },
  { "TabLineSel",                 { bg = BgShadeLight, fg = Fg, bold = false } },
  { "TelescopeNormal",            { bg = BgShadeLight, fg = Fg } },
  { "TelescopeBorder",            { bg = BgShadeLight, fg = BgShadeLight } },
  { "TelescopePromptTitle",       { bg = BgShadeLight, fg = Fg } },
  { "TelescopePromptCounter",     { fg = Fg } },
  { "TelescopeMatching",          { fg = "#e15774" } },
  { "FloatTitle",                 { bg = Bg, fg = White } },
  { "NormalFloat",                { bg = Bg, fg = Fg } },
  { "FloatBorder",                { bg = Bg, fg = BgShadeLighter } },
  { "NormalFloatAlt",             { bg = BgShadeLight, fg = Fg } },
  { "FloatBorderAlt",             { bg = BgShadeLight, fg = BgShadeLight } },
  { "LspReference",               { bg = BgShadeLighter, underline = false } },
  { "SnipChoiceNode",             { bg = BgShadeLight, fg = Blue } },
  { "SnipInsertNode",             { bg = BgShadeLight, fg = Green } },
  { "TroubleText",                { bg = none, fg = Fg } },
  { "TroubleFoldIcon",            { bg = none, fg = Fg } },
  { "TroubleIndent",              { bg = none, fg = FgShadeDark } },
  { "TroubleLocation",            { bg = none, fg = FgShadeDark } },
  { "DiffAdd",                    { bg = DiffAdd, fg = Green } },
  { "DiffDelete",                 { bg = DiffDelete, fg = Red } },
  { "diffAdded",                  { bg = DiffAdd, fg = Green } },
  { "diffRemoved",                { bg = DiffDelete, fg = Red } },
  { "GitGutterAdd",               { fg = Green } },
  { "GitGutterChange",            { fg = Blue } },
  { "GitGutterChangeDelete",      { fg = Magenta } },
  { "GitGutterDelete",            { fg = Red } },
  { "GitSignsAddInline",          { bg = DiffAdd, fg = Green, bold = false } },
  { "GitSignsDeleteInline",       { bg = DiffDelete, fg = Red, italic = false } },
  { "Visual",                     { bg = BgShadeLighter, fg = Red } },
  { "CmpItemKind",                { fg = FgShadeDark } },
  { "CmpItemMenu",                { fg = FgShadeDarker } },
  { "NonText",                    { fg = FgShadeDarker } },
  { "Error",                      { bg = none, fg = none } }, -- causes weird paren,brace highlighting on floating windows by default
}

return M.custom
