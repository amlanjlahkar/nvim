return {
    {
        "echasnovski/mini.surround",
        keys = { "s", { "S", mode = "x" } },
        config = function()
            require("mini.surround").setup({
                silent = true,
                highlight_duration = 100,
                search_method = "cover_or_prev",
            })
            vim.keymap.set("x", "S", [[:lua MiniSurround.add("visual")<CR>]], { silent = true })
        end,
    },

    {
        "echasnovski/mini.ai",
        keys = { "c", "d", "y", "v" },
        dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
        opts = function()
            local ai = require("mini.ai")
            return {
                silent = true,
                n_lines = 100,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                    g = function()
                        local eol = {
                            line = vim.fn.line("$"),
                            col = math.max(vim.fn.getline("$"):len(), 1),
                        }
                        return { from = { line = 1, col = 1 }, to = eol }
                    end,
                },
            }
        end,
    },
}
