return {
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "0.2.*",
        build = function()
            require("typst-preview").update()
        end,
    },
}
