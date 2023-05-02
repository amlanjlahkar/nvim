local M = {}

function M.check_registry(pkg_name)
  local registry = require("mason-registry")
  local is_avail, pkg = pcall(registry.get_package, pkg_name)
  if not is_avail then
    error(string.format('Couldn\'t find package "%s"', pkg_name))
  end
  return not registry.is_installed(pkg_name) and pkg
end

function M:ensure_install()
  local node_loaded = vim.fn.executable("node") == 1
  local pkg_name, is_avail, pkg
  for _, entry in pairs(require("plugin.lsp.schema")) do
    pkg_name = type(entry.mason_id) == "boolean" and entry[1] or entry.mason_id
    if entry.auto_install then
      is_avail, pkg = pcall(self.check_registry, pkg_name)
      if not is_avail then
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.notify(pkg, vim.log.levels.ERROR)
      elseif not node_loaded and entry.require_node then
        goto continue
      elseif pkg then
        vim.notify_once(string.format('[Mason] Installing "%s"', pkg.name))
        pkg:install()
      end
    end
    ::continue::
  end
end

M.schedule_install = vim.schedule_wrap(function()
  local registry = require("mason-registry")
  if registry.refresh then
    registry.refresh(function()
      M:ensure_install()
    end)
  end
end)

return M
