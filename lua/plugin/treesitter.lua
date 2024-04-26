return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },

        opts = {
            ensure_installed = {
                "bash",
                "c",
                "comment",
                "css",
                "go",
                "html",
                "javascript",
                "lua",
                "luap",
                "make",
                "markdown",
                "python",
                "rust",
                "typst",
                "vimdoc",
                "zig",
            },

            auto_install = false,

            indent = {
                enable = true,
                disable = { "python" },
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

            ts_install.compilers = { "clang", "zig", "gcc" }
            ts_install.update({ with_sync = false })

            parser_config.bash.filetype_to_parsename = "sh"
            parser_config.typst.filetype_to_parsename = "typ"

            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        enabled = false,
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
        ft = { "html", "xml", "php", "markdown", "javascriptreact" },
        config = true,
    },
}
