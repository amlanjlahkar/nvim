local registry = require("mason-registry")

local function auto_install(entry)
    if type(entry.auto_install) == "boolean" then
        return entry.auto_install
    end
    return true
end

local function get_pkgname(entry)
    if type(entry) == "string" then
        return entry
    elseif type(entry) == "table" and entry.mason_id then
        return entry.mason_id
    end
    return entry[1]
end

local M = {}

function M:ensure_install()
    for _, entry in pairs(require("plugin.lsp.schema")) do
        if auto_install(entry) then
            local pkgname = get_pkgname(entry)
            local pkg = assert(registry.get_package(pkgname))
            if not registry.is_installed(pkgname) then
                vim.notify("Installing " .. pkgname)
                pkg:install()
            end
        end
    end
end

M.schedule_install = vim.schedule_wrap(function()
    if registry.refresh then
        registry.refresh(function()
            M:ensure_install()
        end)
    end
end)

return M
