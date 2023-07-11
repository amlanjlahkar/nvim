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
        "cbochs/grapple.nvim",
        enabled = false,
        --NOTE: experimental
        init = function(plugin)
            ---@diagnostic disable-next-line: param-type-mismatch
            local cwd = string.match(vim.loop.cwd(), "/([.%w_%-]+)$")
            local grapple_data = vim.fn.finddir(vim.fn.stdpath("data") .. "/grapple")
            if grapple_data then
                local file = io.popen(string.format("ls -pa %s | rg -v /", grapple_data), "r")
                if file then
                    for f in file:lines() do
                        if string.match(f, cwd) then
                            LAZYLOAD(plugin.name)
                            break
                        end
                    end
                    file:close()
                end
            end
        end,
        keys = { "<leader>mm", "<leader>ma" },
        config = function()
            local g = require("grapple")
            key.nmap({
                { "<leader>ma", g.toggle },
                { "<leader>mm", g.popup_tags },
                { "<leader>]", g.cycle_forward },
                { "<leader>[", g.cycle_backward },
            })
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

    {
        "notomo/cmdbuf.nvim",
        keys = { "q:", "q/", "q?", "ql", { "<C-f>", mode = "c" } },
        config = function()
            local cwh = vim.o.cmdwinheight
            local api = vim.api
            local cb = require("cmdbuf")

            --stylua: ignore start
            key.nmap({
                { "q:", function() cb.split_open(cwh) end },
                ---@diagnostic disable: assign-type-mismatch
                { "q/", function() cb.split_open(cwh, { type = "vim/search/forward" }) end },
                { "q?", function() cb.split_open(cwh, { type = "vim/search/backward" }) end },
                { "ql", function() cb.split_open(cwh, { type = "lua/cmd" }) end, key.new_opts(key.nowait) },
            })
            key.cmap({
                "<C-f>", function()
                    local close_key = api.nvim_replace_termcodes("<C-c>", true, false, true)
                    cb.split_open(cwh, { line = vim.fn.getcmdline(), column = vim.fn.getcmdpos() })
                    api.nvim_feedkeys(close_key, "n", false)
                end,
            })
            --stylua: ignore end

            api.nvim_create_autocmd("User", {
                desc = "Custom settings for cmdbuf window",
                group = api.nvim_create_augroup("cmdbuf_setting", { clear = true }),
                pattern = "CmdbufNew",
                callback = function(self)
                    vim.o.bufhidden = "wipe"
                    vim.keymap.set("n", "q", ":bwipe<CR>", { silent = true, nowait = true, buffer = self.buf })
                    vim.keymap.set(
                        "n",
                        "dd",
                        [[<cmd>lua require('cmdbuf').delete()<CR>]],
                        { silent = true, buffer = self.buf }
                    )
                end,
            })
        end,
    },
}
