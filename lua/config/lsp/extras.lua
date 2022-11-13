local is_avail_mason, mason = pcall(require, "mason")
local is_avail_trouble, trouble = pcall(require, "trouble")
if is_avail_mason == false or is_avail_trouble == false then
  return
end

local mason_setup = {
  ui = {
    border = "single",
    icons = {
      package_installed = " ",
      package_pending = "勒",
      package_uninstalled = " ",
    },
  },
}

local trouble_setup = {
  icons = true,
  fold_open = "",
  fold_closed = "",
  indent_lines = false,
  use_diagnostic_signs = true,
}

require("lspconfig.ui.windows").default_options.border = "single"
mason.setup(mason_setup)
trouble.setup(trouble_setup)
