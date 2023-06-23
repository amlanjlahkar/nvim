return {
    {
        "clangd",
        auto_install = true,
        mason_id = true,
        hook_lspconfig = false,
    },

    {
        "html",
        auto_install = true,
        mason_id = "html-lsp",
        hook_lspconfig = true,
    },

    {
        "cssls",
        auto_install = true,
        mason_id = "css-lsp",
        hook_lspconfig = true,
    },

    {
        "lua_ls",
        auto_install = true,
        mason_id = "lua-language-server",
        hook_lspconfig = true,
    },

    {
        "rust_analyzer",
        auto_install = false,
        mason_id = "rust-analyzer",
        hook_lspconfig = false,
    },

    {
        "tsserver",
        auto_install = true,
        mason_id = "typescript-language-server",
        hook_lspconfig = false,
    },

    {
        "jsonlint",
        auto_install = true,
        mason_id = true,
    },

    {
        "prettierd",
        auto_install = true,
        mason_id = true,
    },

    {
        "shellcheck",
        auto_install = true,
        mason_id = true,
    },

    {
        "shfmt",
        auto_install = true,
        mason_id = true,
    },

    {
        "stylua",
        auto_install = false,
        mason_id = true,
    },
}

