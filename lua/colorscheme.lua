local opt = vim.opt

opt.background = "dark"
vim.cmd [[
if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
]]

local kanagawa = require("kanagawa")
local default_colors = require("kanagawa.colors").setup()
local overrides = {
  VertSplit  = { fg = default_colors.bg_dark, bg = "NONE" },
}
kanagawa.setup({
  dimInactive = true,
  globalStatus = true,
  overrides = overrides,
})

vim.cmd [[
    try
        colorscheme kanagawa
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
    endtry
]]


