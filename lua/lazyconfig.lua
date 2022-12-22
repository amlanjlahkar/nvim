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
  lockfile = vim.fn.stdpath("config") .. "/package_lock.json",
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
    size = { width = 0.75, height = 0.8 },
    border = "single",
    throttle = 20,
  },
  install = { colorscheme = { require("color").default } },
})
