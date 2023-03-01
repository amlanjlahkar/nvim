local M = {}

local fn = require("plugin.telescope.function")
local tb = fn.pick("telescope.builtin")

local key = require("core.keymap.maputil")
local cmd, opts = key.cmd, key.new_opts

function M.setup()
  key.nmap({
    {
      "<leader>tt",
      function()
        tb.find_files()
      end,
      opts("Telescope: Find files"),
    },

    {
      "<leader>tb",
      function()
        tb.buffers()
      end,
      opts("Telescope: Loaded buffers"),
    },

    {
      "<leader>tc",
      function()
        tb.colorscheme()
      end,
      opts("Telescope: Colorschemes"),
    },

    {
      "<leader>tg",
      function()
        tb.live_grep(false, { layout_strategy = "horizontal", preview = true })
      end,
      opts("Telescope: Live grep"),
    },

    {
      "<leader>th",
      function()
        tb.help_tags()
      end,
      opts("Telescope: Help tags"),
    },

    {
      "<leader>tn",
      function()
        fn.get_nvim_conf()
      end,
      opts("Telescope: Nvim config"),
    },

    {
      "<leader>tf",
      function()
        fn.get_relative_file()
      end,
      opts("Telescope: Buffer relative files"),
    },

    {
      "<leader>td",
      function()
        fn.get_dwots()
      end,
      opts("Telescope: Dwots"),
    },

    {
      "<leader>tw",
      function()
        fn.set_bg()
      end,
      opts("Telescope: Set wallpaper"),
    },

    {
      "<leader>tr",
      function()
        fn.reload_module()
      end,
      opts("Telescope: Reload lua module"),
    },
  })
end

return M
