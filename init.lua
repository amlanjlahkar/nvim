require("amlan.general")
require("color")
require("module.statusline")
require("plugin")

local compiled_obj = vim.fn.stdpath("config") .. "/lua/plugin/packer_compiled.lua"
if vim.fn.empty(vim.fn.glob(compiled_obj)) ~= 1 then
  require("plugin.packer_compiled")
end
