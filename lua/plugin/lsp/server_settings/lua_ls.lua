return {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
            client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    completion = {
                        enable = true,
                        workspaceWord = true,
                        callSnippet = "Replace",
                    },
                    diagnostics = {
                        globals = { "vim", "_" },
                    },
                    format = {
                        enable = false,
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                    single_file_support = true,
                },
            })
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end,
}
