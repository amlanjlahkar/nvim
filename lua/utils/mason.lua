---@class MasonPackage
---@field get_installed_version fun(self: MasonPackage): string
---@field get_latest_version fun(self: MasonPackage): string
---@field install fun(self: MasonPackage, opts: table, callback: function): function Initiate package installation. Returns an installation handle
---@field is_installed fun(self): boolean
---@field name string

---@class MasonRegistrySource
---@field get_package fun(pkg_name: string): MasonPackage Returns an instance of the package class if `pkg_name` exists, otherwise throws error.
---@field refresh fun(callback: function) #Refreshes the registry

local notify = vim.notify

local M = {}

---Validate packages specified in `pkg_list`.
---
---@param pkg_list string[]
---@param registry MasonRegistrySource
---@return boolean `true` if `pkg_list` is valid, otherwise `false`.
---@return string[]|table<integer, MasonPackage> #Empty table if `pkg_list` is empty or list of invalid packages if validation fails.
---Otherwise a collection of package class instances for corresponding package names in `pkg_list`.
function M.validate_pkglist(pkg_list, registry)
    if vim.tbl_isempty(pkg_list) then
        return false, {}
    end

    local invalid_pkgs = vim.tbl_filter(function(pkgname)
        local valid, _ = pcall(registry.get_package, pkgname)
        return not valid and pkgname
    end, pkg_list)

    if #invalid_pkgs > 0 then
        return false, invalid_pkgs
    end

    local pkg_instances = {}
    for idx, pkgname in ipairs(pkg_list) do
        pkg_instances[idx] = registry.get_package(pkgname)
    end

    return true, pkg_instances
end

---Install packages specified in `pkg_list` using mason.
---
---NOTE: package names must match those defined in the mason-registry schema.
---https://github.com/mason-org/mason-registry/tree/main/packages
---
---@param pkg_list string[] List of packages to install.
function M:install(pkg_list)
    ---@type boolean, MasonRegistrySource
    local avail, registry = pcall(require, 'mason-registry')

    if not avail then
        return
    end

    ---@type boolean, table<integer, MasonPackage>
    local valid, pkgs = self.validate_pkglist(pkg_list, registry)

    if not valid then
        if #pkgs == 0 then
            notify('The package list is empty.', vim.log.levels.ERROR)
        else
            notify(
                'Invalid packages found: '
                    .. table.concat(pkgs, ', ')
                    .. '\nMake sure the package names match those defined in the mason-registry schema.\n'
                    .. [[https://github.com/mason-org/mason-registry/tree/main/packages]],
                vim.log.levels.ERROR
            )
        end
        return
    end

    local is_outdated = false
    for _, p in pairs(pkgs) do
        if not p:is_installed() then
            notify('Installing ' .. p.name .. '...', vim.log.levels.INFO)
            p:install(
                {},
                vim.schedule_wrap(function(success)
                    if success then
                        notify(p.name .. ' was sucessfully installed', vim.log.levels.INFO)
                    end
                end)
            )
            is_outdated = true
        else
            registry.refresh(function()
                local pkg_vinstalled, pkg_vlatest = p:get_installed_version(), p:get_latest_version()
                if pkg_vinstalled ~= pkg_vlatest then
                    notify(
                        string.format(
                            'New version of "%s" avaiable: %s -> %s\nYou may install it through Mason UI.',
                            p.name,
                            pkg_vinstalled,
                            pkg_vlatest
                        ),
                        vim.log.levels.INFO
                    )
                    is_outdated = true
                end
            end)
        end
    end
    if not is_outdated then
        notify('All packages are up-to-date.', vim.log.levels.INFO)
    end
end

return M
