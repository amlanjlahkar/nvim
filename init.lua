vim.loader.enable()
require("core.util").preq("core", { "usrcmd.lua" })
require("lazyconfig")
require("color"):try_colorscheme()
