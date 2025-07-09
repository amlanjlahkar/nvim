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
    end,
}
