local api = vim.api
local command = api.nvim_create_user_command

command('MasonEnsureInstalled', function()
    local pkg_list = require('mason_pkglist')
    require('utils.mason'):install(pkg_list)
end, {
    bang = false,
    bar = false,
    desc = 'Install mason packages from user provided pkglist',
})
