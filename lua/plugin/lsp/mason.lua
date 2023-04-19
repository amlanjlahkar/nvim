local server_spec = {
  "html",
  "cssls",
  "tsserver",
  "lua_ls",
  "pyright",
  { "clangd", skip_setup = true },
  { "rust_analyzer", skip_mason = true },
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
  for _, v in pairs(server_spec) do
    if type(v) == "string" then
      table.insert(M.ensured, v)
      table.insert(M.servers, v)
    elseif v["skip_mason"] and not v["skip_setup"] then
      table.insert(M.servers, v[1])
    elseif v["skip_setup"] and not v["skip_mason"] then
      table.insert(M.ensured, v[1])
    end
  end
  require("mason-lspconfig").setup({
    ensure_installed = M.ensured,
    automatic_installation = false,
  })
  return M.servers
end

return M
