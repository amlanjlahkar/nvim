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
            {
                "Kaiser-Yang/blink-cmp-dictionary",
                dependencies = { "nvim-lua/plenary.nvim" },
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
            cmdline = { enabled = false },
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "dictionary" },
                providers = {
                    buffer = {
                        opts = {
                            get_bufnrs = function()
                                return vim.tbl_filter(function(bufnr)
                                    return vim.bo[bufnr].buftype == ""
                                end, vim.api.nvim_list_bufs())
                            end,
                        },
                    },
                    dictionary = {
                        module = "blink-cmp-dictionary",
                        name = "Dict",
                        min_keyword_length = 3,
                        max_items = 6,
                        opts = {
                            dictionary_files = { vim.fn.stdpath("config") .. "/dict/eng.txt" },
                        },
                    },
                },
            },
        },
    },
}
