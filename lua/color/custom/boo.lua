local Bg = "#0f0f10"
local BgShadeLight = "#201c1c"
local BgShadeLighter = "#211c1d"
local Black = "#000000"
local BlackShadeLight = "#131314"
local Blue = "#a9d1df"
local BlueShadeDark = "#849da2"
local Fg = "#726464"
local FgShadeDarker = "#51494a"
local Green = "#63b0b0"
local Magenta = "#d5a8e3"
local Red = "#d19299"
local RedShadeDarker = "#473234"
local RedShadeLight = "#81363f"
local RedShadeLighter = "#e4627e"
local White = "#f3dadc"
local none = "NONE"

local DiffAdd = "#0c1d0e"
local DiffDelete = "#2a080f"

local M = {}
--stylua: ignore
M.custom = {
  -- statusline {{{1
  { "StatusLine",                 { bg = BlackShadeLight, fg = FgShadeDarker } },
  { "StatusLineDiagnosticError",  { bg = BlackShadeLight, fg = "#fe697d" } },
  { "StatusLineDiagnosticHint",   { bg = BlackShadeLight, fg = "#694347" } },
  { "StatusLineDiagnosticInfo",   { bg = BlackShadeLight, fg = "#e4dcec" } },
  { "StatusLineDiagnosticWarn",   { bg = BlackShadeLight, fg = "#dfb8bc" } },
  { "StatusLineImp",              { bg = BlackShadeLight, fg = Fg } },
  { "StatusLineInd",              { bg = BlackShadeLight, fg = Red } },
  { "StatusLineNC",               { bg = BlackShadeLight, fg = Fg } },
  { "VimModeCommand",             { bg = BgShadeLighter, fg = Red } },
  { "VimModeExtra",               { bg = BgShadeLighter, fg = Red } },
  { "VimModeInsert",              { bg = BgShadeLighter, fg = Red } },
  { "VimModeNormal",              { bg = BgShadeLighter, fg = Red } },
  { "VimModeVisual",              { bg = BgShadeLighter, fg = Red } },
  -- 1}}}
  -- native {{{1
  { "LineNr",                     { bg = Bg, fg = RedShadeDarker } },
  { "CursorLineNr",               { bg = Bg, fg = White, bold = false } },
  { "SignColumn",                 { bg = Bg } },
  { "NormalFloat",                { bg = Black, fg = Fg } },
  { "FloatBorder",                { bg = Black, fg = Black } },
  { "FloatTitle",                 { bg = BlackShadeLight, fg = Fg, underline = true } },
  { "Pmenu",                      { bg = Black , fg = Fg } },
  { "PmenuSbar",                  { bg = BlackShadeLight  } },
  { "PmenuSel",                   { bg = BgShadeLighter, fg = Red } },
  { "PmenuThumb",                 { bg = BgShadeLighter } },
  { "TabLine",                    { bg = BlackShadeLight, fg = FgShadeDarker } },
  { "TabLineFill",                { bg = BlackShadeLight } },
  { "TabLineSel",                 { bg = BgShadeLight, fg = Fg, bold = false } },
  { "VertSplit",                  { fg = BgShadeLighter } },
  { "Visual",                     { bg = BgShadeLighter, fg = White } },
  { "MatchParen",                 { bg = "#270f2e", fg = Magenta, bold = true } },
  { "QuickFixLine",               { bg = BgShadeLighter } },
  { "NonText",                    { fg = FgShadeDarker } },
  { "markdownH1Delimiter",        { bg = none, fg = none } },
  { "markdownH2Delimiter",        { bg = none, fg = none } },
  { "markdownH3Delimiter",        { bg = none, fg = none } },
  { "markdownH4Delimiter",        { bg = none, fg = none } },
  { "markdownH5Delimiter",        { bg = none, fg = none } },
  { "markdownH6Delimiter",        { bg = none, fg = none } },
  { "Error",                      { bg = none, fg = none } }, -- causes weird paren,brace highlighting on floating windows by default
  -- health {{{2
  { "healthError",                { fg = RedShadeLighter } },
  { "healthSuccess",              { fg = Green } },
  { "healthWarning",              { fg = RedShadeLight } },
  -- 2}}}
  -- treesitter/lsp semantic tokens {{{2
  { "@lsp.type.class",            { link = "@type" } },
  { "@lsp.type.decorator",        { link = "@function" } },
  { "@lsp.type.enum",             { link = "@type" } },
  { "@lsp.type.enumMember",       { link = "@constant" } },
  { "@lsp.type.function",         { link = "@function" } },
  { "@lsp.type.interface",        { link = "@interface" } },
  { "@lsp.type.keyword",          { link = "@keyword" } },
  { "@lsp.type.macro",            { link = "@macro" } },
  { "@lsp.type.method",           { link = "@method" } },
  { "@lsp.type.namespace",        { link = "@namespace" } },
  { "@lsp.type.parameter",        { link = "@parameter" } },
  { "@lsp.type.property",         { link = "@property" } },
  { "@lsp.type.type",             { link = "@type" } },
  { "@lsp.type.typeParameter",    { link = "@type.definition" } },
  { "@lsp.type.variable",         { link = "@variable" } },
  { "@lsp.typemode.function.defaultLibrary",  { link = "@function.builtin" } },
  { "@lsp.typemode.operator.injected",  { link = "@operator" } },
  { "@lsp.typemode.string.injected",    { link = "@string" } },
  { "@lsp.typemode.variable.defaultLibrary",  { link = "@variable.builtin" } },
  { "@lsp.typemode.variable.injected",  { link = "@variable" } },
  -- 2}}}
  -- 1}}}
  -- plugins {{{1
  -- cmp {{{2
  { "CmpDocBorder",               { bg = BlackShadeLight, fg = BlackShadeLight } },
  { "CmpDocNormal",               { bg = BlackShadeLight, fg = Fg } },
  { "CmpItemKind",                { fg = BlueShadeDark } },
  { "CmpItemMenu",                { fg = FgShadeDarker } },
  { "FloatBorderAlt",             { bg = Black, fg = Black } },
  { "NormalFloatAlt",             { bg = Black, fg = Fg } },
  -- 2}}}
  -- gitsigns/fugitive {{{2
  { "DiffAdd",                    { bg = DiffAdd, fg = Green } },
  { "DiffDelete",                 { bg = DiffDelete, fg = RedShadeLighter } },
  { "GitGutterAdd",               { bg = Bg, fg = Green } },
  { "GitGutterChange",            { bg = Bg, fg = Blue } },
  { "GitGutterChangeDelete",      { bg = Bg, fg = Magenta } },
  { "GitGutterDelete",            { bg = Bg, fg = Red } },
  { "GitSignsAddInline",          { bg = DiffAdd, fg = Green, bold = false } },
  { "GitSignsDeleteInline",       { bg = DiffDelete, fg = RedShadeLighter, italic = false } },
  { "diffAdded",                  { bg = DiffAdd, fg = Green } },
  { "diffRemoved",                { bg = DiffDelete, fg = RedShadeLighter } },
  -- 2}}}
  -- lazy {{{2
  { "LazyProgressTodo",           { fg = Black } },
  -- 2}}}
  -- mason {{{2
  { "MasonHeader",                { bg = White, fg = Black } },
  { "MasonHighlightBlockBold",    { bg = BgShadeLighter, fg = White } },
  { "MasonMutedBlock",            { bg = BgShadeLighter, fg = Fg } },
  -- 2}}}
  -- telescope {{{2
  { "TelescopeBorder",            { bg = Black, fg = Black } },
  { "TelescopeMatching",          { fg = RedShadeLighter } },
  { "TelescopeNormal",            { bg = Black, fg = Fg } },
  { "TelescopePromptCounter",     { fg = FgShadeDarker } },
  { "TelescopePromptTitle",       { bg = BlackShadeLight, fg = Fg } },
  { "TelescopeSelection",         { bg = BgShadeLighter, fg = Red } },
  -- 2}}}
  -- trouble {{{2
  { "TroubleFoldIcon",            { bg = none, fg = Fg } },
  { "TroubleIndent",              { bg = none, fg = BlueShadeDark } },
  { "TroubleLocation",            { bg = none, fg = BlueShadeDark } },
  { "TroubleText",                { bg = none, fg = Fg } },
  -- 2}}}
  -- other {{{2
  { "FidgetTitle",                { fg = Magenta, blend = 0 } },
  { "FidgetTask",                 { fg = FgShadeDarker, blend = 0 } },
  { "LspReference",               { bg = BgShadeLighter, fg = "#d9d6cf", underline = false } },
  { "MiniIndentScopeSymbol",      { fg = RedShadeDarker } },
  { "SnipChoiceNode",             { bg = BgShadeLight, fg = Blue } },
  { "SnipInsertNode",             { bg = BgShadeLight, fg = Green } },
  { "StatusColSep",               { bg = BlackShadeLight, fg = BgShadeLighter } },
  { "TreesitterContext",          { bg = BlackShadeLight, italic = false } },
  -- 2}}}
  -- 1}}}
}

return M.custom
