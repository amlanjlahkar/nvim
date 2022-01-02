let g:mapleader = ' '

" handling buffers {{{
nnoremap <silent> <leader>bn <cmd>bn<CR>
nnoremap <silent> <leader>bp <cmd>bp<CR>
nnoremap <silent> <leader>bd <cmd>bd<CR>
nnoremap <silent> <leader>bu <cmd>bunload<CR>
nnoremap <silent> <leader>db <cmd>%bd\|e#\|bd#\|normal `"<CR>
"}}}

" handling windows and splits {{{
nnoremap <silent> <C-k> <cmd>wincmd k<CR>
nnoremap <silent> <C-j> <cmd>wincmd j<CR>
nnoremap <silent> <C-h> <cmd>wincmd h<CR>
nnoremap <silent> <C-l> <cmd>wincmd l<CR>

nnoremap <silent> <leader>rl <cmd>vertical resize +7<CR>
nnoremap <silent> <leader>rh <cmd>vertical resize -7<CR>
nnoremap <silent> <leader>rj <cmd>resize +7<CR>
nnoremap <silent> <leader>rk <cmd>resize -7<CR>
" }}}

" terminal related {{{
autocmd termopen * startinsert
nnoremap <silent> <leader>tn <cmd>new term://zsh<cr>
" }}}

" moving single or multiple lines made easy {{{
nnoremap <leader>j <cmd>m .+1<CR>==
nnoremap <leader>k <cmd>m .-2<CR>==
vnoremap J <cmd>m '>+1<CR>gv=gv
vnoremap K <cmd>m '<-2<CR>gv=gv
" }}}

" movements {{{
nmap <leader>, %o
nnoremap L $
nnoremap H 0
" }}}

" miscellaneous {{{
" toggle search highlighting
nnoremap <silent> <leader>n :nohlsearch<CR>

" keep the cursor centered when jumping through resutls
nnoremap n nzzzv
nnoremap N Nzzzv

" explore
nnoremap <leader>e <cmd>Lexplore<CR>
" }}}
