return {
    "clangd",
    "efm",
    "zls",
    "tinymist",
    -- "sqls",
    { "jsonnet_ls", auto_install = false },

    -- lua
    { "lua_ls", mason_id = "lua-language-server" },
    { "stylua", auto_install = true, hook_lspconfig = false },

    -- python
    { "pylsp", mason_id = "python-lsp-server", auto_install = false },
    { "ruff", hook_lspconfig = false, auto_install = false },

    -- rust
    { "rust_analyzer", auto_install = false, hook_lspconfig = true },

    -- shell
    { "shellcheck", hook_lspconfig = false },
    { "shfmt", hook_lspconfig = false },

    -- web
    { "cssls", auto_install = false, mason_id = "css-lsp", hook_lspconfig = true },
    { "html", auto_install = false, mason_id = "html-lsp", hook_lspconfig = true },
    { "ts_ls", auto_install = false, mason_id = "typescript-language-server", hook_lspconfig = true },
    { "phpactor", auto_install = false },
}
