local opt = vim.opt
local gvar = vim.g

opt.background = "dark"
vim.cmd [[
if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
]]

-- everforest
gvar.everforest_background = 'hard'
gvar.everforest_sign_column_background = 'none'
gvar.everforest_enable_italic = 1
gvar.everforest_diagnostic_text_highlight = 1
gvar.everforest_diagnostic_virtual_text = 'colored'
gvar.everforest_better_performance = 1
vim.cmd [[
try
    colorscheme everforest
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry
]]
