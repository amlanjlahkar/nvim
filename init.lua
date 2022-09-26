-- importing
require "amlan.general"
require "modules.statusline"

-- plugins
-- create cache files for better startuptime
local is_available, _ = pcall(require, "impatient")
if not is_available then
  require "plugins"
end

require "plugins"
local fn = vim.fn
local compiled_obj = fn.stdpath "config" .. "/lua/plugins/packer_compiled.lua"
if fn.empty(fn.glob(compiled_obj)) ~= 1 then
  require "plugins/packer_compiled"
end
