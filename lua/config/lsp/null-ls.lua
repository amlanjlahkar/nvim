local is_available, null_ls = pcall(require, "null-ls")
if not is_available then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  sources = {
    -- html, css, js, json, yaml, md
    formatting.prettier,
    -- lua
    formatting.stylua,
    -- php
    formatting.phpcbf.with { command = "./vendor/bin/phpcbf" },
    -- sh, bash
    formatting.shfmt.with {
      extra_args = { "-i", "2", "-ci", "-bn" },
      extra_filetypes = { "bash" },
    },
  },
}

vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", { silent = true, noremap = true })
