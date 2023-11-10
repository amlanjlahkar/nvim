local key = require("core.utils.map")
local keyopts = key.new_opts

return {
    "nvim-lua/plenary.nvim",

    {
        "zbirenbaum/copilot.lua",
        dependencies = { "zbirenbaum/copilot-cmp", main = "copilot_cmp", config = true },
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },

    {
        "echasnovski/mini.surround",
        keys = { "s", { "S", mode = "x" } },
        config = function(plugin)
            require(plugin.name).setup({
                silent = true,
                highlight_duration = 100,
                search_method = "cover_or_prev",
            })
            vim.keymap.set("x", "S", [[:lua MiniSurround.add("visual")<CR>]], { silent = true })
        end,
    },

    {
        "numToStr/Comment.nvim",
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
        keys = { "-", "<leader>o" },
        config = function()
            require("oil").setup({
                columns = { "permissions", "size", "mtime" },
                keymaps = {
                    ["gh"] = "actions.toggle_hidden",
                    ["."] = "actions.open_cmdline",
                    ["<C-y>"] = "actions.copy_entry_path",
                    ["<C-j>"] = "actions.select",
                },
                -- buf_options = { buflisted = true, bufhidden = "delete" },
                win_options = { rnu = false, nu = false },
                view_options = {
                    show_hidden = true,
                    is_always_hidden = function(name, _)
                        local pattern = { ".git", "LICENSE" }
                        return vim.tbl_contains(pattern, name) and true or false
                    end,
                },
                preview = {
                    border = "single",
                },
            })
            local entry = require("oil").get_cursor_entry
            local cwd = require("oil").get_current_dir

            key.nmap({
                {
                    "-",
                    function()
                        if vim.bo.filetype ~= "fugitive" then
                            require("oil").open()
                        end
                    end,
                    keyopts("Oil: Open parent directory"),
                },

                {
                    "<leader>ob",
                    function()
                        local path = cwd() .. entry().name
                        if entry().type == "file" then
                            vim.cmd("Git blame " .. path)
                        else
                            vim.notify(entry .. " is not a regular file!", vim.log.levels.ERROR)
                        end
                    end,
                    keyopts("Oil: View git blame for file under cursor"),
                },

                {
                    "<leader>op",
                    function()
                        local fname = entry().name
                        require("core.utils.operate").operate(cwd() .. fname, cwd(), string.format("On %s > ", fname))
                    end,
                    keyopts("Oil: Perform external operation on file under cursor"),
                },

                {
                    "<leader>os",
                    function()
                        ---@diagnostic disable-next-line: different-requires
                        require("plugin.telescope.extra.oil").switch_dir(cwd())
                    end,
                    keyopts("Oil: Fuzzy search and switch to directory"),
                },
            })
        end,
    },

    {
        "ThePrimeagen/harpoon",
        dependencies = "nvim-lua/plenary.nvim",
        keys = "<leader>m",
        init = function(plugin)
            local schema = vim.fs.find("harpoon.json", {
                type = "file",
                upward = true,
                stop = vim.fs.normalize("~/.local"),
                path = vim.fn.stdpath("data"),
            })

            if #schema < 1 then
                return
            end

            local sys = vim.fn.system
            local cwd = vim.loop.cwd()

            --stylua: ignore start
            assert(vim.fn.executable("jq") > 0, plugin.name .. " didn't load(jq isn't installed)")
            if sys(string.format("jq '.projects.\"%s\"' %s", cwd, schema[1])) ~= "null\n" and
                sys(string.format("jq '.projects.\"%s\".mark.marks == []' %s", cwd, schema[1])) == "false\n" then
                    LAZYLOAD(plugin.name)
            end
            --stylua: ignore end
        end,
        config = function()
            local ui = require("harpoon.ui")
            --stylua: ignore
            key.nmap({
                { "<leader>ma", ':lua require("harpoon.mark").add_file()<CR>' },
                { "<leader>mm", ui.toggle_quick_menu },
                { "<C-j>", function() ui.nav_file(1) end },
                { "<C-k>", function() ui.nav_file(2) end },
                { "<C-l>", function() ui.nav_file(3) end },
                { "<C-h>", function() ui.nav_file(4) end },
            })
        end,
    },
}
