local o = vim.opt

-- file handling
o.shada = "!,'15,<0,/0,:20,f0"
o.hidden = true
o.confirm = true
o.autowrite = true
o.swapfile = false
o.backup = false
o.undofile = true
o.undodir = vim.fn.stdpath("data") .. "/undodir"
o.updatetime = 100

-- indenting and wrapping
o.autoindent = false
o.tabstop = 8
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
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
o.signcolumn = "auto:1-4"
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
o.clipboard = "unnamed"
o.mouse = "nv" -- nervous laughter
o.termguicolors = true
o.shell="/usr/local/bin/bash"
