local tools = {
    ["StyLua"] = {
        prefix = "stylua",
        formatCommand = "stylua ${--range-start:charStart} ${--range-end:charEnd} --verify -",
        formatCanRange = true,
        formatStdin = true,
        rootMarkers = { "stylua.toml", ".stylua.toml" },
    },
    ["shfmt"] = {
        prefix = "shfmt",
        formatCommand = "shfmt -filename ${INPUT} -i 2 -ci -bn -",
        formatStdin = true,
    },
    ["ShellCheck"] = {
        prefix = "shellcheck",
        lintCommand = "shellcheck --format=gcc -",
        lintStdin = true,
        lintFormats = { "-:%l:%c: %trror: %m", "-:%l:%c: %tarning: %m", "-:%l:%c: %tote: %m" },
    },
}

local languages = {
    lua = { tools["StyLua"] },
    sh = { tools["shfmt"], tools["ShellCheck"] },
}

local filetypes = { "lua", "sh" }

return {
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
        documentSymbol = true,
        codeAction = true,
    },
    settings = {
        rootMarkers = { ".git/" },
        languages = languages,
    },
    filetypes = filetypes,
    single_file_support = true,
}
