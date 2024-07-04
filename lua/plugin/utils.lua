local key = require("utils.map")
local keyopts = key.new_opts

return {
    "nvim-lua/plenary.nvim",

    {
        "echasnovski/mini.surround",
        keys = { "s", { "S", mode = "x" } },
        config = function(plugin)
            require(plugin.name).setup({
                silent = true,
                highlight_duration = 100,
                search_method = "cover_or_next",
            })
            vim.keymap.set("x", "S", [[:lua MiniSurround.add("visual")<CR>]], { silent = true })
        end,
    },

    {
        "numToStr/Comment.nvim",
        enabled = false,
        keys = { "gc", "gb", { "gc", mode = "x" }, { "gb", mode = { "x", "o" } } },
        config = function()
            local avail, ts_config = pcall(require, "nvim-treesitter['config']")
            if avail then
                ts_config.setup({
                    context_commentstring = {
                        enable = true,
                        enable_autocmd = false,
                    },
                })
            end
            LAZYLOAD("mini.ai")
            require("Comment").setup()
        end,
    },

    {
        "stevearc/oil.nvim",
        init = function(plugin)
            local arg = vim.fn.argv(0)
            if vim.fn.isdirectory(arg) > 0 then
                LAZYLOAD(plugin.name)
            end
        end,
        keys = { "-", "\\", "<leader>o" },
        config = function()
            require("plugin.config.oil").setup()
        end,
    },

    {
        "ThePrimeagen/harpoon",
        dependencies = "nvim-lua/plenary.nvim",
        branch = "harpoon2",
        keys = "<leader>m",
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()
            --stylua: ignore
            key.nmap({
                { "<leader>ma", function() harpoon:list():add() end },
                { "<leader>mm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
                { "<C-j>", function() harpoon:list():select(1) end },
                { "<C-k>", function() harpoon:list():select(2) end },
                { "<C-l>", function() harpoon:list():select(3) end },
                { "<C-;>", function() harpoon:list():select(4) end },
            })
        end,
    },
}
