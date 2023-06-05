function _G.LAZYLOAD(plugin_name)
  require("lazy").load({ plugins = plugin_name })
end

local function init_lazy(path)
  path = path or vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(path) then
    vim.notify("Installing lazy and corresponding plugins, please wait...", vim.log.levels.INFO)
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
    ui = {
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

function conf.lazymaps()
  local key = require("core.utils.map")
  local cmd, opts = key.cmd, key.new_opts

  key.nmap({
    { "<leader>ps", cmd("Lazy"), opts("Lazy: Home") },
    { "<leader>py", cmd("Lazy sync"), opts("Lazy: Sync") },
    { "<leader>pi", cmd("Lazy install"), opts("Lazy: Install missing plugins") },
    { "<leader>pp", cmd("Lazy profile"), opts("Lazy: Show profiling info") },
  })
end

function conf:setup()
  init_lazy()
  self.lazymaps()
  require("lazy").setup("plugin", self.lazyopts)
end

return conf
