local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("plugin.telescope.function").pick("telescope.builtin")

local M = {}

function M.switch_dir()
  local cwd = vim.loop.cwd()
  builtin.find_files(_, {
    prompt_title = "Choose directory",
    cwd = cwd,
    find_command = { "fd", "-H", "-E", ".git",  "-t", "d" },
    attach_mappings = function(id)
      actions.select_default:replace(function()
        local chosen = action_state.get_selected_entry()["value"]
        actions.close(id)
        require("oil").open(cwd .. "/" .. chosen)
      end)
      return true
    end
  })
end

return M
