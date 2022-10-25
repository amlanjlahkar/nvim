vim.opt.termguicolors = true
vim.opt.background = "dark"

-- stylua: ignore
local tokyo_hl_def = {
  { "StatusLine",         { bg = "NONE", fg = "#555b79" } },
  { "StatusLineNC",       { bg = "NONE" } },
  { "VertSplit",          { fg = "#13131b" } },
  { "WinBar",             { bg = "NONE", fg = "#5b607f" } },
  { "TelescopeSelection", { bg = "#2a2f41", fg = "#c0caf5" } },
  { "PmenuSel",           { bg = "#2a2f41", fg = "#c0caf5" } },
  { "PmenuSbar",          { bg = "#13131b" } },
  { "PmenuThumb",         { bg = "#787c99" } },
  { "TabLineFill",        { bg = "#13131b" } },
  { "TabLine",            { bg = "#13131b" } },
  { "TabLineSel",         { bg = "#16161e" } },
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
