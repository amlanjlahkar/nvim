vim.loader.enable()
vim.g.mapleader = " "

local req = require("core.utils.req").req

local exclude = {}
for _, u in pairs(req("core/utils")) do
    table.insert(exclude, u)
end

for _, m in pairs(req("core", exclude)) do
    require(m)
end

require("lazyconf"):setup()
require("color"):try_colorscheme()
