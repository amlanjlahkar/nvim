local server_spec = {
  "cssls",
  "html",
  "lua_ls",
  "pyright",
  { "clangd", skip_setup = true },
  { "tsserver", skip_setup = true },
  { "rust_analyzer", skip_mason = false },
}

local utils = {
  "blue",
  "stylua",
  "shfmt",
  "shellcheck",
  "jsonlint",
  "prettierd",
}

local M = {
  servers = {},
  ensured = {},
}

function M.query_utils(pkg_list)
  pkg_list = pkg_list or utils
  for _, p in pairs(pkg_list) do
    local pkg = require("mason-registry").get_package(p)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end

function M:setup_servers()
  local ensured, servers = self.ensured, self.servers
  local insert = table.insert
  for _, v in pairs(server_spec) do
    if type(v) == "string" then
      insert(ensured, v)
      insert(servers, v)
    end
    if not v["skip_mason"] then
      insert(ensured, v[1])
    end
    if not v["skip_setup"] then
      insert(servers, v[1])
    end
  end
  require("mason-lspconfig").setup({
    ensure_installed = ensured,
    automatic_installation = false,
  })
  return M.servers
end

return M
