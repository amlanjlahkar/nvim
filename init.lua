vim.loader.enable()
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.notify("Installing lazy and corresponding plugins, please wait...", vim.log.levels.INFO)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazyconfig"):setup()

require("color"):try_colorscheme()
local req = require("core.utils.req")
for _, m in pairs(req("core", req("core/utils"))) do
  require(m)
end
