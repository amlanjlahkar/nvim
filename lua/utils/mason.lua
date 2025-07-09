local notify = vim.notify

local M = {}

---Install mason packages
---@param pkg_list table List of packages to install
M.install = function(pkg_list)
    if vim.tbl_isempty(pkg_list) then
        notify('Empty package list passed!', vim.log.levels.ERROR)
        return
    end

    local avail, registry = pcall(require, 'mason-registry')

    if not avail then
        return
    end

    if registry.refresh then
        registry.refresh(function()
            local ran_install = false
            for _, pkgname in pairs(pkg_list) do
                if not registry.is_installed(pkgname) then
                    ---@diagnostic disable-next-line: redefined-local
                    local avail, pkg = pcall(registry.get_package, pkgname)
                    if not avail then
                        notify('Package "' .. pkgname .. '" not found in mason registry!', vim.log.levels.ERROR)
                        goto continue
                    end
                    notify('Mason: Installing ' .. pkgname .. '...', vim.log.levels.INFO)
                    pkg:install()
                    ran_install = true
                end
                ::continue::
            end
            if not ran_install then
                notify('All packages are up-to-date!', vim.log.levels.INFO)
            end
        end)
    end
end

return M
