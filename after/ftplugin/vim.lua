if vim.fn.bufname() == "[Command Line]" then
  vim.cmd([[
    setlocal scl=no
    setlocal norelativenumber nonumber
  ]])
end
