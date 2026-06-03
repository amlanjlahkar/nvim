vim.pack.add({
    'https://github.com/rockerBOO/boo-colorscheme-nvim',
})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'boo',
    callback = function()
        local set_hl = vim.api.nvim_set_hl

        set_hl(0, 'WinSeparator', { fg = '#222827' })

        set_hl(0, 'StatusLine', { fg = '#63b0b0', bg = '#0d0d0d' })
        set_hl(0, 'StatusLineNC', { fg = '#3a3a3a', bg = '#0d0d0d' })

        set_hl(0, 'TabLine', { fg = '#3a3a3a', bg = '#0d0d0d' })
        set_hl(0, 'TabLineFill', { fg = '#3a3a3a', bg = '#0d0d0d' })
        set_hl(0, 'TabLineSel', { fg = '#9c75dd', bg = '#0d0d0d' })

        set_hl(0, 'DiagnosticError', { fg = '#7f5479' })
        set_hl(0, 'Comment', { fg = '#66919a', italic = true })

        set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#4c4c60' })
        set_hl(0, 'SpellBad', { fg = '#c0c0dd', sp = '#cd749c', undercurl = true })
    end,
})
