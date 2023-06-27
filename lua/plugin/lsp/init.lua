local schedule_install = function()
    return require("plugin.lsp.mason").schedule_install()
end

return {
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                width = 0.6,
                height = 0.8,
                check_outdated_packages_on_open = false,
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            vim.api.nvim_create_autocmd("BufWritePost", {
                desc = "Auto install packages defined in schema",
                group = vim.api.nvim_create_augroup("_Mason", { clear = true }),
                pattern = vim.fn.stdpath("config") .. "/lua/plugin/lsp/schema.lua",
                callback = function()
                    require("plenary.reload").reload_module("plugin.lsp.schema")
                    schedule_install()
                end,
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            -- { "folke/neodev.nvim", opts = { setup_jsonls = false } },
            { "j-hui/fidget.nvim", tag = "legacy", opts = { text = { spinner = "dots", done = " " } } },
        },
        config = function()
            local root = require("mason.settings").current.install_root_dir .. "/packages"
            if not vim.loop.fs_access(root, "R") then
                schedule_install()
                return
            end

            local function hook_lspconfig(entry)
                if type(entry.hook_lspconfig) == "boolean" then
                    return entry.hook_lspconfig
                end
                return true
            end

            for _, entry in pairs(require("plugin.lsp.schema")) do
                local server = type(entry) == "table" and entry[1] or entry
                if hook_lspconfig(entry) then
                    local opts = require("plugin.lsp.equip_opts").setup(server)
                    require("lspconfig")[server].setup(opts)
                end
            end
            require("lspconfig.ui.windows").default_options.border = "single"
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = "LspAttach",
        opts = function()
            local null_ls = require("null-ls")
            local format = null_ls.builtins.formatting
            local diagnose = null_ls.builtins.diagnostics
            return {
                sources = {
                    format.black,
                    format.prettierd,
                    format.stylua,
                    format.shfmt.with({
                        extra_args = { "-i", "2", "-ci", "-bn" },
                        extra_filetypes = { "bash" },
                    }),
                    format.rustfmt.with({ extra_args = { "--edition=2021" } }),

                    diagnose.shellcheck.with({
                        extra_filetypes = { "sh" },
                    }),
                    diagnose.jsonlint,
                    diagnose.eslint.with({
                        prefer_local = "node_modules/.bin",
                        condition = function(utils)
                            return utils.root_has_file({ ".eslintrc.json", ".eslintrc.js" })
                        end,
                    }),
                },
                on_attach = function(client, bufnr)
                    local default = require("plugin.lsp.def_opts")
                    if not package.loaded["lsp"] then
                        default.handlers()
                        default.on_attach(client, bufnr)
                    end
                end,
            }
        end,
    },

    { "mfussenegger/nvim-jdtls", enabled = false },

    {
        "clangd_extensions.nvim",
        url = "https://git.sr.ht/~p00f/clangd_extensions.nvim",
        ft = { "c", "cpp" },
        opts = {
            server = require("plugin.lsp.equip_opts").setup("clangd"),
            extensions = {
                autoSetHints = false,
            },
        },
    },

    {
        "jose-elias-alvarez/typescript.nvim",
        ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        opts = {
            server = require("plugin.lsp.equip_opts").setup("tsserver"),
        },
    },
}
