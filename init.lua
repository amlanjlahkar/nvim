require("core")
require("color")
require("plugin")

local compiled_obj = vim.fn.stdpath("config") .. "/lua/plugin/packer_compiled.lua"
if vim.fn.filereadable(compiled_obj) == 1 then
  require("plugin.packer_compiled")
end
