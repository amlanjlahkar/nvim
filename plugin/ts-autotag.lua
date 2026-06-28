vim.pack.add({
    'https://github.com/tronikelis/ts-autotag.nvim',
})

local opts = {
    filetypes = {
        'typescript',
        'javascript',
        'typescriptreact',
        'javascriptreact',
        'html',
        'php',
        'svelte',
        'blade',
    },
    auto_rename = {
        enabled = false,
    },
}

require('ts-autotag').setup(opts)

vim.keymap.set('n', 'grn', function()
    if not require('ts-autotag').rename() then
        vim.lsp.buf.rename()
    end
end, { buf = 0, desc = 'Ts-autotag: Rename tags under cursor or fallback to lsp based renaming' })
