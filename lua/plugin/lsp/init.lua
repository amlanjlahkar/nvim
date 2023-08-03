local pkg_bin_dir = vim.fn.stdpath("data") .. "/lsp_utils/bin"
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

local is_accessible = vim.loop.fs_access(pkg_bin_dir, "R")
local schedule_pkg_install = function(pkg_spec)
    return require("plugin.lsp.installer").schedule_install(pkg_spec)
end

return {
    {
        "williamboman/mason.nvim",
        init = function(plugin)
            if not is_accessible then
                LAZYLOAD(plugin.name)
                schedule_pkg_install()
            end
        end,
        cmd = "Mason",
        opts = {
            install_root_dir = vim.fn.fnamemodify(pkg_bin_dir, ":h"),
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
        init = function(plugin)
            if is_accessible then
                LAZYLOAD(plugin.name)
            end
        end,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local function hook_lspconfig(pkg)
                if type(pkg.hook_lspconfig) == "boolean" then
                    return pkg.hook_lspconfig
                end
                return true
            end

            vim.env.PATH = string.format("%s:%s", pkg_bin_dir, vim.env.PATH)
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
