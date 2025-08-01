local set_hl = vim.api.nvim_set_hl

return {
    'rockerBOO/boo-colorscheme-nvim',
    priority = 1000,
    config = function()
        vim.g.boo_colorscheme_italic = false
        vim.g.boo_colorscheme_theme = 'boo'

        vim.cmd.colorscheme('boo')

        -- Highlight group overrides
        set_hl(0, 'WinSeparator', { fg = '#222827' })
        set_hl(0, 'StatusLine', { fg = '#63b0b0' })
        set_hl(0, 'StatusLineNC', { fg = '#654a96' })
    end,
}
