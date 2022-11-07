local fn = vim.fn
local api = vim.api

local utils = {}

-- @param statusline Table with a single pair.
-- @field combined(boolean) Get combined or per-window width.
-- @return Width of all the nested windows combined if statusline.global is true, else width of the current window.
utils.get_width = function(window)
  local width = 0
  if window == nil or window.combined then
    for i = 1, fn.winnr("$") do
      local id = fn.win_getid(i)
      local pos = api.nvim_win_get_position(id)
      if fn.tabpagenr("$") == 1 and pos[1] ~= 0 then
        goto continue
      end
      width = width + api.nvim_win_get_width(id)
      ::continue::
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
