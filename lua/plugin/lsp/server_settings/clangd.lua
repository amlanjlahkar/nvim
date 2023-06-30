return {
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--all-scopes-completion",
        "--completion-style=detailed",
    },
    capabilities = {
        offsetEncoding = "utf-16",
        textDocument = {
            completion = {
                completionItem = {
                    commitCharactersSupport = true,
                    insertReplaceSupport = true,
                    labelDetailsSupport = true,
                    preselectSupport = true,
                    resolveSupport = {
                        properties = { "documentation", "detail", "additionalTextEdits" },
                    },
                },
            },
        },
    },
}
