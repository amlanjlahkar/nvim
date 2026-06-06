local o = vim.opt

o.exrc = true
o.updatetime = 500
o.confirm = true
o.undofile = true
o.swapfile = false

o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.wrap = false
o.breakindent = true
o.linebreak = true

o.hlsearch = false
o.ignorecase = true
o.smartcase = true

o.number = true
o.relativenumber = true
o.scrolloff = 6
o.sidescrolloff = 6
o.pumheight = 15
o.winborder = 'solid'
o.signcolumn = 'auto:1-4'
o.inccommand = 'split'
o.virtualedit = 'block'
o.foldmethod = 'expr'

o.list = true
o.listchars:append({ tab = '»·', nbsp = '+', trail = '·', extends = '', precedes = '' })
o.fillchars:append({ eob = ' ', diff = '╱' })

o.spelllang = { 'en' }
o.dictionary:append({ '/usr/share/dict/words' })

o.completeopt:append({ 'noselect' })

o.termguicolors = true
