local extra = {}

---@class extra
---@field set_bg function Background image picker
---@param path string? Path to image directory(must be an absolute path)
function extra.set_bg(path)
  return require("plugin.telescope.extra.set_bg"):pick(path)
end

return extra
