let g:mapleader = ' '

" handling buffers {{{
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <silent> <leader>bp :bp<CR>
nnoremap <silent> <leader>bd :bd<CR>
nnoremap <silent> <leader>bu :bunload<CR>
nnoremap <silent> <leader>db :%bd\|e#\|bd#\|normal `"<CR>
"}}}

" handling windows and splits {{{
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR> 

nnoremap <silent> <leader>rl :vertical resize +7<CR>
nnoremap <silent> <leader>rh :vertical resize -7<CR>
nnoremap <silent> <leader>rj :resize +7<CR>
nnoremap <silent> <leader>rk :resize -7<CR>
" }}}

" terminal related {{{
autocmd termopen * startinsert
nnoremap <silent> <leader>tn :new term://zsh<cr>
" }}}

" moving single or multiple lines made easy {{{
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
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
