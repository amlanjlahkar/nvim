local map_prefix = '<leader>q'

return {
    'echasnovski/mini.pick',
    version = false,
    dependencies = { 'nvim-mini/mini.extra', version = false, opts = {} },
    -- Lazyloading has some edge cases
    lazy = false,
    opts = {
        options = {
            content_from_bottom = true,
            use_cache = false,
        },
        window = {
            -- center floating window on top
            config = function()
                local height = math.floor(0.35 * vim.o.lines)
                local width = math.floor(0.5 * vim.o.columns)
                return {
                    anchor = 'NW',
                    height = height,
                    width = width,
                    row = math.floor(0.5 * (vim.o.lines - height)),
                    col = math.floor(0.5 * (vim.o.columns - width)),
                }
            end,
        },
        mappings = {
            choose_marked = '<C-q>',
            scroll_down = '<C-j>',
            scroll_up = '<C-k>',
            toggle_info = '<C-i>',
        },
    },

    config = function(plugin)
        require('mini.pick').setup(plugin.opts)

        local function new_fd_picker(opts)
            opts.cwd = opts.cwd or vim.uv.cwd()
            opts.name = opts.name or 'Files'
            opts.extra_args = opts.extra_args or {}

            local fd_opts = {
                'fd',
                '--no-follow',
                '--hidden',
                '--exclude',
                '.git',
                '--exclude',
                '.jj',
                '--no-require-git',
                '--color=never',
            }

            fd_opts = vim.list_extend(fd_opts, opts.extra_args)

            local files = vim.schedule_wrap(function()
                MiniPick.set_picker_items_from_cli(fd_opts)
            end)
            MiniPick.start({ source = { name = opts.name, items = files, cwd = opts.cwd } })
        end

        local keymap = require('utils.keymap')
        local mapopts = keymap.new_opts

        local builtin = MiniPick.builtin
        ---@diagnostic disable-next-line: undefined-global
        local extra = MiniExtra.pickers

        keymap.nmap({
            { map_prefix .. 'h', builtin.help, mapopts('Minipick: Pick help tags') },
            { map_prefix .. ';', builtin.buffers, mapopts('MiniPick: Pick buffers') },
            { map_prefix .. 's', builtin.grep, mapopts('MiniPick: Pick grepped items') },
            { map_prefix .. 'u', builtin.resume, mapopts('MiniPick: Resume picker') },
            { map_prefix .. 'p', new_fd_picker, mapopts('Minipick: Pick files') },
            { map_prefix .. 'c', extra.git_hunks, mapopts('MiniPick: Pick unstaged hunks of current git repository') },
            {
                map_prefix .. 'p',
                function()
                    new_fd_picker({})
                end,
                mapopts('Minipick: Pick files'),
            },
            {
                map_prefix .. 'j',
                function()
                    new_fd_picker({ cwd = vim.uv.cwd(), name = 'Directories', extra_args = { '--type', 'd' } })
                end,
                mapopts('MiniPick: Pick directories'),
            },
            {
                map_prefix .. 'n',
                function()
                    new_fd_picker({ cwd = vim.fn.stdpath('config'), name = 'Neovim config' })
                end,
                mapopts('Minipick: Nvim config'),
            },
            {
                map_prefix .. 'd',
                function()
                    new_fd_picker({ cwd = os.getenv('HOME') .. '/nix-darwin', name = 'Nix config' })
                end,
                mapopts('Minipick: Nvim config'),
            },
            {
                map_prefix .. 'o',
                function()
                    extra.oldfiles({ current_dir = true })
                end,
                mapopts('MiniPick: Pick oldfiles'),
            },
            -- {
            --     map_prefix .. 'o',
            --     function()
            --         -- Capture oldfiles relative to cwd
            --         local oldfiles_iter = vim.iter(vim.v.oldfiles):map(function(item)
            --             ---@diagnostic disable-next-line: param-type-mismatch
            --             local cwd = string.gsub(vim.uv.cwd(), '(%W)', '%%%1')
            --             local idx_i, idx_j = item:find('^' .. cwd .. '/+')
            --             if idx_i == 1 then
            --                 local rpath = item:sub(idx_j + 1)
            --                 return vim.uv.fs_stat(rpath) and rpath
            --             end
            --         end)
            --         local oldfiles = oldfiles_iter:totable()
            --         if #oldfiles < 1 then
            --             vim.notify('No recent files found', vim.log.levels.INFO)
            --             return
            --         end
            --         MiniPick.start({ source = { name = 'Oldfiles', items = oldfiles } })
            --     end,
            --     mapopts('MiniPick: Pick oldfiles'),
            -- },
            -- {
            --     map_prefix .. 'd',
            --     function()
            --         local checker = vim.system({ 'git', 'rev-parse', '--is-inside-work-tree' }):wait()
            --         if checker.code > 0 then
            --             vim.notify('Not a git repository', vim.log.levels.ERROR)
            --             return
            --         end
            --         local status = vim.fn.systemlist({ 'git', 'status', '--porcelain=v1' })
            --         local changes = vim
            --             .iter(status)
            --             -- Remove deleted file entries
            --             :filter(function(v)
            --                 return string.match(v, '^%s*D') == nil
            --             end)
            --             :totable()
            --         if #changes == 0 then
            --             vim.notify('No changes are made (NOTE: deleted files are not listed)', vim.log.levels.INFO)
            --             return
            --         end
            --         local winid = vim.api.nvim_get_current_win()
            --         MiniPick.start({
            --             source = {
            --                 name = 'Changed Files(Git)',
            --                 items = changes,
            --                 choose = function(item)
            --                     -- TODO: This may not work always as expected
            --                     local file = string.sub(item, 4)
            --                     vim.api.nvim_win_call(winid, function()
            --                         vim.cmd('edit ' .. file)
            --                     end)
            --                     return false
            --                 end,
            --             },
            --         })
            --     end,
            --     mapopts('MiniPick: Pick changed files tracked with git'),
            -- },
        })
    end,
}
