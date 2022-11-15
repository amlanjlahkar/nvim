local builtin = require("telescope.builtin")
local fn = require("config.telescope.function")
local key = require("core.keymap.maputil")
local cmd, opts = key.cmd, key.new_opts

key.nmap({
  {
    "<leader>tt",
    function()
      builtin.find_files({ layout_strategy = "vertical" })
    end,
    opts("Telescope: Find files"),
  },

  {
    "<leader>tb",
    function()
      builtin.buffers({ layout_strategy = "vertical" })
    end,
    opts("Telescope: Loaded buffers"),
  },

  {
    "<leader>tc",
    function()
      builtin.colorscheme({ layout_strategy = "vertical" })
    end,
    opts("Telescope: Colorschemes"),
  },

  {
    "<leader>tg",
    function()
      builtin.live_grep()
    end,
    opts("Telescope: Live grep"),
  },

  {
    "<leader>th",
    function()
      builtin.help_tags()
    end,
    opts("Telescope: Help tags"),
  },

  {
    "<leader>tn",
    function()
      fn:get_nvim_conf()
    end,
    opts("Telescope: Nvim config"),
  },

  {
    "<leader>tf",
    function()
      fn:get_relative_file()
    end,
    opts("Telescope: Buffer relative files"),
  },

  {
    "<leader>td",
    function()
      fn:get_dwots()
    end,
    opts("Telescope: Dwots"),
  },
})
