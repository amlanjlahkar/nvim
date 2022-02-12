function! has_colorscheme#SetTo() abort
    try
        return g:colors_name
    catch /^Vim\%((\a\+)\)\=:E121/
        return 0
    endtry
endfunction
