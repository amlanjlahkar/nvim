augroup format_c
  autocmd!
  autocmd BufWritePre *.c undojoin | Neoformat clangformat
augroup END
