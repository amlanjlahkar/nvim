vim.api.nvim_create_autocmd('PackChanged', {
    once = true,
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'mason.nvim' and kind == 'install' then
            if not ev.data.active then
                vim.cmd.packadd('mason.nvim')
            end
            -- Defer calling user command to prevent installation
            -- attempt of packages before loading the 'mason' module
            vim.defer_fn(function()
                vim.cmd('MasonEnsureInstalled')
            end, 2500)
        end
    end,
})

vim.pack.add({
    'https://github.com/mason-org/mason.nvim',
})

-- Make packages installed through mason available in PATH
-- regardless of mason being lazyloaded
_G.MASON_DIR = vim.fn.stdpath('data') .. '/mason'
if vim.uv.fs_stat(MASON_DIR) then
    vim.env.PATH = string.format('%s:%s', MASON_DIR .. '/bin', vim.env.PATH)
end

local opts = {
    install_root_dir = MASON_DIR,
    PATH = 'skip',
    ui = {
        backdrop = 100,
        border = false,
        check_outdated_packages_on_open = false,
    },
}

require('mason').setup(opts)
