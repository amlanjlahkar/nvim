local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("plugin.telescope.function").pick("telescope.builtin")

local M = {}

function M.switch_dir(cwd)
  local _cwd
  if cwd then _cwd = cwd else _cwd = vim.loop.cwd() end
  builtin.find_files(_, {
    prompt_title = "Choose directory",
    cwd = _cwd,
    find_command = { "fd", "-H", "-E", ".git", "-t", "d" },
    attach_mappings = function(id)
      actions.select_default:replace(function()
        local chosen = action_state.get_selected_entry()["value"]
        actions.close(id)
        require("oil").open(_cwd .. "/" .. chosen)
      end)
      return true
    end,
  })
end

return M
