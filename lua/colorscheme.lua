local opt = vim.opt

opt.background = "dark"
vim.cmd [[
if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
]]

-- using stock rose-pine settings
local is_available, _ = pcall(require, "rose-pine")
if is_available then
  require('rose-pine').setup({
    dark_variant = 'main',
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = false,
    disable_float_background = true,
    disable_italics = false,

    groups = {
      background = 'base',
      panel = 'surface',
      border = 'highlight_med',
      comment = 'muted',
      link = 'iris',
      punctuation = 'subtle',

      error = 'love',
      hint = 'iris',
      info = 'foam',
      warn = 'gold',

      headings = {
        h1 = 'iris',
        h2 = 'foam',
        h3 = 'rose',
        h4 = 'gold',
        h5 = 'pine',
        h6 = 'foam',
      }
    },

    highlight_groups = {
      ColorColumn = { bg = 'rose' }
    }
  })
end

vim.cmd [[
    let g:moonflyWinSeparator = 2
    let g:moonflyNormalFloat = 1
    let g:moonflyTransparent = 1
    let g:zenbones_solid_linnr = v:true
    let g:zenbones_transparent_background = v:false
    let g:zenbones_solid_float_border = v:true
    try
        colorscheme rose-pine
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
