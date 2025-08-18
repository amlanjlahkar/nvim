local map_prefix = '<leader>q'

return {
    'echasnovski/mini.pick',
    version = '*',
    cmd = { 'Pick', 'MiniPick' },
    keys = { map_prefix },
    opts = {
        options = {
            -- content_from_bottom = true,
            use_cache = true,
        },
        window = {
            -- center floating window on top
            config = function()
                local height = math.floor(0.45 * vim.o.lines)
                local width = math.floor(0.45 * vim.o.columns)
                return {
                    anchor = 'NW',
                    height = height,
                    width = width,
                    row = math.floor(0.5 * (vim.o.lines - 5)),
                    col = math.floor(0.5 * (vim.o.columns - width)),
                }
            end,
        },
    },
    config = function(plugin)
        require('mini.pick').setup(plugin.opts)

        local fd_opts = {
            'fd',
            '--type',
            'f',
            '--no-follow',
            '--hidden',
            '--exclude',
            '.git',
            '--exclude',
            '.jj',
            '--no-require-git',
            '--color=never',
        }

        local function new_fd_picker(cwd, name)
            cwd = cwd or vim.uv.cwd()
            name = name or 'Files'
            local files = vim.schedule_wrap(function()
                MiniPick.set_picker_items_from_cli(fd_opts)
            end)
            MiniPick.start({ source = { name = name, items = files, cwd = cwd } })
        end

        local keymap = require('utils.keymap')
        local mapopts = keymap.new_opts

        local builtin = MiniPick.builtin

        keymap.nmap({
            { map_prefix .. 'h', builtin.help, mapopts('Minipick: Pick help tags') },
            { map_prefix .. ';', builtin.buffers, mapopts('MiniPick: Pick buffers') },
            { map_prefix .. 's', builtin.grep, mapopts('MiniPick: Pick grepped items') },
            { map_prefix .. 'u', builtin.resume, mapopts('MiniPick: Resume picker') },
            { map_prefix .. 'p', new_fd_picker, mapopts('Minipick: Pick files') },
            {
                map_prefix .. 'd',
                function()
                    new_fd_picker('~/dwots_mac', 'Dotfiles')
                end,
                mapopts('Minipick: Pick dotfiles'),
            },
            {
                map_prefix .. 'n',
                function()
                    new_fd_picker(vim.fn.stdpath('config'), 'Neovim config')
                end,
                mapopts('Minipick: Nvim config'),
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
                    MiniPick.start({ source = { name = 'Oldfiles', items = oldfiles } })
                end,
                mapopts('MiniPick: Pick oldfiles'),
            },
        })
    end,
}
