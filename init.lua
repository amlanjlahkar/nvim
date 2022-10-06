-- importing
require("amlan.general")
require("modules.statusline")

-- plugins
require("plugins")
local fn = vim.fn
local compiled_obj = fn.stdpath("config") .. "/lua/plugins/packer_compiled.lua"
if fn.empty(fn.glob(compiled_obj)) ~= 1 then
  require("plugins.packer_compiled")
end
