local api = vim.api
local fn = vim.fn

local autocmds = {
    {
        'BufWritePre',
        {
            desc = 'Remove trailing whitespaces upon writing a buffer',
            pattern = '*',
            callback = function()
                if vim.bo.ft ~= 'diff' then
                    local view = fn.winsaveview()
                    vim.cmd([[keeppatterns %s/\s\+$//e]])
                    fn.winrestview(view)
                end
            end,
        },
    },

    {
        'TextYankPost',
        {
            desc = 'Highlight text on yank',
            callback = function()
                vim.highlight.on_yank({ higroup = 'Visual', timeout = 80 })
            end,
        },
    },

    {
        'TermOpen',
        {
            desc = 'Open terminal directly in insert mode',
            command = 'setl nornu nonu stc= scl=no | startinsert',
        },
    },

    {
        'FileType',
        {
            desc = 'Override formatoptions set by builtin filetype plugins',
            command = 'setl fo-=ro',
        },
    },

    {
        { 'BufWritePre', 'FileWritePre' },
        {
            desc = 'Create missing parent directories before save',
            callback = function(self)
                local root = fn.fnamemodify(self.file, ':p:h')
                if not root:find('%S+://*') then
                    fn.mkdir(root, 'p')
                end
            end,
        },
    },
}

for _, def in pairs(autocmds) do
    local event = def[1]
    local opts = def[2]
    api.nvim_create_autocmd(event, opts)
end
