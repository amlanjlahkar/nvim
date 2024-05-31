LSP_USEBUN = true

local pkg_install_dir = vim.fn.stdpath("data") .. "/lsp_utils/bin"
local pkgs_exist = vim.uv.fs_access(pkg_install_dir, "R")

local parser = require("plugin.lsp.parse_spec")
local get_pkg_spec = function()
    return require("plugin.lsp.pkg_spec")
end

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Auto install required packages",
    group = vim.api.nvim_create_augroup("_lsp.mason", { clear = true }),
    pattern = vim.fn.stdpath("config") .. "/lua/plugin/lsp/pkg_spec.lua",
    callback = function()
        if not package.loaded["mason"] then
            LAZYLOAD("mason.nvim")
        end
        require("plenary.reload").reload_module("plugin.lsp.pkg_spec")
        parser.schedule_install(get_pkg_spec())
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
                parser.schedule_install(get_pkg_spec())
            end
        end,
        cmd = "Mason",
        opts = {
            install_root_dir = vim.fn.fnamemodify(pkg_install_dir, ":h"),
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
            vim.env.PATH = pkgs_exist and string.format("%s:%s", pkg_install_dir, vim.env.PATH)
        end,
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            local servers = parser:import_servers(get_pkg_spec())

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
