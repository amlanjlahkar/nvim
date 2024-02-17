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
    ["ruff"] = {
        prefix = "ruff",
        lintCommand = "ruff check -",
        formatCommand = "ruff format -",
        lintStdin = true,
        formatStdin = true,
    },
    ["rustfmt"] = {
        prefix = "rustfmt",
        formatCommand = "rustfmt --emit=stdout",
        formatStdin = true,
    },
    ["prettier"] = {
        prefix = "prettierd",
        formatCommand = "prettierd --stdin-filepath ${INPUT}",
        formatStdin = true,
        env = {
            string.format("PRETTIERD_DEFAULT_CONFIG=%s", vim.fn.expand("~/.config/tools/prettier/.prettierrc.toml")),
        },
    },
}

local languages = {
    lua = { tools["StyLua"] },
    sh = { tools["shfmt"], tools["ShellCheck"] },
    python = { tools["ruff"] },
    rust = { tools["rustfmt"] },
    html = { tools["prettier"] },
    javascript = { tools["prettier"] },
    json = { tools["prettier"] },
}

local filetypes = { "lua", "sh", "python", "json", "rust", "javascript", "html" }

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
