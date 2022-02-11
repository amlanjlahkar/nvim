local opt = vim.opt

opt.background = "dark"
vim.cmd [[
if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
]]

vim.cmd [[
try
    colorscheme moonfly
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry
]]

-- set custom highlighting
vim.cmd [[
    if has_colorscheme#colorscheme('vim-moonfly-colors')
        highlight StatusLine    guibg='#191919'
        highlight StatusLineNC  guibg='#101010'
        highlight CursorLine    guibg='#191919'
        highlight CursorLineNr  guifg='#c6c6c6' guibg='NONE' gui=bold
        highlight VertSplit     guifg='#1e1e1e' guibg='NONE'
    endif
]]

