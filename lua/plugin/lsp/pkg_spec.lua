return {
    "clangd",
    "efm",

    -- lua
    { "lua_ls", mason_id = "lua-language-server" },
    { "stylua", auto_install = false, hook_lspconfig = false },

    -- python
    { "pylsp", mason_id = "python-lsp-server", auto_install = false },
    { "ruff", hook_lspconfig = false },

    -- rust
    { "rust_analyzer", auto_install = false, hook_lspconfig = false },

    -- shell
    { "shellcheck", hook_lspconfig = false },
    { "shfmt", hook_lspconfig = false },

    -- web
    { "prettier", auto_install = false, hook_lspconfig = false },
    { "cssls", auto_install = false, mason_id = "css-lsp", hook_lspconfig = false },
    { "html", auto_install = false, mason_id = "html-lsp", hook_lspconfig = false },
    { "tsserver", auto_install = false, mason_id = "typescript-language-server", hook_lspconfig = false },
}
