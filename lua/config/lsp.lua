local lsp = vim.lsp
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

local keymap = require('utils.keymap')
local mapopts = keymap.new_opts
local map_prefix = '<leader>;'

local ag_lsp = ag('lsp', { clear = true })
local ag_lsp_doc_highlight = ag('lsp_doc_highlight', { clear = true })

au('LspAttach', {
    group = ag_lsp,
    callback = function(ev)
        local client = lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf

        ---@diagnostic disable-next-line: need-check-nil
        if client:supports_method('textDocument/documentHighlight', bufnr) then
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
        local ns_lsp_diagnostic = lsp.diagnostic.get_namespace(client.id, false)

        vim.diagnostic.config({
            -- underline = {
            --     severity = {
            --         min = vim.diagnostic.severity.WARN,
            --         max = vim.diagnostic.severity.ERROR,
            --     },
            -- },
            underline = false,
            virtual_lines = false,
            virtual_text = {
                virt_text_pos = 'eol',
            },
            float = {
                source = true,
            },
        })

        keymap.nmap({
            { 'gd', lsp.buf.definition, mapopts(bufnr, 'Lsp: Goto definition') },
            {
                map_prefix .. 'd',
                vim.diagnostic.setloclist,
                mapopts(bufnr, 'Lsp: Populate location list with diagnotics'),
            },
            {
                map_prefix .. 'i',
                function()
                    lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled(), { bufnr })
                end,
                mapopts(bufnr, 'Lsp: Toggle inlay hints'),
            },
        })
    end,
})

lsp.enable({ 'luals', 'gleam', 'eslint', 'zls' })
