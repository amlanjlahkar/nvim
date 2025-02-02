return {
    {
        "saghen/blink.cmp",
        version = "v0.*",
        event = "InsertEnter",
        module = false,
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
                config = function()
                    require("plugin.completion.luasnip").setup()
                end,
            },
        },
        opts = {
            keymap = {
                preset = "default",
                ["<C-l>"] = { "select_and_accept" },
                ["<C-k>"] = { "scroll_documentation_up", "fallback" },
                ["<C-j>"] = { "scroll_documentation_down", "fallback" },
            },
            completion = {
                ghost_text = { enabled = false },
                documentation = {
                    auto_show = true,
                    window = { border = "single" },
                },
                menu = {
                    border = "single",
                    draw = {
                        treesitter = { "lsp" },
                        columns = { { "label", "label_description" }, { "kind" }, { "source_name" } },
                    },
                },
            },
            snippets = { preset = "luasnip" },
            signature = { enabled = true },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                cmdline = {},
            },
        },
    },
}
