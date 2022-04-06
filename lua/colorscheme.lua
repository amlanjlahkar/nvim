local opt = vim.opt

opt.background = "light"
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
    if (has_colorscheme#SetTo() ==# 'moonfly')
        highlight StatusLine    guibg='#191919'
        highlight StatusLineNC  guibg='#101010'
        highlight CursorLine    guibg='#191919'
        highlight CursorLineNr  guifg='#c6c6c6' guibg='NONE' gui=NONE
        highlight VertSplit     guifg='#1e1e1e' guibg='NONE'
    elseif (has_colorscheme#SetTo() ==# 'zengarden')
        highlight Visual        cterm=NONE gui=NONE
    endif
]]
