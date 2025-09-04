local api = vim.api
local command = api.nvim_create_user_command

command('MasonEnsureInstalled', function()
    local pkg_list = require('mason_pkglist')
    local avail, registry = pcall(require, 'mason-registry')
    if not avail then
        return
    end
    registry.update(vim.schedule_wrap(function(success)
        assert(success, 'Unable to update mason registry')
        require('utils.mason'):install(pkg_list)
    end))
end, {
    nargs = 0,
    bang = false,
    bar = false,
    desc = 'Install mason packages from user provided pkglist',
})
