--[[
    List of packages that should be auto-installed through mason.
    Currently being used by the `MasonEnsureInstalled` user command (:com MasonEnsureInstalled).

    NOTE: package names must match those defined in the mason-registry schema
    https://github.com/mason-org/mason-registry/tree/main/packages
--]]

return {
    'lua-language-server',
    'clangd',
    'stylua',
    -- 'svelte-language-server',
    -- 'eslint-lsp',
    -- 'zls',
    -- 'typescript-language-server',
    'shfmt',
    'tinymist',
}
