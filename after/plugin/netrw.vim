let g:netrw_banner = 0
let g:netrw_keepdir = 0
let g:netrw_winsize = 30

" custom keymaps
function! NetrwMaps()
    nmap <buffer> l <CR>
    nmap <buffer> .  gh
    nmap <buffer> <TAB> mf
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMaps()
augroup END
