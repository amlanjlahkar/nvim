local key = require("core.utils.map")
local keyopts = key.new_opts

return {
    "nvim-lua/plenary.nvim",

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
        keys = "-",
        config = function()
            require("oil").setup({
                columns = { "permissions", "size", "mtime" },
                keymaps = {
                    ["gh"] = "actions.toggle_hidden",
                    ["."] = "actions.open_cmdline",
                    ["<C-y>"] = "actions.copy_entry_path",
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
                        require("plugin.telescope.extra.oil").switch_dir(cwd())
                    end,
                    keyopts("Oil: Fuzzy search and switch to directory"),
                },
            })
        end,
    },
}
