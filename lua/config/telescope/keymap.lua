local fn = require("config.telescope.function")
local key = require("core.keymap.maputil")
local cmd, opts = key.cmd, key.new_opts

-- stylua: ignore
key.nmap({
  { "<leader>tt",
    cmd("lua require('telescope.builtin').find_files({ layout_strategy = 'center' })"),
    opts("Telescope: Find files"),
  },
  { "<leader>tb", cmd("lua require('telescope.builtin').buffers()"),    opts("Telescope: Loaded buffers") },
  { "<leader>tg", cmd("lua require('telescope.builtin').live_grep()"),  opts("Telescope: Live grep") },
  { "<leader>th", cmd("lua require('telescope.builtin').help_tags()"),  opts("Telescope: Help tags") },
  { "<leader>tn", function() fn.get_nvim_conf() end,                    opts("Telescope: Nvim config"), },
  { "<leader>tf", function() fn.get_relative_file() end,                opts("Telescope: Buffer relative files"), },
  { "<leader>td", function() fn.get_dwots() end,                        opts("Telescope: Dwots"), },
})
