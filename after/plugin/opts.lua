local o = vim.opt

o.shada = "!,'15,<0,/0,:50,f0"
o.confirm = true
o.autowrite = true
o.undofile = true
o.undodir = vim.fn.stdpath('state') .. '/undo'

o.expandtab = true
o.wrap = false
o.breakindent = true
o.linebreak = true
o.backspace = 'indent,eol,nostop'

o.updatetime = 200
o.timeoutlen = 500
o.number = true
o.relativenumber = true
o.numberwidth = 4
o.incsearch = true
o.inccommand = 'split'
o.hlsearch = false
o.scrolloff = 6
o.sidescrolloff = 6
o.list = true
o.listchars:append({ tab = '»·', nbsp = '+', trail = '·', extends = '', precedes = '' })
o.virtualedit = 'block'
o.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert', 'popup' }
o.shortmess:append({ I = true })
o.exrc = true

o.cmdwinheight = 10
o.signcolumn = 'auto:1-4'
o.pumheight = 20
o.splitkeep = 'screen'
o.splitbelow = true
o.fillchars:append({
    eob = ' ',
    diff = '╱',
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┨',
    vertright = '┣',
    verthoriz = '╋',
    foldopen = '',
    foldclose = '',
})
o.winborder = 'single'
o.foldmethod = 'expr'
