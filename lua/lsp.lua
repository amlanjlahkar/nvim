local lsp = vim.lsp
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

lsp.enable({ 'luals' })

au('LspAttach', {
    group = ag('lsp_attach', { clear = true }),
    callback = function(ev)
        local client = lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf

        ---@diagnostic disable-next-line: need-check-nil
        if client:supports_method('textDocument/documentHighlight', bufnr) then
            local ag_lsp_doc_highlight = ag('lsp_doc_highlight', { clear = false })

            au({ 'CursorHold' }, {
                group = ag_lsp_doc_highlight,
                buffer = bufnr,
                callback = lsp.buf.document_highlight,
            })

            au({ 'CursorMoved', 'InsertEnter' }, {
                group = ag_lsp_doc_highlight,
                buffer = bufnr,
                callback = lsp.buf.clear_references,
            })
        end

        ---@diagnostic disable-next-line: need-check-nil
        local ns_lsp_diagnostic = lsp.diagnostic.get_namespace(client.id)

        vim.diagnostic.config({
            virtual_lines = true,
        }, ns_lsp_diagnostic)
    end,
})

