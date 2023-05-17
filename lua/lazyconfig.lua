function _G.LAZYLOAD(plugin_name)
  require("lazy").load({ plugins = plugin_name })
end

local M = {
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
  },
}

function M.lazymaps()
  local key = require("core.utils.map")
  local cmd, opts = key.cmd, key.new_opts

  key.nmap({
    { "<leader>ps", cmd("Lazy"), opts("Lazy: Home") },
    { "<leader>py", cmd("Lazy sync"), opts("Lazy: Sync") },
    { "<leader>pi", cmd("Lazy install"), opts("Lazy: Install missing plugins") },
    { "<leader>pp", cmd("Lazy profile"), opts("Lazy: Show profiling info") },
  })
end

function M:setup()
  require("lazy").setup("plugin", self.lazyopts)
  self.lazymaps()
end

return M
