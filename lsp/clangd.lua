return {
    cmd = {
        'clangd',
        '--background-index',
        '--suggest-missing-includes',
        '--all-scopes-completion',
        '--completion-style=detailed',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    root_markers = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
    },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    commitCharactersSupport = true,
                    insertReplaceSupport = true,
                    labelDetailsSupport = true,
                    preselectSupport = true,
                    resolveSupport = {
                        properties = { 'documentation', 'detail', 'additionalTextEdits' },
                    },
                },
            },
        },
    },
}
