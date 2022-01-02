" options {{{
set hidden                                   " keep changed buffer in the background without needing to save after each modification
set confirm                                  " ask for confirmation on quiting when there are changes
set updatetime=200                           " for faster asynchronous update interval(default is 4000ms)
set clipboard=unnamedplus                    " for copying/pasting between vim and other windows(requires xclip or xsel)
set splitbelow                               " new horizontally splitted windows will open below the current window
set splitright                               " new vertically splitted windows will open right to the current window
set nowrap                                   " enable or disable line wrapping
set ignorecase                               " disable case-sensitive searching of patterns
set autoindent                               " for enabling auto indentation
set smartindent                              " for making indenting smart
set shiftwidth=4                             " decide how many spaces to insert for auto indention
set expandtab                                " treat tabs as spaces
set tabstop=4                                " decide how many spaces to convert into tabs
set encoding=UTF-8                           " setting UTF-8 encoding support
set number relativenumber                    " for displaying (hybrid)row numbers
set numberwidth=4                            " for setting the gap/width between row numbers and window edge
set cursorline                               " for highlighting the current line
set laststatus=2                             " for always displaying the statusbar at the bottom
set showtabline=1                            " for displaying of tabline at the top
set noshowmode                               " for disabling showing of different modes below the statusline(INSERT,NORMAL,V-BLOCK,REPLACE... etc.)
set signcolumn=yes                           " always display the sign column(gutter)
set nohlsearch                               " for disabling highlighting on search results
set pumheight=20                             " setting custom height for pop-up menus
set completeopt=menu,menuone,noselect        " completion menu options
" }}}

" importing {{{
source $HOME/.config/nvim/mapping.vim
lua require('impatient') -- must be sourced before any other lua modules
lua require('modules/statusline')
lua require('packer/plugins')
" }}}

" colorscheme {{{
" enable truecolor support
if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

let g:gruvbox_material_sign_column_background = 'none'
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_diagnostic_virtual_text = 'colored'
let g:gruvbox_material_enable_bold = 0
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_transparent_background = 0
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material
" }}}

" source loader code for compiled plugins by packer {{{
lua require('packer/packer_compiled')
" }}}
