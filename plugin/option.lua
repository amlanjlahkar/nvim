local o = vim.opt

-- file handling
o.shada = "!,'15,<0,/0,:50,f0"
o.hidden = true
o.confirm = true
o.autowrite = true
o.swapfile = false
o.backup = false
o.undofile = true
o.undodir = vim.fn.stdpath("state") .. "/undo"
o.updatetime = 200

-- indention and folds
o.autoindent = false
o.tabstop = 8
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.wrap = false
o.breakindent = true
o.linebreak = true
o.backspace = "indent,eol,nostop"
o.foldmethod = "marker"
o.foldcolumn = "1"

-- editor preference
o.timeoutlen = 500
o.ttimeoutlen = 100
o.number = true
o.relativenumber = true
o.numberwidth = 4
o.ignorecase = false
o.smartcase = false
o.incsearch = true
o.inccommand = "split"
o.hlsearch = false
o.scrolloff = 6
o.sidescrolloff = 6
o.list = true
o.listchars:append({ tab = "»·", nbsp = "+", trail = "·", extends = "", precedes = "" })
o.virtualedit = "block"
o.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup" }
o.shortmess:append({ I = true })
o.exrc = true

o.ruler = false
o.showmode = true
o.cursorline = false
o.culopt = "both"
o.showtabline = 1
o.cmdheight = 1
o.cmdwinheight = 10
o.laststatus = 3
o.winbar = " "
o.signcolumn = "auto:1-4"
o.pumheight = 20
o.pumblend = 0
o.winblend = 0
o.splitkeep = "screen"
o.splitbelow = true
-- o.splitright = true
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
    foldopen = "",
    foldclose = "",
})

o.dictionary:append(vim.fn.stdpath("config") .. "/dict/eng.txt")
o.thesaurus:append(vim.fn.stdpath("config") .. "/dict/thesaurus.txt")
o.spelllang = "en_us"
o.spellsuggest = { "best", 5 }
o.grepprg = "rg -uu --hidden --vimgrep --smart-case --"
o.dip:append("algorithm:minimal")
o.clipboard = ""
o.mouse = "nv" -- nervous laughter
o.termguicolors = true
-- o.guicursor:append("n-v-c:blinkon500-blinkoff500")

vim.g.editorconfig = true
