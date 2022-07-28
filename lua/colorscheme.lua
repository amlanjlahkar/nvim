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
    hi VertSplit       guifg='#524f67'
    hi StatusLineNC    guibg='NONE'
    hi StatusLine      guibg='NONE' guifg='#908caa'
    hi TabLineFill     guibg='NONE'
    hi TabLineNorm     guibg='NONE' guifg='#908caa'
    hi TabLineSel      guibg='#26233a' guifg='#e0def4'
    hi MatchParen      guibg='NONE' guifg='#eb6f92' gui=Bold
    hi Pmenu           guifg='#908caa'
    hi PmenuSbar       guibg='#26233a'
    hi PmenuSel        guibg='#403d52' guifg='#e0def4'
    hi PmenuThumb      guibg='#e0def4'
  endif
]]
