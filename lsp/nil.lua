return {
    cmd = { 'nil' },
    filetypes = { 'nix' },
    root_markers = { 'flake.nix', '.git' },
    settings = {
        formatting = { command = { 'nixfmt' } },
    },
}
