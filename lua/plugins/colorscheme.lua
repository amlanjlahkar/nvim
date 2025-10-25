return {
    {
        'rockerBOO/boo-colorscheme-nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.boo_colorscheme_italic = false
            vim.g.boo_colorscheme_theme = 'boo'

            vim.cmd.colorscheme('boo')

            local set_hl = vim.api.nvim_set_hl

            -- Highlight group overrides
            set_hl(0, 'WinSeparator', { fg = '#222827' })
            set_hl(0, 'StatusLine', { fg = '#63b0b0', bg = '#0d0d0d' })
            set_hl(0, 'StatusLineNC', { fg = '#3a3a3a', bg = '#0d0d0d' })
            set_hl(0, 'TabLine', { fg = '#3a3a3a', bg = '#0d0d0d' })
            set_hl(0, 'TabLineFill', { fg = '#3a3a3a', bg = '#0d0d0d' })
            set_hl(0, 'TabLineSel', { fg = '#9c75dd', bg = '#0d0d0d' })
        end,
    },
}
