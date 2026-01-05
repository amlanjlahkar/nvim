local o = vim.opt

o.confirm = true
o.undofile = true
o.swapfile = false

o.expandtab = true
o.wrap = false
o.breakindent = true
o.linebreak = true

o.number = true
o.relativenumber = true
o.inccommand = 'split'
o.scrolloff = 6
o.sidescrolloff = 6
o.pumheight = 15
o.list = true
o.listchars:append({ tab = '»·', nbsp = '+', trail = '·', extends = '', precedes = '' })
o.fillchars:append({ eob = ' ', diff = '╱' })
o.completeopt:append({ 'noselect' })
o.winborder = 'single'
o.foldmethod = 'expr'
o.virtualedit = 'block'
o.signcolumn = 'auto:1-4'
o.exrc = true
