return {
    {
        "rockerBOO/boo-colorscheme-nvim",
        name = "boo",
        priority = 1000,
        config = function()
            vim.g.boo_colorscheme_italic = false
            vim.g.boo_colorscheme_theme = "crimson_moonlight"
        end,
    },

    {
        "brenoprata10/nvim-highlight-colors",
        cmd = "HighlightColors",
        opts = {
            render = "virtual",
            exclude_filetypes = { "lazy" },
        },
    },
}
