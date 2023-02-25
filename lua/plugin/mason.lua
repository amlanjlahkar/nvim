local M = {
  "williamboman/mason.nvim",
}

M.pkgs = {
  "black",
  "stylua",
  "shfmt",
  "shellcheck",
  "jsonlint",
  "prettierd",
}

function M.query(pkg_list)
  for _, p in pairs(pkg_list) do
    local pkg = require("mason-registry").get_package(p)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end

function M:config()
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
  self.query(self.pkgs)
end

return M
