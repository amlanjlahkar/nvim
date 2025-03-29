vim.g.mapleader = " "
vim.g.maplocalleader = ";"

function _G.LAZYLOAD(plugin_name)
    require("lazy").load({ plugins = plugin_name })
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
    vim.notify("Installing lazy and corresponding plugins...", vim.log.levels.INFO)
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugin", {
    defaults = { lazy = true },
    rocks = { enabled = false },
    change_detection = { notify = false },
    dev = {
        path = "~/projects/nvim_plugins/",
        fallback = false,
    },
    ui = {
        border = "single",
        pills = false,
        wrap = false,
        backdrop = 60,
        size = { width = 0.7, height = 0.85 },
        custom_keys = {
            ["<localleader>l"] = false,
            ["<localleader>t"] = false,
        },
    },
    install = { colorscheme = { require("color").custom, require("color").default } },
})

require("color"):try_colorscheme()
