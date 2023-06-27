local registry = require("mason-registry")

local function auto_install(pkg)
    if type(pkg.auto_install) == "boolean" then
        return pkg.auto_install
    end
    return true
end

local function get_pkgname(pkg)
    if type(pkg) == "string" then
        return pkg
    elseif type(pkg) == "table" and pkg.mason_id then
        return pkg.mason_id
    end
    return pkg[1]
end

local M = {}

function M:ensure_install(pkg_spec)
    pkg_spec = pkg_spec or require("plugin.lsp.pkg_spec")
    for _, pkg in pairs(pkg_spec) do
        if auto_install(pkg) then
            local pkgname = get_pkgname(pkg)
            local p = assert(registry.get_package(pkgname))
            if not registry.is_installed(pkgname) then
                vim.notify("Installing " .. pkgname)
                p:install()
            end
        end
    end
end

M.schedule_install = vim.schedule_wrap(function(pkg_spec)
    if registry.refresh then
        registry.refresh(function()
            M:ensure_install(pkg_spec)
        end)
    end
end)

return M
