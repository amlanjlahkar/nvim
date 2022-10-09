local is_avialble, wk = pcall(require, "which-key")
if not is_avialble then return end

local margin = { 1, 0, 1, 0 }
vim.api.nvim_create_autocmd({ "VimResized", "BufEnter" }, {
  desc = "Resize which key window based on nvim_window width",
  callback = function()
    if vim.api.nvim_win_get_width(0) == 168 then
      margin[2] = 100
    else
      margin[2] = 0
    end
    return true
  end,
})

wk.setup {
  window = {
    border = "single",
    margin = margin,
    winblend = 10,
  },
  show_help = false,
  triggers = "<leader>",
}
