local M = {
  "ThePrimeagen/harpoon",
  keys = "<leader>h",
}

function M.config()
  local key = require("core.keymap.maputil")
  local opts = key.new_opts
  local cmd = key.cmd

  key.nmap({
    { "<leader>ha", cmd("lua require('harpoon.mark').add_file()"), opts("Harpoon: Add to marked queue") },
    { "<leader>hm", cmd("lua require('harpoon.ui').toggle_quick_menu()"), opts("Harpoon: Toggle quick menu") },
    { "]h", cmd("lua require('harpoon.ui').nav_next()"), opts("Harpoon: Jump to next mark") },
    { "[h", cmd("lua require('harpoon.ui').nav_prev()"), opts("Harpoon: Jump to previous mark") },
  })
end

return M
