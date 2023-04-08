vim.loader.enable()
require("core.util").preq("core", { "usrcmd" })
require("lazyconfig")
require("color"):try_colorscheme()
