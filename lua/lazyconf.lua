function _G.LAZYLOAD(plugin_name)
    require("lazy").load({ plugins = plugin_name })
end

local function init_lazy(path)
    path = path or vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(path) then
        vim.notify("Installing lazy and corresponding plugins...", vim.log.levels.INFO)
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--branch=stable",
            "https://github.com/folke/lazy.nvim.git",
            path,
        })
    end
    vim.opt.rtp:prepend(path)
end

local conf = {
    lazyopts = {
        defaults = { lazy = true },
        lockfile = vim.fn.stdpath("config") .. "/lazylock.json",
        checker = {
            enabled = false,
            concurrency = nil,
            notify = false,
        },
        change_detection = {
            enabled = true,
            notify = false,
        },
        dev = {
            path = "~/projects/nvim_plugins/",
            fallback = false,
        },
        ui = {
            border = "single",
            pills = false,
            wrap = false,
            size = { width = 0.6, height = 0.8 },
            custom_keys = {
                ["<localleader>l"] = false,
                ["<localleader>t"] = false,
            },
        },
        install = { colorscheme = { require("color").custom, require("color").default } },
    },
}

function conf:setup()
    init_lazy()
    require("lazy").setup("plugin", self.lazyopts)
end

return conf
