local fn = vim.fn
local api = vim.api

local utils = {}

-- @param statusline Table with a single pair.
-- @field global(boolean) Whether to consider global statusline or not('laststatus').
-- @return Width of all the nested windows combined if statusline.global is true, else width of the current window.
utils.get_width = function(statusline)
  local width = 0
  if statusline == nil or statusline.global then
    for i = 1, fn.winnr("$") do
      local id = fn.win_getid(i)
      local pos = api.nvim_win_get_position(id)
      if pos[1] ~= 0 then
        break
      end
      width = width + api.nvim_win_get_width(id)
    end
  else
    width = api.nvim_win_get_width(0)
  end
  return width
end

-- @param group Highlight group ID.
-- @param attr Attribute.
-- @return Attribute value
utils.get_hl_attr = function(group, attr)
  local color = fn.synIDattr(fn.hlID(group), attr)
  return color == "" and nil or color
end

return utils
