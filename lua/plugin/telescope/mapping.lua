local M = {}

function M.setup()
  local builtin = require("telescope.builtin")
  local fn = require("plugin.telescope.function")
  local default = require("plugin.telescope").default

  local key = require("core.keymap.maputil")
  local cmd, opts = key.cmd, key.new_opts

  -- stylua: ignore start
  key.nmap({
    {
      "<leader>tt", function()
        builtin.find_files({ layout_strategy = default.layout_strategy })
      end, opts("Telescope: Find files"),
    },

    {
      "<leader>tb", function()
        builtin.buffers({ layout_strategy = default.layout_strategy })
      end, opts("Telescope: Loaded buffers"),
    },

    {
      "<leader>tc", function()
        builtin.colorscheme({ layout_strategy = default.layout_strategy })
      end, opts("Telescope: Colorschemes"),
    },

    {
      "<leader>tg", function()
        builtin.live_grep()
      end, opts("Telescope: Live grep"),
    },

    {
      "<leader>th", function()
        builtin.help_tags()
      end, opts("Telescope: Help tags"),
    },

    {
      "<leader>tn", function()
        fn:get_nvim_conf()
      end, opts("Telescope: Nvim config"),
    },

    {
      "<leader>tf", function()
        fn:get_relative_file()
      end, opts("Telescope: Buffer relative files"),
    },

    {
      "<leader>td", function()
        fn:get_dwots()
      end, opts("Telescope: Dwots"),
    },

    {
      "<leader>tw", function()
        fn:set_bg()
      end, opts("Telescope: Set wallpaper"),
    },

    {
      "<leader>tr", function()
        fn:reload_module()
      end, opts("Telescope: Reload lua module"),
    },
  })
  -- stylua: ignore end
end

return M
