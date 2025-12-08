local flake_path = '(builtins.getFlake "/Users/amlanjlahkar/nix-darwin")'
local current_system = 'aarch64-darwin'
return {
    cmd = { 'nixd', '--semantic-tokens=false' },
    filetypes = { 'nix' },
    root_markers = { 'flake.nix', '.git' },
    settings = {
        nixd = {
            nixpkgs = { expr = string.format('import %s.inputs.nixpkgs { system = %s; }', flake_path, current_system) },
            formatting = { command = { 'nixfmt' } },
            options = {
                darwin = { expr = flake_path .. '.darwinConfigurations.floette.options' },
                ['home-manager'] = {
                    expr = flake_path
                        .. '.darwinConfigurations.floette.options.home-manager.users.type.getSubOptions []',
                },
            },
        },
    },
}
