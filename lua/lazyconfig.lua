local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.notify("Installing lazy, please wait...", vim.log.levels.INFO)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

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
    notify = true,
  },
  performance = {
    rtp = {
      reset = true,
    },
  },
  ui = {
    icons = {
      loaded = " ",
      not_loaded = " ",
      list = {
        "● ",
        "➜ ",
        "➜ ",
        "➜ ",
      },
    },
    wrap = false,
    size = { width = 0.7, height = 0.9 },
    border = "single",
    throttle = 20,
  },
  install = { colorscheme = { require("color").custom, require("color").default } },
})

local key = require("core.keymap.maputil")
local cmd, opts = key.cmd, key.new_opts

key.nmap({
  { "<leader>ps", cmd("Lazy"), opts("Lazy: Home") },
  { "<leader>py", cmd("Lazy sync"), opts("Lazy: Sync") },
  { "<leader>pi", cmd("Lazy install"), opts("Lazy: Install missing plugins") },
  { "<leader>pp", cmd("Lazy profile"), opts("Lazy: Show profiling info") },
})
