return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        lazy = false,

        opts = {
            ensure_installed = {
                "bash",
                "c",
                "comment",
                "cpp",
                "css",
                "html",
                "javascript",
                "lua",
                "luap",
                "make",
                "markdown",
                "vimdoc",
            },
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "<C-n>",
                    node_decremental = "<C-p>",
                },
            },
        },

        config = function(_, opts)
            local ts_install = require("nvim-treesitter.install")
            local parsers = require("nvim-treesitter.parsers")
            local parser_config = parsers.get_parser_configs()

            ts_install.compilers = { "zig", "gcc" }
            ts_install.update({ with_sync = false })

            parser_config.bash.filetype_to_parsename = "sh"
            -- local augroup = vim.api.nvim_create_augroup("_plug.treesitter", { clear = true })
            -- vim.api.nvim_create_autocmd("FileType", {
            --   group = augroup,
            --   pattern = table.concat(
            --     vim.tbl_map(function(ft)
            --       return parser_config[ft].filetype or ft
            --     end, parsers.available_parsers()),
            --     ","
            --   ),
            --   command = "setl fdm=expr fde=nvim_treesitter#foldexpr()",
            -- })

            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        keys = { "c", "d", "v", "y" },
        opts = {
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@conditional.outer",
                    ["ic"] = "@conditional.inner",
                    ["ao"] = "@loop.outer",
                    ["io"] = "@loop.inner",
                },
                include_surrounding_whitespace = true,
            },
            lsp_interop = {
                enable = true,
                border = "single",
                floating_preview_opts = {},
                peek_definition_code = {
                    ["<leader>df"] = "@function.outer",
                },
            },
        },
        config = function(_, opts)
            if package.loaded["nvim-treesitter"] then
                require("nvim-treesitter.configs").setup({ textobjects = opts })
            end
        end,
    },

    {
        "windwp/nvim-ts-autotag",
        ft = { "html", "markdown", "javascriptreact" },
        config = true,
    },
}
