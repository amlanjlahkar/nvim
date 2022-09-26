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
    colorscheme base16-tokyo-night-terminal-dark
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
  endtry
  if (has_colorscheme#SetTo() ==# 'base16-tokyo-night-terminal-dark')
    hi StatusLineNC               guibg='NONE'
    hi StatusLine                 guibg='#13131b' guifg='#787c99'
    hi TelescopeSelection         guifg='#c0caf5'
    hi PmenuSel                   guibg='#2a2f41' guifg='#c0caf5'
    hi PmenuSbar                  guibg='#13131b'
    hi PmenuThumb                 guibg='#787c99'
    hi TabLineFill                guibg='#13131b'
    hi TabLine                    guibg='#13131b'
    hi TabLineSel                 guibg='#16161e'
    " hi IlluminatedWordText        guibg='#303a51' gui='NONE'
    " hi IlluminatedWordRead        guibg='#303a51' gui='NONE'
    " hi IlluminatedWordWrite       guibg='#303a51' gui='NONE'
    " hi VertSplit                  guifg='#13131b'
  endif
]]
