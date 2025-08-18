vim.lsp.config['zls'] = {
    cmd = { 'zls' },
    filetypes = { 'zig' },
    root_markers = { 'zls.json', 'build.zig' },
    -- workspace_required = false,
    settings = {
        -- https://github.com/zigtools/zls/blob/master/schema.json
        zls = {
            zig_lib_path = "/Users/amlan/.local/share/mise/installs/zig/0.15.1/lib"
        },
    },
}
