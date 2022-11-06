-- importing
require("amlan.general")
require("color")
require("module.statusline")

-- plugins
require("plugin")
local fn = vim.fn
local compiled_obj = fn.stdpath("config") .. "/lua/plugin/packer_compiled.lua"
if fn.empty(fn.glob(compiled_obj)) ~= 1 then
  require("plugin.packer_compiled")
end
