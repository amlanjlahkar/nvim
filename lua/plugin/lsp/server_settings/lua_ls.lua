return {
    on_init = function(client)
        local wpath = client.workspace_folders[1].name
        if vim.uv.fs_stat(wpath .. "/.luarc.json") then
            return
        end

        client.settings.Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim", "_" } },
            hint = { enable = true },
            format = { enable = false },
            telemetry = { enable = false },
            single_file_support = true,

            completion = {
                enable = true,
                workspaceWord = true,
                callSnippet = "Replace",
            },

            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                    [vim.fn.stdpath("data") .. "/lazy"] = true,
                },
                checkThirdParty = false,
            },
        }
        client.notify("workspace/didChangeConfiguration", { settings = client.settings })
    end,
}
