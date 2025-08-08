local map_prefix = '<leader>q'

return {
    'echasnovski/mini.pick',
    version = '*',
    cmd = { 'Pick', 'MiniPick' },
    keys = { map_prefix },
    opts = {
        options = {
            content_from_bottom = true,
            use_cache = true,
        },
    },
    config = function(plugin)
        require('mini.pick').setup(plugin.opts)

        local keymap = require('utils.keymap')
        local mapopts = keymap.new_opts

        local builtin = MiniPick.builtin

        keymap.nmap({
            { map_prefix .. 'h', builtin.help, mapopts('Minipick: Pick help tags') },
            { map_prefix .. ';', builtin.buffers, mapopts('MiniPick: Pick buffers') },
            { map_prefix .. 's', builtin.grep, mapopts('MiniPick: Pick grepped items') },
            { map_prefix .. 'u', builtin.resume, mapopts('MiniPick: Resume picker') },
            {
                map_prefix .. 'p',
                function()
                    builtin.files({ tool = 'fd' })
                end,
                mapopts('Minipick: Pick files'),
            },
            {
                map_prefix .. 'o',
                function()
                    -- Capture oldfiles relative to cwd
                    local oldfiles_iter = vim.iter(vim.v.oldfiles):map(function(item)
                        local idx_i, idx_j = item:find(vim.uv.cwd() .. '/+')
                        if idx_i == 1 then
                            local rpath = item:sub(idx_j + 1)
                            return vim.uv.fs_stat(rpath) and rpath
                        end
                    end)
                    local oldfiles = oldfiles_iter:totable()
                    if #oldfiles < 1 then
                        vim.notify('No recent files found', vim.log.levels.INFO)
                        return
                    end
                    MiniPick.start({
                        source = {
                            name = 'Oldfiles',
                            items = oldfiles,
                        },
                    })
                end,
                mapopts('MiniPick: Pick oldfiles'),
            },
        })
    end,
}
