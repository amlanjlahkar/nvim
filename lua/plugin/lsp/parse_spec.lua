---@class Pkg
---@field auto_install boolean|nil Automatically install with mason. Default is true
---@field hook_lspconfig boolean|nil Register with lspconfig setup hook. Default is true
---@field mason_id string|nil Mason identifer for pkg. Uses the same name as pkg when nil

local validate = vim.validate

---@param pkg Pkg
---@return boolean
local function auto_install(pkg)
    if type(pkg.auto_install) == "boolean" then
        return pkg.auto_install
    end
    return true
end

---@param pkg Pkg
---@return string
local function get_pkgname(pkg)
    if pkg.mason_id then
        return pkg.mason_id
    end
    return type(pkg) == "string" and pkg or pkg[1]
end

---@param pkg_spec table
local function validate_pkg_spec(pkg_spec)
    assert(type(pkg_spec) == "table")
    for _, pkg in pairs(pkg_spec) do
        validate('auto_install', pkg['auto_install'], { 'nil', 'boolean' })
        validate('hook_lspconfig', pkg['hook_lspconfig'], { 'nil', 'boolean' })
        validate('mason_id', pkg['mason_id'], { 'nil', 'string' })
    end
end

local M = {}

function M:import_servers(pkg_spec)
    validate_pkg_spec(pkg_spec)

    local servers = {}

    for _, pkg in pairs(pkg_spec) do
        local server = type(pkg) == "table" and pkg[1] or pkg

        local hook_lspconfig = true

        if type(pkg["hook_lspconfig"]) == "boolean" then
            hook_lspconfig = pkg["hook_lspconfig"]
        end

        if hook_lspconfig then
            table.insert(servers, server)
        end
    end

    return servers
end

function M:ensure_install(registry, pkg_spec)
    validate_pkg_spec(pkg_spec)

    for _, pkg in pairs(pkg_spec) do
        if auto_install(pkg) then
            local pkgname = get_pkgname(pkg)
            local p = assert(registry.get_package(pkgname))
            if not registry.is_installed(pkgname) then
                vim.notify("Installing " .. pkgname .. "...")
                p:install()
            end
        end
    end
end

M.schedule_install = vim.schedule_wrap(function(pkg_spec)
    local is_registry_avail, registry = pcall(require, "mason-registry")

    if not is_registry_avail then
        return
    end

    if registry.refresh then
        registry.refresh(function()
            M:ensure_install(registry, pkg_spec)
        end)
    end
end)

return M
