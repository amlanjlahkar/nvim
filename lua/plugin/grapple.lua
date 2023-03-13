local M = {
  "cbochs/grapple.nvim",
  lazy = false,
}

function M.config()
  local g = require("grapple")
  local key = require("core.keymap.maputil")
  local opts = key.new_opts

  key.nmap({
    { "<leader>ma", g.toggle, opts("Grapple: Toggle tag") },
    { "<leader>mm", g.popup_tags, opts("Grapple: Open tags' popup menu") },
    { "];", g.cycle_forward, opts("Grapple: Forward cycle tags") },
    { "[;", g.cycle_backward, opts("Grapple: Backward cycle tags") },
  })
end

return M
