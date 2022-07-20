local opt = vim.opt
local gvar = vim.g

-- options {{{
opt.hidden = true
opt.confirm = true
opt.updatetime = 200
opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true
opt.wrap = false
opt.ignorecase = true
opt.autoindent = true
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
opt.foldmethod = "marker"
opt.spelllang = "en_us"
opt.spellsuggest = { "best", 5 }
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.autowrite = true
opt.list = true
opt.listchars = { trail = "⋅", tab = "| " }
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
opt.completeopt = { "menu", "menuone", "noselect" } -- completion menu options
gvar.shfmt_opt = "-ci"
gvar.loaded_ruby_provider = 0
gvar.loaded_node_provider = 0
gvar.loaded_perl_provider = 0
gvar.loaded_python3_provider = 0
gvar.did_load_filetypes = 1
-- italic font support for vim inside of tmux
vim.cmd [[
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
]]
-- }}}

-- disable unnecessary vim builtin plugins {{{
gvar.loaded_gzip = 1
gvar.loaded_tar = 1
gvar.loaded_zip = 1
gvar.loaded_tarPlugin = 1
gvar.loaded_zipPlugin = 1
gvar.loaded_2html_plugin = 1
gvar.loaded_matchit = 1
gvar.loaded_matchparen = 1
gvar.loaded_spec = 1
-- }}}
