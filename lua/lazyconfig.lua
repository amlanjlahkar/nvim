local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.notify("Installing lazy and corresponding plugins, please wait...", vim.log.levels.INFO)
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
  performance = {
    rtp = {
      reset = true,
    },
  },
  ui = {
    wrap = false,
    size = { width = 0.6, height = 0.8 },
    border = "none",
    throttle = 20,
    custom_keys = {
      ["<localleader>l"] = false,
      ["<localleader>t"] = false,
    },
  },
  install = { colorscheme = { require("color").custom, require("color").default } },
})

local key = require("core.utils.map")
local cmd, opts = key.cmd, key.new_opts

key.nmap({
  { "<leader>ps", cmd("Lazy"), opts("Lazy: Home") },
  { "<leader>py", cmd("Lazy sync"), opts("Lazy: Sync") },
  { "<leader>pi", cmd("Lazy install"), opts("Lazy: Install missing plugins") },
  { "<leader>pp", cmd("Lazy profile"), opts("Lazy: Show profiling info") },
})
