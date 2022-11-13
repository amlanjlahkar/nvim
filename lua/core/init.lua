local is_avail, _ = pcall(require, "impatient")
if not is_avail then
  local impatient_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/impatient.nvim"
  vim.notify("Pulling impatient.nvim...", vim.log.levels.INFO)
  vim.api.nvim_exec(
  string.format("silent !git clone --depth 1 https://github.com/lewis6991/impatient.nvim %s", impatient_path),
  false
  )
end

require("core.option")
require("core.autocmd")
require("core.keymap")
require("core.extension.statusline")
require("core.extension.tabline")
