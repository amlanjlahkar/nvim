local impatient_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/impatient.nvim"
if vim.fn.empty(vim.fn.glob(impatient_path)) > 0 then
  vim.notify("Pulling impatient.nvim...", vim.log.levels.INFO)
  vim.api.nvim_exec(
    string.format("silent !git clone --depth 1 https://github.com/lewis6991/impatient.nvim %s", impatient_path),
    false
  )
end

require("impatient").enable_profile()
require("core.option")
require("core.autocmd")
require("core.keymap")
require("core.extension.statusline")
