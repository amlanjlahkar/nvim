local api = vim.api
local fn = vim.fn
local au = api.nvim_create_autocmd

au('BufWritePre', {
    desc = 'Remove trailing whitespaces upon writing a buffer',
    pattern = '*',
    callback = function()
        if vim.bo.ft ~= 'diff' then
            local view = fn.winsaveview()
            vim.cmd([[keeppatterns %s/\s\+$//e]])
            fn.winrestview(view)
        end
    end,
})

au('TextYankPost', {
    desc = 'Highlight text on yank',
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 80 })
    end,
})

au('TermOpen', {
    desc = 'Open terminal directly in insert mode',
    command = 'setl nornu nonu stc= scl=no | startinsert',
})

au('FileType', {
    desc = 'Override formatoptions set by builtin filetype plugins',
    command = 'setl fo-=ro',
})

au({ 'BufWritePre', 'FileWritePre' }, {
    desc = 'Create missing parent directories before save',
    callback = function(self)
        local root = fn.fnamemodify(self.file, ':p:h')
        if not root:find('%S+://*') then
            fn.mkdir(root, 'p')
        end
    end,
})
