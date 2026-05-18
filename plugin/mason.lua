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
