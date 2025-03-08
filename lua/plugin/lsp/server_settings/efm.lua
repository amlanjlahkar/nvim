local tools = {
    ["stylua"] = {
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
    ["shellcheck"] = {
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
        prefix = "prettier",
        formatCommand = "bunx prettier --stdin-filepath ${INPUT}",
        formatStdin = true,
    },
    ["jq"] = {
        prefix = "jq",
        formatCommand = "jq",
        formatStdin = true,
    },
    ["pint"] = {
        prefix = "pint",
        formatCommand = "pint --quiet --no-interaction ${INPUT}",
        formatStdin = false,
        rootMarkers = "pint.json",
        requireMarker = true,
    },
    ["blade-formatter"] = {
        prefix = "bf",
        formatCommand = "blade-formatter --stdin ${INPUT}",
        formatStdin = true,
    },
}

local languages = {
    lua = { tools["stylua"] },
    sh = { tools["shfmt"], tools["shellcheck"] },
    python = { tools["ruff"] },
    rust = { tools["rustfmt"] },
    html = { tools["prettier"] },
    javascript = { tools["prettier"] },
    php = { tools["prettier"] },
    blade = { tools["blade-formatter"] },
    sql = { tools["prettier"] },
    json = { tools["jq"] },
}

local filetypes = {}
for ft, _ in pairs(languages) do
    table.insert(filetypes, ft)
end

return {
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
        documentSymbol = true,
        codeAction = true,
        hover = true,
    },
    settings = {
        rootMarkers = { ".git/" },
        languages = languages,
    },
    filetypes = filetypes,
    single_file_support = true,
}
