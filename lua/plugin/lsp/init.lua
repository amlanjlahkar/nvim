local pkg_dir = vim.fn.stdpath("data") .. "/lsp_utils"
local pkg_spec_path = vim.fn.stdpath("config") .. "/lua/plugin/lsp/pkg_spec.lua"
local pkg_spec_module = string.gsub(vim.fn.fnamemodify(pkg_spec_path, ":r"), "%S+lua/", ""):gsub("/", ".")

local augroup = vim.api.nvim_create_augroup("_Mason", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
    group = augroup,
    pattern = pkg_spec_path,
    callback = function()
        if not package.loaded["mason"] then
            LAZYLOAD("mason.nvim")
        end
    end,
})

local schedule_pkg_install = function(pkg_spec)
    return require("plugin.lsp.installer").schedule_install(pkg_spec)
end

return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            install_root_dir = pkg_dir,
            PATH = "skip",
            ui = {
                width = 0.6,
                height = 0.8,
                check_outdated_packages_on_open = false,
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            vim.api.nvim_create_autocmd("BufWritePost", {
                desc = "Auto install required packages",
                group = augroup,
                pattern = pkg_spec_path,
                callback = function()
                    require("plenary.reload").reload_module(pkg_spec_module)
                    schedule_pkg_install()
                end,
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            if not vim.loop.fs_access(pkg_dir, "R") then
                schedule_pkg_install()
                return
            end

            local function hook_lspconfig(pkg)
                if type(pkg.hook_lspconfig) == "boolean" then
                    return pkg.hook_lspconfig
                end
                return true
            end

            vim.env.PATH = pkg_dir .. "/bin:" .. vim.env.PATH
            for _, pkg in pairs(require(pkg_spec_module)) do
                local server = type(pkg) == "table" and pkg[1] or pkg
                if hook_lspconfig(pkg) then
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
        lazy = false,
        opts = function()
            local null_ls = require("null-ls")
            local format = null_ls.builtins.formatting
            local diagnose = null_ls.builtins.diagnostics
            local actions = null_ls.builtins.code_actions
            return {
                sources = {
                    actions.gitsigns,
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
