local cmd = { "vscode-html-language-server", "--stdio" }

if _G["LSP_USEBUN"] then
    table.insert(cmd, 1, "bunx")
end

return {
    cmd = cmd,
    filetypes = { "html", "templ", "blade" },
    init_options = {
        provideFormatter = false,
    },
}

