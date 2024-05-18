--[[
Background
    Shades:
        - Lighter: default bg for emphasizing elements on floating windows
        - Light: reserved(Cursorline)
        - Dark: default bg for floating windows
]]
local Bg = "#0f0f10"
local BgShadeLighter = "#211c1d"
local BgShadeLight = "#201c1c"
local BgShadeDark = "#141415"

--[[
Foreground
    Shades:
        - Light: Default fg for important elements
        - Dark: Default fg for less important elements
]]
local Fg = "#726464"
local FgShadeLight = "#a99697"
local FgShadeDark = "#51494a"

--[[
Indicator
Red (default fg for selections/matches/warnings etc.)
    Shades:
        - Light: Foreground complement to normal Red
        - Dark: More distinct alternative to FgShadeDark
]]
local Red = "#d19299"
local RedShadeLight = "#e4627e"
local RedShadeDark = "#473234"

-- Misc
local Green = "#63b0b0"
local Blue = "#a9d1df"
local Magenta = "#d5a8e3"
local Cyan = "#849da2"

-- Diffs
local DiffAddBg = "#0c1d0e"
local DiffAddFg = "#2f7373"
local DiffDeleteBg = "#2a080f"
local DiffDeleteFg = "#a6334c"

local none = "NONE"

local M = {}
--stylua: ignore
M.custom = {
  -- statusline {{{1
  { "StatusLine",                 { bg = BgShadeDark, fg = FgShadeDark } },
  { "StatusLineDiagnosticError",  { bg = BgShadeDark, fg = "#fe697d" } },
  { "StatusLineDiagnosticHint",   { bg = BgShadeDark, fg = "#694347" } },
  { "StatusLineDiagnosticInfo",   { bg = BgShadeDark, fg = "#e4dcec" } },
  { "StatusLineDiagnosticWarn",   { bg = BgShadeDark, fg = "#dfb8bc" } },
  { "StatusLineImp",              { bg = BgShadeDark, fg = FgShadeLight } },
  { "StatusLineInd",              { bg = BgShadeDark, fg = Red } },
  { "StatusLineNC",               { bg = BgShadeDark, fg = Fg } },
  -- 1}}}
  -- native {{{1
  { "WinBar",                     { bg = Bg } },
  { "WinBarNC",                   { bg = Bg } },
  { "LineNr",                     { bg = Bg, fg = RedShadeDark } },
  { "CursorLine",                 { bg = BgShadeLight } },
  { "CursorLineNr",               { bg = Bg, fg = FgShadeLight, bold = false } },
  { "SignColumn",                 { bg = Bg } },
  { "NormalFloat",                { bg = BgShadeDark, fg = Fg } },
  { "FloatBorder",                { bg = BgShadeDark, fg = BgShadeDark } },
  { "FloatTitle",                 { bg = BgShadeLighter, fg = Fg, underline = true } },
  { "Pmenu",                      { bg = BgShadeDark , fg = Fg } },
  { "PmenuSbar",                  { bg = BgShadeLighter  } },
  { "PmenuSel",                   { bg = BgShadeLighter, fg = Red } },
  { "PmenuThumb",                 { bg = RedShadeDark } },
  { "TabLine",                    { bg = BgShadeDark, fg = FgShadeDark, bold = true } },
  { "TabLineFill",                { bg = BgShadeDark } },
  { "TabLineSel",                 { bg = Bg, fg = FgShadeLight, bold = true } },
  { "Visual",                     { bg = BgShadeLighter, fg = FgShadeLight } },
  { "MatchParen",                 { bg = "#351a3d", fg = Magenta, bold = true } },
  { "NonText",                    { fg = FgShadeDark } },
  { "Comment",                    { bg = none, fg = "#9a666d", italic = true } },
  { "MoreMsg",                    { fg = Green, bold = true } },
  { "Error",                      { bg = none, fg = none } }, -- causes weird paren,brace highlighting on floating windows by default
    -- quickfix list {{{2
  { "QuickFixLine",               { bg = BgShadeLighter } },
  { "qfLineNr",                   { fg = FgShadeLight } },
    -- }}}
  -- health {{{2
  { "healthError",                { fg = RedShadeLight } },
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
    -- markdown {{{2
  { "markdownH1Delimiter",        { bg = none, fg = none } },
  { "markdownH2Delimiter",        { bg = none, fg = none } },
  { "markdownH3Delimiter",        { bg = none, fg = none } },
  { "markdownH4Delimiter",        { bg = none, fg = none } },
  { "markdownH5Delimiter",        { bg = none, fg = none } },
  { "markdownh3",                 { bg = none, fg = "#e9bfc4", bold = true } },
  { "markdownCode",               { bg = none, fg = "#714e75", bold = true, italic = true } },
    -- 2}}}
  -- 1}}}
  -- plugins {{{1
  -- cmp {{{2
  { "CmpDocBorder",               { bg = BgShadeLighter, fg = BgShadeLighter } },
  { "CmpDocNormal",               { bg = BgShadeLighter, fg = Fg } },
  { "CmpItemKind",                { fg = Cyan } },
  { "CmpItemMenu",                { fg = FgShadeDark } },
  { "CmpItemKindCopilot",         { fg = Magenta } },
  { "FloatBorderAlt",             { bg = BgShadeDark, fg = BgShadeDark } },
  { "NormalFloatAlt",             { bg = BgShadeDark, fg = Fg } },
  -- 2}}}
  -- gitsigns/fugitive {{{2
  { "DiffAdd",                    { bg = DiffAddBg, fg = DiffAddFg } },
  { "DiffDelete",                 { bg = DiffDeleteBg, fg = DiffDeleteFg } },
  { "GitSignsAdd",                { bg = Bg, fg = Green } },
  { "GitSignsChange",             { bg = Bg, fg = Blue } },
  { "GitSignsChangeDelete",       { bg = Bg, fg = Magenta } },
  { "GitSignsDelete",             { bg = Bg, fg = Red } },
  { "GitSignsAddInline",          { bg = DiffAddBg, fg = Green, bold = true } },
  { "GitSignsDeleteInline",       { bg = DiffDeleteBg, fg = RedShadeLight, bold = true } },
  { "diffAdded",                  { bg = DiffAddBg, fg = Green } },
  { "diffRemoved",                { bg = DiffDeleteBg, fg = RedShadeLight } },
  -- 2}}}
  -- lazy {{{2
  { "LazyProgressTodo",           { fg = BgShadeDark } },
  -- 2}}}
  -- mason {{{2
  { "MasonHeader",                { bg = FgShadeLight, fg = BgShadeLighter } },
  { "MasonHighlightBlockBold",    { bg = BgShadeLighter, fg = FgShadeLight } },
  { "MasonMutedBlock",            { bg = BgShadeLighter, fg = Fg } },
  -- 2}}}
  -- telescope {{{2
  { "TelescopeBorder",            { bg = BgShadeDark, fg = BgShadeDark } },
  { "TelescopeMatching",          { fg = RedShadeLight } },
  { "TelescopeNormal",            { bg = BgShadeDark, fg = Fg } },
  { "TelescopePromptCounter",     { fg = FgShadeDark } },
  { "TelescopePromptTitle",       { bg = BgShadeLighter, fg = Fg } },
  { "TelescopePromptPrefix",      { fg = Fg } },
  { "TelescopeSelection",         { bg = BgShadeLighter, fg = Red } },
  { "TelescopeSelectionCaret",    { fg = BgShadeDark } },
  -- 2}}}
  -- other {{{2
  { "FidgetTitle",                { fg = Magenta, blend = 0 } },
  { "FidgetTask",                 { fg = FgShadeDark, blend = 0 } },
  { "LspReference",               { bg = BgShadeLighter, fg = "#d9d6cf", underline = false } },
  { "MiniIndentScopeSymbol",      { fg = RedShadeDark } },
  { "SnipChoiceNode",             { bg = BgShadeLight, fg = Blue } },
  { "SnipInsertNode",             { bg = BgShadeLight, fg = Green } },
  { "StatusColSep",               { bg = BgShadeDark, fg = BgShadeLighter } },
  { "TreesitterContext",          { bg = BgShadeDark, italic = false } },

  -- 2}}}
  -- 1}}}
}

return M.custom
