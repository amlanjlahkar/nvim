local M = {}

function M.setup(server)
  local default = require("plugin.lsp.def_opts")
  local opts = {
    handlers = default.handlers(),
    on_attach = default.on_attach,
    capabilities = default.capabilities,

  }

  local has_custom_opts, custom_opts = pcall(require, "plugin.lsp.server_settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, custom_opts)
  end

  return opts
end

return M
