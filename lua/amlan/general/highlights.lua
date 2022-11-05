vim.opt.termguicolors = true
vim.opt.background = "dark"

-- stylua: ignore
local tokyo_hl_def = {
  { "StatusLine",            { bg = "NONE", fg = "#555b79" } },
  { "StatusLineNC",          { bg = "NONE" } },
  { "StatusLineImp",         { bg = "NONE", fg = "#787c99" } },
  { "StatusLineInd",         { bg = "NONE", fg = "#41a6b5" } },
  { "LineNr",                { bg = "#16161e", fg = "#555b79" } },
  { "CursorLineNr",          { bg = "#1a1b26", fg = "#787c99", bold = false } },
  { "WinBar",                { bg = "#1a1b26", fg = "#5b607f" } },
  { "WinBarNC",              { bg = "#1a1b26", fg = "#5b607f" } },
  { "VertSplit",             { fg = "#272834" } },
  { "PmenuSel",              { bg = "#2a2f41", fg = "#c0caf5" } },
  { "PmenuSbar",             { bg = "#13131b" } },
  { "PmenuThumb",            { bg = "#2a2f41" } },
  { "TabLineFill",           { bg = "NONE" } },
  { "TabLine",               { bg = "NONE", fg = "#555b79" } },
  { "TabLineSel",            { bg = "NONE", fg = "#ff9e64" } },
  { "TelescopeSelection",    { bg = "#2a2f41", fg = "#c0caf5" } },
  { "TelescopeNormal",       { bg = "#1a1b26" } },
  { "TelescopeBorder",       { bg = "#1a1b26", fg = "#1a1b26" } },
  { "TelescopeResultsTitle", { bg = "#1a1b26", fg = "#1a1b26" } },
  { "NormalFloat",           { bg = "#1a1b26", fg = "#787c99" } },
  { "FloatBorder",           { bg = "#1a1b26", fg = "#1a1b26" } },
  { "CmpItemAbbr",           { link = "NormalFloat" } },
  { "LspReference",          { bg = "#2a2f41" } },
}

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "base16-tokyo-night-terminal-dark",
  callback = function()
    for _, def in ipairs(tokyo_hl_def) do
      local hl = def[1]
      local opts = def[2]
      opts.default = false
      vim.api.nvim_set_hl(0, hl, opts)
    end
  end,
})

local try_colorscheme = function(colorscheme)
  if not pcall(vim.api.nvim_exec, "colorscheme " .. colorscheme, false) then
    vim.api.nvim_exec("colorscheme default", false)
  end
end

try_colorscheme("base16-tokyo-night-terminal-dark")
-- try_colorscheme("base16-gruvbox-material-light-soft")
