local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("plugin.telescope.function").pick("telescope.builtin")
local githist = require("utils.githist")

local M = {}

---File picker using telescope
---@param cwd? string Path to git repository
---@param pattern? string Regex to search for in file history
function M.pick_files(cwd, pattern)
    cwd = cwd and vim.fs.normalize(cwd) or vim.uv.cwd()
    if githist.is_gitrepo(cwd) then
        local files = {}
        builtin.git_files(_, {
            prompt_title = "Choose file",
            cwd = cwd,
            attach_mappings = function(id)
                local picker = action_state.get_current_picker(id)
                actions.select_default:replace(function()
                    local selections = picker:get_multi_selection()
                    if #selections < 1 then
                        table.insert(files, action_state.get_selected_entry()["value"])
                    else
                        for _, item in ipairs(selections) do
                            table.insert(files, item[1])
                        end
                    end
                    actions.close(id)
                    if not pattern then
                        vim.ui.input({ prompt = "Search pattern: " }, function(input)
                            pattern = input
                        end)
                    end
                    if #pattern <= 2 then
                        vim.api.nvim_feedkeys(":", "nx", true)
                        vim.notify("Pattern string must be at least 3 characters long!", 4)
                        return
                    end
                    githist.setqf(cwd, pattern, files)
                end)
                return true
            end,
        })
    end
end

return M
