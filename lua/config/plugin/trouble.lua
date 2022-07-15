local is_available, trouble = pcall(require, "trouble")
if not is_available then
  return
else
  trouble.setup {
    use_diagnostic_signs = true,
  }
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }
  map("n", "<leader>tb", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
end
