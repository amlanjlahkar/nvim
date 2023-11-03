return {
    "clangd",
    "efm",

    -- lua
    { "lua_ls", mason_id = "lua-language-server" },
    { "stylua", auto_install = false, hook_lspconfig = false },

    -- python
    { "pylsp", mason_id = "python-lsp-server" },
    { "ruff", hook_lspconfig = false },

    -- rust
    { "rust_analyzer", auto_install = false, hook_lspconfig = false },

    -- shell
    { "shellcheck", hook_lspconfig = false },
    { "shfmt", hook_lspconfig = false },

    -- web
    { "prettier", hook_lspconfig = false },
    { "cssls", mason_id = "css-lsp", hook_lspconfig = false },
    { "html", mason_id = "html-lsp", hook_lspconfig = false },
    { "tsserver", mason_id = "typescript-language-server", hook_lspconfig = false },
}
