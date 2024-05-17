return {
    {
        "rockerBOO/boo-colorscheme-nvim",
        name = "boo",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.boo_colorscheme_italic = false
            vim.g.boo_colorscheme_theme = "crimson_moonlight"
        end,
    },
}
