local is_available, null_ls = pcall(require, "null-ls")
if not is_available then return end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  sources = {
    formatting.black,
    formatting.prettier,
    formatting.stylua,
    formatting.phpcbf.with { command = "./vendor/bin/phpcbf" },
    formatting.shfmt.with {
      extra_args = { "-i", "2", "-ci", "-bn" },
      extra_filetypes = { "bash" },
    },
    diagnostics.shellcheck.with {
      extra_filetypes = { "sh" },
    },
  },
}

vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format {
    filter = function(client)
      return client.name == "null-ls"
    end,
    timeout_ms = 2000,
  }
end, { silent = true, noremap = true, desc = "Format buffer" })
