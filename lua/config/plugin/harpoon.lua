local is_available, _ = pcall(require, "harpoon")
local is_wk_available, wk = pcall(require, "which-key")
if is_available == false or is_wk_available == false then
  return
end

wk.register({
  h = {
    name = "Harpoon",
    a = { '<cmd>lua require("harpoon.mark").add_file()<CR>', "Add files into quick menu" },
    n = { '<cmd>lua require("harpoon.ui").nav_next()<CR>', "Navigate to next mark" },
    p = { '<cmd>lua require("harpoon.ui").nav_prev()<CR>', "Navigate to previous mark" },
    m = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', "Toggle quick menu" },
  },
}, { prefix = "<leader>" })
