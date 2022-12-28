local o = vim.opt
local gvar = vim.g

-- options {{{
-- file handling
o.shada = "!,'0,<0,/0,:20,f0"
o.hidden = true
o.confirm = true
o.autowrite = true
o.swapfile = false
o.backup = false
o.undofile = true
o.undodir = vim.fn.stdpath("data") .. "/undodir"
o.updatetime = 100

-- indenting and wrapping
o.autoindent = true
o.smartindent = true
o.shiftwidth = 2
o.expandtab = true
o.tabstop = 2
o.wrap = false
o.breakindent = true
o.linebreak = true
o.backspace = "indent,eol,nostop"

-- editor preference
o.ttimeoutlen = 200
o.number = true
o.relativenumber = true
o.numberwidth = 4
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = false
o.scrolloff = 8
o.sidescrolloff = 8
o.list = true
o.listchars:append({ tab = "»·", nbsp = "+", trail = "·", extends = "", precedes = "" })
o.virtualedit = "block"
o.browsedir = "buffer"
o.foldmethod = "marker"
o.completeopt = { "menu", "menuone", "noselect" }

o.showmode = false
o.cursorline = true
o.showtabline = 1
o.cmdheight = 1
o.laststatus = 3
o.signcolumn = "yes"
o.pumheight = 20
o.pumblend = 0
o.winblend = 0
o.splitbelow = true
o.splitright = true
o.fillchars:append({
  eob = " ",
  diff = "╱",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
})

o.spelllang = "en_us"
o.spellsuggest = { "best", 5 }
o.grepprg = "rg --hidden --vimgrep --smart-case --"
o.clipboard = ""
o.mouse = "nv" -- nervous laughter
o.termguicolors = true
-- }}}

-- disable unnecessary nvim services {{{
gvar.loaded_gzip = 1
gvar.loaded_tar = 1
gvar.loaded_zip = 1
gvar.loaded_getscript = 1
gvar.loaded_vimball = 1
gvar.loaded_tarPlugin = 1
gvar.loaded_zipPlugin = 1
gvar.loaded_getscriptPlugin = 1
gvar.loaded_vimballPlugin = 1
gvar.loaded_2html_plugin = 1
gvar.loaded_matchit = 1
gvar.loaded_matchparen = 1
gvar.loaded_spec = 1
gvar.loaded_logiPat = 1
gvar.loaded_rrhelper = 1

-- gvar.loaded_netrw = 1
-- gvar.loaded_netrwPlugin = 1
-- gvar.loaded_netrwSettings = 1

gvar.loaded_ruby_provider = 0
gvar.loaded_node_provider = 0
gvar.loaded_perl_provider = 0
gvar.loaded_python3_provider = 0
-- }}}
