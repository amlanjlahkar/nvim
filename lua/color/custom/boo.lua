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
local RedShadeDarker = "#473234"
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
  { "StatusColSep",               { bg = Black, fg = BgShadeLighter } },
  { "SignColumn",                 { bg = Black } },
  { "LineNr",                     { bg = Black, fg = RedShadeDarker } },
  { "CursorLineNr",               { bg = Black, fg = White, bold = false } },
  { "VertSplit",                  { fg = BgShadeLighter } },
  { "Pmenu",                      { bg = Black , fg = Fg } },
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
  { "DiffDelete",                 { bg = DiffDelete, fg = RedShadeLight } },
  { "diffAdded",                  { bg = DiffAdd, fg = Green } },
  { "diffRemoved",                { bg = DiffDelete, fg = RedShadeLight } },
  { "GitGutterAdd",               { bg = Black, fg = Green } },
  { "GitGutterChange",            { bg = Black, fg = Blue } },
  { "GitGutterChangeDelete",      { bg = Black, fg = Magenta } },
  { "GitGutterDelete",            { bg = Black, fg = Red } },
  { "GitSignsAddInline",          { bg = DiffAdd, fg = Green, bold = false } },
  { "GitSignsDeleteInline",       { bg = DiffDelete, fg = Red, italic = false } },
  { "Visual",                     { bg = BgShadeLighter, fg = White } },
  { "CmpItemKind",                { fg = FgShadeDark } },
  { "CmpItemMenu",                { fg = FgShadeDarker } },
  { "QuickFixLine",               { bg = BgShadeLighter } },
  { "NonText",                    { fg = FgShadeDarker } },
  { "MatchParen",                 { bg = RedShadeDarker, fg = "#e15774", bold = true } },
  { "FidgetTask",                 { fg = Black } },
  { "MiniIndentScopeSymbol",      { fg = RedShadeDarker } },
  -- { "TreesitterContext",          { bg = FgShadeDark, italic = false } }, -- TODO: fix issue with matchparen collison
  { "Error",                      { bg = none, fg = none } }, -- causes weird paren,brace highlighting on floating windows by default
  { "@lsp.type.variable",         { link = "@variable" } },
  { "@lsp.type.macro",            { link = "@macro" } },
  { "@lsp.type.class",            { link = "@type" } },
  { "@lsp.type.type",             { link = "@type" } },
  { "@lsp.type.typeParameter",    { link = "@type.definition" } },
  { "@lsp.type.enum",             { link = "@type" } },
  { "@lsp.type.enumMember",       { link = "@constant" } },
  { "@lsp.type.decorator",        { link = "@function" } },
  { "@lsp.type.function",         { link = "@function" } },
  { "@lsp.type.method",           { link = "@method" } },
  { "@lsp.type.keyword",          { link = "@keyword" } },
  { "@lsp.type.interface",        { link = "@interface" } },
  { "@lsp.type.namespace",        { link = "@namespace" } },
  { "@lsp.type.parameter",        { link = "@parameter" } },
  { "@lsp.type.property",         { link = "@property" } },
  { "@lsp.typemode.function.defaultLibrary",  { link = "@function.builtin" } },
  { "@lsp.typemode.variable.defaultLibrary",  { link = "@variable.builtin" } },
  { "@lsp.typemode.operator.injected",  { link = "@operator" } },
  { "@lsp.typemode.string.injected",    { link = "@string" } },
  { "@lsp.typemode.variable.injected",  { link = "@variable" } },
}

return M.custom
