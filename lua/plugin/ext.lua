return {
    {
        "kristijanhusak/vim-dadbod-ui",
        -- enabled = false,
        dependencies = { "tpope/vim-dadbod" },
        ft = { "sql", "plsql" },
        cmd = {
            "DB",
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        keys = "<leader>db",
        config = function()
            local g = vim.g
            g.db_ui_show_help = 0
            g.db_ui_winwidth = 60
            g.db_ui_auto_execute_table_helpers = 0
            g.db_ui_execute_on_save = 0
            g.db_ui_force_echo_notifications = 1
            g.use_nvim_notify = 1

            g.db_ui_tmp_query_location = vim.uv.cwd() .. "/db_queries"
            g.Db_ui_buffer_name_generator = function(opts)
                local id = vim.fn.strftime("%m%d-%H:%M:%S")
                if opts.table == "" then
                    return "dbquery-" .. id
                end
                return "dbquery-" .. opts.table .. "-" .. id
            end
            vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<CR>", { silent = true })
            vim.keymap.set({ "n", "v" }, "<leader>ds", "<Plug>(DBUI_ExecuteQuery)<CR>", {})
        end,
    },

    {
        "Olical/conjure",
        ft = { "clojure" },
    },
}
