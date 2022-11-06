local palette = {
  floatbg = "#1a1b26",
  barbg = "#1a1b26",
  tabbg  = "NONE",
}

local M = {}
-- stylua: ignore
M.custom = {
  { "StatusLineNC",               { bg = palette.barbg } },
  { "StatusLine",                 { bg = palette.barbg, fg = "#555b79" } },
  { "StatusLineImp",              { bg = palette.barbg, fg = "#787c99" } },
  { "StatusLineInd",              { bg = palette.barbg, fg = "#41a6b5" } },
  { "StatusLineDiagnosticError",  { bg = "#1a1b26", fg = "#f7768e" } },
  { "StatusLineDiagnosticWarn",   { bg = "#1a1b26", fg = "#bb9af7" } },
  { "StatusLineDiagnosticHint",   { bg = "#1a1b26", fg = "#7dcfff" } },
  { "StatusLineDiagnosticInfo",   { bg = "#1a1b26", fg = "#787c99" } },
  { "LineNr",                     { bg = "NONE", fg = "#555b79" } },
  { "CursorLineNr",               { bg = palette.barbg, fg = "#787c99", bold = false } },
  { "WinBar",                     { bg = palette.barbg, fg = "#5b607f" } },
  { "WinBarNC",                   { bg = palette.barbg, fg = "#5b607f" } },
  { "VertSplit",                  { fg = "#272834" } },
  { "PmenuSel",                   { bg = "#2a2f41", fg = "#c0caf5" } },
  { "PmenuSbar",                  { bg = "#13131b" } },
  { "PmenuThumb",                 { bg = "#2a2f41" } },
  { "TabLineFill",                { bg = "NONE" } },
  { "TabLine",                    { bg = "NONE", fg = "#555b79" } },
  { "TabLineSel",                 { bg = "NONE", fg = "#ff9e64" } },
  { "TelescopeSelection",         { bg = "#2a2f41", fg = "#c0caf5" } },
  { "TelescopeNormal",            { bg = palette.floatbg } },
  { "TelescopeBorder",            { bg = palette.floatbg, fg = "#1a1b26" } },
  { "TelescopeResultsTitle",      { bg = palette.floatbg, fg = "#1a1b26" } },
  { "NormalFloat",                { bg = palette.floatbg, fg = "#787c99" } },
  { "FloatBorder",                { bg = palette.floatbg, fg = "#1a1b26" } },
  { "LspReference",               { bg = "#2a2f41" } },
  { "VimModeNormal",              { bg = "#041b4d", fg = "#7aa2f7" } },
  { "VimModeInsert",              { bg = "#16373c", fg = "#41a6b5" } },
  { "VimModeVisual",              { bg = "#521e00", fg = "#ff9e64" } },
  { "VimModeCommand",             { bg = "#1e064b", fg = "#bb9af7" } },
  { "VimModeExtra",               { bg = "#4d0412", fg = "#f7768e" } },
  { "CmpItemAbbr",                { link = "NormalFloat" } },
}

return M.custom
