local is_available, harpoon = pcall(require, "harpoon")
local wk = require("which-key")
if not is_available then
  return
end

wk.register({
  h = {
    name = "Harpoon",
    m = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', "Toggle quick menu" },
    a = { '<cmd>lua require("harpoon.mark").add_file()<CR>', "Add files into quick menu" },
  },
}, { prefix = "<leader>" })
