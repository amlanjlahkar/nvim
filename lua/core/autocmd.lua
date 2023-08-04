local api = vim.api
local fn = vim.fn

local M = {}

M.autocmd_definitions = {
    {
        "BufWritePre",
        {
            desc = "Remove trailing whitespaces on writing a buffer",
            pattern = "*",
            callback = function()
                if vim.bo.filetype ~= "diff" then
                    local view = fn.winsaveview()
                    vim.cmd([[keeppatterns %s/\s\+$//e]])
                    fn.winrestview(view)
                end
            end,
        },
    },

    {
        "TextYankPost",
        {
            desc = "Highlight text on yank",
            callback = function()
                vim.highlight.on_yank({ higroup = "IncSearch", timeout = 80 })
            end,
        },
    },

    {
        "TermOpen",
        {
            desc = "Open terminal directly in insert mode",
            command = "setl nornu nonu scl=no | startinsert",
        },
    },

    {
        "FileType",
        {
            desc = "'q'uick unload of certain filetype buffers",
            pattern = { "help", "fugitive", "git", "checkhealth", "oil", "query" },
            callback = function(self)
                vim.keymap.set("n", "q", ":bd<CR>", { buffer = self.buf, silent = true, nowait = true })
            end,
        },
    },

    {
        "FileType",
        {
            desc = "Override formatoptions set by filetype plugins",
            command = "setl fo-=ro",
        },
    },

    {
        { "BufWritePre", "FileWritePre" },
        {
            desc = "Create missing parent directories before save",
            callback = function(self)
                local root = fn.fnamemodify(self.file, ":p:h")
                if not root:find("%S+://*") then
                    fn.mkdir(root, "p")
                end
            end,
        },
    },
}

function M.setup()
    for _, entry in pairs(M.autocmd_definitions) do
        local event = entry[1]
        local opts = entry[2]
        opts.group = "_core"
        if not pcall(api.nvim_get_autocmds, { group = opts.group }) then
            api.nvim_create_augroup(opts.group, { clear = true })
        end
        api.nvim_create_autocmd(event, opts)
    end
end

return M.setup()
