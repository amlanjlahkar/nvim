return {
    "clangd",
    "efm",
    { "cssls", mason_id = "css-lsp" },
    { "html", mason_id = "html-lsp" },
    { "lua_ls", mason_id = "lua-language-server" },
    { "prettier", hook_lspconfig = false },
    { "rust_analyzer", auto_install = false, hook_lspconfig = false },
    { "shellcheck", hook_lspconfig = false },
    { "shfmt", hook_lspconfig = false },
    { "stylua", auto_install = false, hook_lspconfig = false },
    { "tsserver", mason_id = "typescript-language-server", hook_lspconfig = true },
}
