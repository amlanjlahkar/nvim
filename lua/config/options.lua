local opt = vim.opt
local gvar = vim.g

-- options {{{
opt.hidden = true                                   -- keep changed buffer in the background without needing to save after each modification
opt.confirm = true                                  -- ask for confirmation on quiting when there are changes
opt.updatetime = 200                                -- for faster asynchronous update interval(default is 4000ms)
opt.clipboard = "unnamedplus"                       -- for copying/pasting between vim and other windows(requires xclip or xsel)
opt.splitbelow = true                               -- new horizontally splitted windows will open below the current window
opt.splitright = true                               -- new vertically splitted windows will open right to the current window
opt.wrap = false                                    -- disable line wrapping
opt.ignorecase = true                               -- disable case-sensitive searching of patterns
opt.autoindent = true                               -- for enabling auto indentation
opt.smartindent = true                              -- for making indenting smart
opt.shiftwidth = 2                                  -- decide how many spaces to insert for auto indention
opt.expandtab = true                                -- treat tabs as spaces
opt.tabstop = 2                                     -- decide how many spaces to convert into tabs
opt.number = true                                   -- for displaying hybrid line numbers
opt.relativenumber = true
opt.numberwidth = 4                                 -- for setting the gap/width between row numbers and window edge
opt.cursorline = true                               -- for highlighting the current line
opt.laststatus = 2                                  -- for always displaying the statusbar at the bottom
opt.showtabline = 1                                 -- for displaying of tabline at the top
opt.showmode = false                                -- for disabling showing of different modes below the statusline(INSERT,NORMAL,V-BLOCK,REPLACE... etc.)
opt.signcolumn = "yes"                              -- always display the sign column(gutter)
opt.hlsearch = false                                -- for disabling highlighting on search results
opt.pumheight = 20                                  -- setting custom height for pop-up menus
opt.pumblend = 10                                   -- transparency for pop-up menus
opt.foldmethod = "marker"                           -- use markers(curly braces) for specifying folds
opt.spelllang = "en_us"                             -- language(s) to spellcheck for
opt.spellsuggest = { "best", 5 }                    -- method to use for spellsuggest and number of maximum suggestions to list
opt.scrolloff = 8                                   -- minimal number of lines to keep up and below when scrolling vertically
opt.sidescrolloff = 8                               -- scrolloffset but for horizontal scrolling
opt.autowrite = true
opt.list = true
opt.listchars = { trail = "⋅", tab = "| " }
opt.completeopt = { "menu", "menuone", "noselect" }     -- completion menu options
gvar.shfmt_opt = "-ci"

-- highlight on yank
vim.cmd [[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=90})
augroup END
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
