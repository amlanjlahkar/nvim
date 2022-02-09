-- importing
require('config/options')
require('config/keymaps')
require('modules/statusline')
require('colorscheme')

-- plugins
local is_available, _ = pcall(require, "impatient")
if is_available then
    require('impatient') -- must be loaded before any lua modules
end
require('packer/plugins')
local compiled_obj = vim.fn.stdpath('config') .. '/lua/packer/packer_compiled.lua'
if vim.fn.exists(compiled_obj) then
    require('packer/packer_compiled')
end
