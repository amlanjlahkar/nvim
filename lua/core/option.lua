local opt = vim.opt
local gvar = vim.g

-- options {{{
opt.mouse = "nv" -- nervous laughter
opt.confirm = true
opt.updatetime = 200
opt.clipboard = "unnamedplus"
opt.backspace = "indent,eol,start"
opt.splitbelow = true
opt.splitright = true
opt.wrap = false
opt.breakindent = true
opt.linebreak = true
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.shiftwidth = 2
opt.expandtab = true
opt.tabstop = 2
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.cursorline = true
opt.laststatus = 3
opt.showtabline = 1
opt.showmode = false
opt.signcolumn = "yes"
opt.hlsearch = false
opt.pumheight = 20
opt.pumblend = 0
opt.winblend = 0
opt.foldmethod = "marker"
opt.spelllang = "en_us"
opt.spellsuggest = { "best", 5 }
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cmdheight = 1
opt.autowrite = true
opt.list = true
opt.listchars = { tab = "»·", nbsp = "+", trail = "·", extends = "→", precedes = "←" }
opt.fillchars:append {
  eob = " ",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
}
opt.completeopt = { "menu", "menuone", "noselect" }
opt.browsedir = "buffer"
opt.virtualedit = "block"
opt.grepprg = "rg --hidden --vimgrep --smart-case --"
-- italic font support for vim inside of tmux
vim.cmd([[
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
]])
-- }}}

-- disable unnecessary nvim builtin plugins/providers {{{
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
-- gvar.loaded_matchparen = 1
gvar.loaded_spec = 1
gvar.loaded_logiPat = 1
gvar.loaded_rrhelper = 1

gvar.loaded_netrw = 1
gvar.loaded_netrwPlugin = 1
gvar.loaded_netrwSettings = 1

gvar.loaded_ruby_provider = 0
gvar.loaded_node_provider = 0
gvar.loaded_perl_provider = 0
gvar.loaded_python3_provider = 0
-- }}}