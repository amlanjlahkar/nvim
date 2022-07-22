vim.opt.background = "dark"
vim.cmd [[
  if exists('+termguicolors')
      let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
  endif
]]

vim.cmd [[
  try
    colorscheme base16-rose-pine
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
  endtry
  if (has_colorscheme#SetTo() ==# 'base16-rose-pine')
    highlight VertSplit          guifg='#524f67'
    highlight StatusLineNC       guibg='NONE'
    highlight StatusLine         guibg='NONE' guifg='#908caa'
    highlight TabLineFill        guibg='NONE'
    highlight TabLineNorm        guibg='NONE' guifg='#908caa'
    highlight TabLineSel         guibg='#26233a' guifg='#e0def4'
  endif
]]
