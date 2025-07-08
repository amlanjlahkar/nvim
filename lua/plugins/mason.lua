_G.MASON_DIR = vim.fn.stdpath('data') .. '/mason'

if vim.uv.fs_stat(MASON_DIR) then
    vim.env.PATH = string.format('%s:%s', MASON_DIR .. '/bin', vim.env.PATH)
end

return {
    'mason-org/mason.nvim',
    cmd = { 'Mason' },
    opts = {
        install_root_dir = MASON_DIR,
        PATH = 'skip',
    },
}
