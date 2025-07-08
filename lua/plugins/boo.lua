return {
    'rockerBOO/boo-colorscheme-nvim',
    priority = 1000,
    lazy = true,
    config = function()
        vim.g.boo_colorscheme_italic = false
        vim.g.boo_colorscheme_theme = 'boo'
    end,
}
