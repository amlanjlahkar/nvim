local cmd = { "vscode-css-language-server", "--stdio" }

if _G["LSP_USEBUN"] then
    table.insert(cmd, 1, "bunx")
end

return {
    cmd = cmd,
    init_options = {
        provideFormatter = true,
    },
}
