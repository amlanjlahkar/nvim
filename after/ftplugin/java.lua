vim.cmd([[
  hi javaError guibg=NONE guifg=NONE
  hi javaError2 guibg=NONE guifg=NONE
]])

vim.cmd("compiler javac")
vim.opt_local.makeprg="javac"
