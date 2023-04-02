local M = { "williamboman/mason.nvim" }

M.pkgs = {
  "blue",
  "stylua",
  "shfmt",
  "shellcheck",
  "jsonlint",
  "prettierd",
}

function M.query(pkg_list)
  pkg_list = pkg_list or M.pkgs
  for _, p in pairs(pkg_list) do
    local pkg = require("mason-registry").get_package(p)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end

function M.opts()
  return {
    ui = {
      border = "single",
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
    },
  }
end

return M
