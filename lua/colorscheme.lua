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
    let g:moonflyWinSeparator = 2
    let g:moonflyNormalFloat = 1
    let g:moonflyTransparent = 1
    try
        colorscheme moonfly
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
    endtry
    if (has_colorscheme#SetTo() ==# 'moonfly')
        highlight CursorLineNr       guifg='#c6c6c6' guibg='NONE' gui=NONE
        highlight LspReferenceText   gui=undercurl
        highlight LspReferenceRead   gui=undercurl
        highlight LspReferenceWrite  gui=undercurl
    endif
]]
