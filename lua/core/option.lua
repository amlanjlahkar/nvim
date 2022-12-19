local opt = vim.opt
local gvar = vim.g

-- options {{{
-- file handling
opt.shada = "!,'0,<0,/0,:20,f0"
opt.hidden = true
opt.confirm = true
opt.autowrite = true
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.updatetime = 100

-- indenting and wrapping
opt.autoindent = true
opt.smartindent = true
opt.shiftwidth = 2
opt.expandtab = true
opt.tabstop = 2
opt.wrap = false
opt.breakindent = true
opt.linebreak = true
opt.backspace = "indent,eol,nostop"

-- editor preference
opt.ttimeoutlen = 200
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.list = true
opt.listchars:append({ tab = "»·", nbsp = "+", trail = "·", extends = "", precedes = "" })
opt.virtualedit = "block"
opt.browsedir = "buffer"
opt.foldmethod = "marker"
opt.completeopt = { "menu", "menuone", "noselect" }

opt.showmode = false
opt.cursorline = true
opt.showtabline = 1
opt.cmdheight = 1
opt.laststatus = 3
opt.signcolumn = "yes"
opt.pumheight = 20
opt.pumblend = 0
opt.winblend = 0
opt.splitbelow = true
opt.splitright = true
opt.fillchars:append({
  eob = " ",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
})

opt.spelllang = "en_us"
opt.spellsuggest = { "best", 5 }
opt.grepprg = "rg --hidden --vimgrep --smart-case --"
opt.clipboard = ""
opt.mouse = "nv" -- nervous laughter
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
