return {
    on_init = function(client)
        local wpath = client.workspace_folders[1].name
        if vim.uv.fs_stat(wpath .. "/.luarc.json") then
            return
        end

        client.settings.Lua = {
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
        }
        client.notify("workspace/didChangeConfiguration", { settings = client.settings })
    end,
}
