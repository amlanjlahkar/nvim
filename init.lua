-- importing
require('config/options')
require('config/keymaps')
require('modules/statusline')
require('colorscheme')

-- plugins
local is_available, _ = pcall(require, "impatient")
if not is_available then
    return
end
require('packer/plugins')

local fn = vim.fn
local compiled_obj = fn.stdpath('config') .. '/lua/packer/packer_compiled.lua'
if fn.empty(fn.glob(compiled_obj)) ~= 1 then
    require('packer/packer_compiled')
end
