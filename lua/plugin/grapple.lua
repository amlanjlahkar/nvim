local M = {
  "cbochs/grapple.nvim",
  ---Experimental
  init = function()
    local cwd = string.match(vim.loop.cwd(), "/([%w_%-]+)$")
    local grapple_data = vim.fn.stdpath("data") .. "/grapple"
    local file = io.popen(string.format("ls -pa %s | grep -v /", grapple_data), "r")
    if file then
      for f in file:lines() do
        if string.match(f, cwd) then
          require("lazy").load({ plugins = { "grapple.nvim" } })
        end
      end
      file:close()
    end
  end,
  keys = "<leader>mm",
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
