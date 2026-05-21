vim.pack.add({
    'https://github.com/echasnovski/mini.pick',
    'https://github.com/nvim-mini/mini.extra',
})

local opts = {
    options = {
        content_from_bottom = true,
        use_cache = true,
    },
    window = {
        -- center floating window on top
        config = function()
            local height = math.floor(0.5 * vim.o.lines)
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
    },
}

require('mini.pick').setup(opts)
require('mini.extra').setup()

local function new_fd_picker(picker_opts)
    picker_opts.cwd = picker_opts.cwd or vim.uv.cwd()
    picker_opts.name = picker_opts.name or 'Files'
    picker_opts.extra_args = picker_opts.extra_args or {}

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

    fd_opts = vim.list_extend(fd_opts, picker_opts.extra_args)

    local files = vim.schedule_wrap(function()
        MiniPick.set_picker_items_from_cli(fd_opts)
    end)
    MiniPick.start({ source = { name = picker_opts.name, items = files, cwd = picker_opts.cwd } })
end

local keymap = require('utils.keymap')
local mapopts = keymap.new_opts

local builtin = MiniPick.builtin
---@diagnostic disable-next-line: undefined-global
local extra = MiniExtra.pickers

local map_prefix = '<leader>q'

keymap.nmap({
    { map_prefix .. 'h', builtin.help, mapopts('Mini: Pick help tags') },
    { map_prefix .. ';', builtin.buffers, mapopts('Mini: Pick buffers') },
    { map_prefix .. 'l', builtin.grep_live, mapopts('Mini: Pick grepped items') },
    { map_prefix .. 's', builtin.grep, mapopts('Mini: Pick grepped items') },
    { map_prefix .. 'u', builtin.resume, mapopts('Mini: Resume picker') },
    { map_prefix .. 'c', extra.git_hunks, mapopts('Mini: Pick unstaged hunks of current git repository') },
    {
        map_prefix .. 'p',
        function()
            new_fd_picker({})
        end,
        mapopts('Mini: Pick files'),
    },
    {
        map_prefix .. 'j',
        function()
            new_fd_picker({ cwd = vim.uv.cwd(), name = 'Directories', extra_args = { '--type', 'd' } })
        end,
        mapopts('Mini: Pick directories in cwd'),
    },
    {
        map_prefix .. 'n',
        function()
            new_fd_picker({ cwd = vim.fn.stdpath('config'), name = 'Neovim config' })
        end,
        mapopts('Mini: Pick neovim config'),
    },
    {
        map_prefix .. 'd',
        function()
            new_fd_picker({ cwd = os.getenv('HOME') .. '/nix-darwin', name = 'Nix dotfiles' })
        end,
        mapopts('Mini: Pick dotfiles'),
    },
    {
        map_prefix .. 'o',
        function()
            extra.oldfiles({ current_dir = true })
        end,
        mapopts('Mini: Pick oldfiles'),
    },
    {
        '<leader>;s',
        function()
            extra.lsp({ scope = 'document_symbol' })
        end,
        mapopts('Mini: Pick document symbols'),
    },
})
