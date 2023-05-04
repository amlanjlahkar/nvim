local fn = vim.fn
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local Path = require("plenary.path")
local Scan = require("plenary.scandir")

local M = {}

function M.gen_finder(cwd, only_dirs)
  local arg = {}
  if type(only_dirs) == "boolean" then
    arg.only_dirs = only_dirs
  elseif type(only_dirs) == "function" then
    arg.only_dirs = only_dirs()
  end
  return finders.new_table({
    results = Scan.scan_dir(cwd, { only_dirs = arg.only_dirs }),
    entry_maker = function(entry)
      return {
        value = entry,
        ordinal = entry,
        display = fn.fnamemodify(entry, ":t"),
        path = cwd,
      }
    end,
  })
end

--stylua: ignore
---TODO: previewer support
function M:pick(group_dirs, opts)
  opts = opts or {}
  local cwd = opts.cwd and Path:new(opts.cwd) or Path:new(os.getenv("HOME") .. "/media/pictures")
  local cwd_path = cwd:absolute()
  local selection = function(opt)
    opt = opt or nil
    return action_state.get_selected_entry()[opt]
  end
  pickers.new(opts, {
    prompt_title = "Set Wallpaper",
    finder = self.gen_finder(cwd_path, group_dirs),
    sorter = conf.file_sorter(opts),
    attach_mappings = function(id, map)
      local current_picker = action_state.get_current_picker(id)
      actions.select_default:replace(function()
        local chosen = selection("value")
        if cwd:new(chosen):is_dir() then
          current_picker:refresh(self.gen_finder(chosen, false), { reset_prompt = true })
        else
          fn.system("xwallpaper --zoom " .. chosen)
        end
      end)
      map("i", "<C-o>", function()
        local parents = Path:new(selection("value")):parents()
        if parents[1] ~= cwd_path then
          current_picker:refresh(self.gen_finder(parents[2], false), { reset_prompt = true })
        end
      end)
      return true
    end,
  }):find()
end

return M
