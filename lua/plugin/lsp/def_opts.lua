local M = {}

-- Handlers {{{1
function M.handlers()
    local lsp = vim.lsp
    return {
        ["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "single", style = "minimal" }),
        ["textDocument/signatureHelp"] = lsp.with(
            lsp.handlers.signature_help,
            { border = "single", style = "minimal" }
        ),
        -- ["textDocument/publishDiagnostics"] = lsp.with(
        --   lsp.diagnostic.on_publish_diagnostics,
        --   require("plugin.lsp.diagnostics"):default_opts()
        -- ),
    }
end
-- 1}}}

-- Capabilities {{{1
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
local is_cmp_available, cmp_nvim = pcall(require, "cmp_nvim_lsp")
if is_cmp_available then
    M.capabilities = cmp_nvim.default_capabilities(M.capabilities)
end
-- 1}}}

-- On_attach {{{1
-- Keymaps {{{2
function M.setup_keymaps(bufnr)
    local function check(action, fallback, opts)
        fallback = fallback or action
        opts = opts or {}
        local is_avail, tb = pcall(require, "telescope.builtin")
        if is_avail then
            tb["lsp_" .. action](opts)
        else
            vim.lsp.buf[fallback]()
        end
    end
    local lsp = vim.lsp.buf
    local key = require("core.utils.map")
    local cmd, opts = key.cmd, key.new_opts
  --stylua: ignore start
  key.imap({ "<C-h>", lsp.signature_help })
  key.nmap({
    { "K",            lsp.hover,                                          opts(bufnr, "LSP: Show hover information") },
    { "<leader>lr",   lsp.rename,                                         opts(bufnr, "LSP: Rename symbol under cursor") },
    { "<leader>la",   lsp.code_action,                                    opts(bufnr, "LSP: List available code actions") },
    { "<leader>lh",   lsp.signature_help,                                 opts(bufnr, "LSP: Show signature info for symbol under cursor") },
    { "<leader>lt",   lsp.type_definition,                                opts(bufnr, "LSP: Goto type definition for symbol under cursor") },
    { "<leader>lf",   vim.diagnostic.open_float,                          opts(bufnr, "LSP: Show line diagnostic") },
    { "]d",           vim.diagnostic.goto_next,                           opts(bufnr, "LSP: Goto next diagnostic occurrence") },
    { "[d",           vim.diagnostic.goto_prev,                           opts(bufnr, "LSP: Goto previous diagnostic occurrence") },
    {
      "gd", function()
        check("definitions", "definition")
      end, opts(bufnr, "LSP/Telescope: Goto definition")
    },
    {
      "gi", function()
        check("implementations", "implementation")
      end, opts(bufnr, "LSP/Telescope: Goto implementation(s)")
    },
    {
      "gr", function()
        check("references")
      end, opts(bufnr, "LSP/Telescope: List references")
    },
    {
      "<leader>ls", function()
        check("dynamic_workspace_symbols", "workspace_symbol", { fname_width = 40 })
      end, opts(bufnr, "LSP/Telescope: Search for workspace symbols")
    },
  })
  key.nxmap({
    "<C-s>",
    function()
      vim.lsp.buf.format({
        filter = function(client)
          local use_builtin = { "clangd", "jdtls" }
          for _, v in pairs(use_builtin) do
            if client.name == v then
              return client.name ~= "null-ls"
            end
          end
          return client.name == "null-ls"
        end,
        timeout_ms = 5000,
        async = true,
      })
    end,
    opts(bufnr, "Lsp/Null-ls: Format buffer"),
  })
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    --stylua: ignore end
end
-- 2}}}

function M.on_attach(client, bufnr)
    local api = vim.api
    if client.server_capabilities.documentHighlightProvider then
        ---@diagnostic disable-next-line: param-type-mismatch
        local is_defined, _ = pcall(vim.cmd, "silent hi LspReference")
        if is_defined then
            for _, ref in pairs({ "Text", "Read", "Write" }) do
                api.nvim_set_hl(0, "LspReference" .. ref, { link = "LspReference" })
            end
        end

        local au = api.nvim_create_autocmd
        local id = api.nvim_create_augroup("lsp_document_highlight", { clear = false })
        au("CursorHold", {
            group = id,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        au({ "CursorMoved", "InsertEnter" }, {
            group = id,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    local diagnostics = require("plugin.lsp.diagnostics")
    diagnostics:setup_signs()
    vim.diagnostic.config(diagnostics:default_opts())
    M.setup_keymaps(bufnr)
end
-- 1}}}

return M
