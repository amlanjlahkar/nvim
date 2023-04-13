vim.loader.enable()
require("core.util").req("core", { "usrcmd" })
require("lazyconfig")
require("color"):try_colorscheme()
