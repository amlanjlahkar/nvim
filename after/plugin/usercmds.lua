local api = vim.api
local command = api.nvim_create_user_command

command('MasonEnsureInstalled', function()
    local pkgs = require('mason_pkglist')
    require('utils.mason').install(pkgs)
end, {
    bang = false,
    bar = false,
    desc = 'Install mason packages from pkglist',
})
