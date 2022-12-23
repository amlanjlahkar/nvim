local M = {
  "williamboman/mason.nvim",
  cmd = "Mason",
}

M.pkgs = {
  "black",
  "stylua",
  "shfmt",
  "shellcheck",
  "jsonlint",
}

function M.query()
  for _, pkg in ipairs(M.pkgs) do
    local p = require("mason-registry").get_package(pkg)
    if not p:is_installed() then
      p:install()
    end
  end
end

function M.config()
  require("mason").setup({
    ui = {
      border = "single",
      icons = {
        package_installed = " ",
        package_pending = "勒",
        package_uninstalled = " ",
      },
    },
  })
  M.query()
end

return M
