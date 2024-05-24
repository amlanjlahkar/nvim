local pkg_spec = {
    "clangd",
    "efm",
    "zls",
    "sqls",

    { "typst_lsp", mason_id = "typst-lsp" },

    -- lua
    { "lua_ls", mason_id = "lua-language-server" },
    { "stylua", auto_install = false, hook_lspconfig = false },

    -- python
    { "pylsp", mason_id = "python-lsp-server", auto_install = false },
    { "ruff", hook_lspconfig = false },

    -- rust
    { "rust_analyzer", auto_install = false, hook_lspconfig = true },

    -- shell
    { "shellcheck", hook_lspconfig = false },
    { "shfmt", hook_lspconfig = false },

    -- web
    { "cssls", auto_install = false, mason_id = "css-lsp", hook_lspconfig = true },
    { "html", auto_install = false, mason_id = "html-lsp", hook_lspconfig = true },
    { "tsserver", auto_install = false, mason_id = "typescript-language-server", hook_lspconfig = true },
    { "phpactor", auto_install = false },
}

local function validate_pkg_spec(spec)
    assert(type(spec) == "table")

    for _, pkg in pairs(spec) do
        local valid_param, err = pcall(vim.validate, {
            pkg = { pkg, { "string", "table" } },
            auto_install = { pkg["auto_install"], { "nil", "boolean" } },
            hook_lspconfig = { pkg["hook_lspconfig"], { "nil", "boolean" } },
            mason_id = { pkg["mason_id"], { "nil", "string" } },
        })

        if not valid_param then
            return false, error(string.format("error evaluating spec for %s -> %s", pkg[1], err))
        end
    end

    return true, spec
end

local M = {}

function M.import_spec()
    local is_valid_spec, result = validate_pkg_spec(pkg_spec)

    if not is_valid_spec then
        vim.notify(result, vim.log.levels.ERROR)
        return nil
    end

    return result
end

function M:import_servers()
    local pkg_spec = self.import_spec()

    if not pkg_spec then
        return nil
    end

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

return M
