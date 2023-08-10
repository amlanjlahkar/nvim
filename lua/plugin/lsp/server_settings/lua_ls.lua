return {
    settings = {
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
        },
    },
    single_file_support = true,
}
