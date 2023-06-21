vim.loader.enable()
vim.g.mapleader = " "

local req = require("core.utils.req")
for _, m in pairs(req("core", req("core/utils"))) do
    require(m)
end

require("lazyconf"):setup()
require("color"):try_colorscheme()
