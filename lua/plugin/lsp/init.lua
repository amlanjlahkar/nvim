LSP_USEBUN = true

local pkg_bin_dir = vim.fn.stdpath("data") .. "/lsp_utils/bin"
local pkgs_exist = vim.uv.fs_access(pkg_bin_dir, "R")
local pkg_spec_path = vim.fn.stdpath("config") .. "/lua/plugin/lsp/pkg_spec.lua"
local pkg_spec_module = string.gsub(vim.fn.fnamemodify(pkg_spec_path, ":r"), "%S+lua/", ""):gsub("/", ".")

local schedule_pkg_install = function(pkg_spec)
    return require("plugin.lsp.installer").schedule_install(pkg_spec)
end

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Auto install required packages",
    group = vim.api.nvim_create_augroup("_lsp.mason", { clear = true }),
    pattern = pkg_spec_path,
    callback = function()
        if not package.loaded["mason"] then
            LAZYLOAD("mason.nvim")
        end
        require("plenary.reload").reload_module(pkg_spec_module)
        schedule_pkg_install()
    end,
})

-- configure diagnostics globally
local diagnostics = require("plugin.lsp.diagnostics")
diagnostics:setup_signs()
vim.diagnostic.config(diagnostics:default_opts())

return {
    {
        "williamboman/mason.nvim",
        init = function(plugin)
            if not pkgs_exist then
                LAZYLOAD(plugin.name)
                schedule_pkg_install()
            end
        end,
        cmd = "Mason",
        opts = {
            install_root_dir = vim.fn.fnamemodify(pkg_bin_dir, ":h"),
            PATH = "skip",
            ui = {
                border = "single",
                width = 0.6,
                height = 0.8,
                check_outdated_packages_on_open = false,
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        init = function()
            vim.env.PATH = pkgs_exist and string.format("%s:%s", pkg_bin_dir, vim.env.PATH)
        end,
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            local servers = require(pkg_spec_module):import_servers()
            if servers then
                for _, s in pairs(servers) do
                    local opts = require("plugin.lsp.equip_opts").setup(s)
                    require("lspconfig")[s].setup(opts)
                end
            end
            require("lspconfig.ui.windows").default_options.border = "single"
        end,
    },
}
