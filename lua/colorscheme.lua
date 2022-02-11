local opt = vim.opt

opt.background = "dark"
vim.cmd [[
if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
]]

local is_available, _ = pcall(require, "kanagawa")
if is_available then
    local default_colors = require("kanagawa.colors").setup()
    local custom_hl = {
        VertSplit  = { fg = default_colors.bg_dark, bg = "NONE" },
        CursorLineNr = { fg = default_colors.fg_dark },
    }
    require'kanagawa'.setup({ overrides = custom_hl })
end

vim.cmd [[
try
    colorscheme kanagawa
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry
]]
