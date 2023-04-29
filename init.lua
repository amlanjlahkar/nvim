vim.loader.enable()
vim.g.mapleader = " "
require("lazyconfig")
require("color"):try_colorscheme()
local req = require("core.utils.req")
for _, m in pairs(req("core", req("core/utils"))) do
  require(m)
end
