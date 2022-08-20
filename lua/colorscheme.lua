vim.opt.background = "dark"
vim.cmd [[
  if exists('+termguicolors')
      let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
  endif
]]

vim.cmd [[
  let g:moonflyNormalFloat = v:true
  let g:moonflyTransparent = v:true
  let g:moonflyWinSeparator = 2
  try
    colorscheme moonfly
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
  endtry
  if (has_colorscheme#SetTo() ==# 'moonfly')
    hi VertSplit       guibg='NONE'
    hi StatusLineNC    guibg='NONE'
    hi StatusLine      guibg='NONE' guifg='#b2b2b2'
    hi TabLineFill     guibg='NONE'
    hi TabLine         guibg='NONE' guifg='#9e9e9e'
    hi TabLineSel      guibg='NONE' guifg='#b2b2b2' gui='bold'
    hi CursorLineNr    guibg='NONE' guifg='#b2b2b2' gui='bold'
  endif
]]
