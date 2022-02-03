local is_available, nvim_lsp = pcall(require, "lspconfig")
if not is_available then
    return
end

local on_attach = function(client, bufnr)
    -- setup keymaps
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap = true, silent = true }

    buf_set_keymap('n', 'gd',           '<cmd>lua vim.lsp.buf.definition()<CR>',                                            opts)
    buf_set_keymap('n', 'gi',           '<cmd>lua vim.lsp.buf.implementation()<CR>',                                        opts)
    buf_set_keymap('n', '[l',           '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',    opts)
    buf_set_keymap('n', 'K',            '<cmd>lua vim.lsp.buf.hover()<CR>',                                                 opts)
    buf_set_keymap('n', '<leader>k',    '<cmd>lua vim.lsp.buf.signature_help()<CR>',                                        opts)
    buf_set_keymap('n', '<leader>rn',   '<cmd>lua vim.lsp.buf.rename()<CR>',                                                opts)
    -- enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- highlight symbol under cursor
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
        false)
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local is_available, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not is_available then
  return
else
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end
capabilities.textDocument.completion.completionItem.snippetSupport = true

local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local servers = { 'clangd' }

-- server specific commands
nvim_lsp.clangd.setup{
    cmd = { "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "--all-scopes-completion",
            "--completion-style=detailed",
            "--compile-commands-dir="
    },
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        handlers = handlers,
    }
end


-- use custom diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- configure how diagnostics are displayed
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = false,
    severity_sort = false,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
})

local is_available, trouble = pcall(require, "trouble")
if not is_available then
    return
else
    trouble.setup {
        use_diagnostic_signs = true
    }
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    map('n', '<leader>tb', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
end

