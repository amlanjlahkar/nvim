local key = require("core.utils.map")
local cmd, opts = key.cmd, key.new_opts

key.nmap({
    -- buffers and windows {{{
    { "<leader>.", cmd("bn") },
    { "<leader>,", cmd("bp") },
    { "<leader>bd", cmd("bd") },
    { "<leader>bD", cmd("%bd|e#|bd#|normal `") },
    { "<Right>", cmd("vertical resize +7") },
    { "<Left>", cmd("vertical resize -7") },
    { "<Down>", cmd("resize +7") },
    { "<Up>", cmd("resize -7") },
    -- }}}

    -- terminal {{{
    { "<leader><leader>t", cmd("tabnew term://bash") },
    -- }}}

    -- movements {{{
    { "<leader>j", "<cmd>m .+1<CR>==" },
    { "<leader>k", "<cmd>m .-2<CR>==" },
    { "n", "nzzzv" },
    { "N", "Nzzzv" },
    { "J", "mzJ`z" },
    { "]q", cmd("cnext") },
    { "[q", cmd("cprev") },
    { "<C-k>", 'd$O<Esc>""p==j$' },
    { "<C-j>", 'd$o<Esc>""p==k$' },
    -- { ",", "@@" },
    -- }}}

    -- misc {{{
    { "<F11>", cmd("setlocal spell!") },
    { "<F12>", cmd("!$BROWSER %") },
    { "<leader>c", '"+yy' },
    { "<leader>C", '"+y$' },
    { "<leader>v", 'mc"+p`c==' },
    --stylua: ignore
    {
        "<leader>d", function()
            local start = vim.api.nvim_get_current_buf()
            vim.cmd("vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis")
            local scratch = vim.api.nvim_get_current_buf()
            vim.cmd("wincmd p | diffthis")
            for _, buf in ipairs({ scratch, start }) do
                vim.keymap.set("n", "q", function()
                    vim.api.nvim_buf_delete(scratch, { force = true })
                    vim.keymap.del("n", "q", { buffer = start })
                end, { buffer = buf })
            end
        end, opts("Get relative diff for current file"),
    },
})

key.xmap({
    { "<", "<gv" },
    { ">", ">gv" },
    { "J", ":m '>+1<CR>gv=gv" },
    { "K", ":m '<-2<CR>gv=gv" },
    { "v", "yP" },
    { "<leader>c", 'mc"+y`c' },
    { "<leader>v", '"+p==' },
})

key.imap({
    { "<C-]>", "<C-x><C-f>" },
    { "<C-l>", "<C-x><C-l>" },
    { "<C-k>", "<C-x><C-k>" },
})

--stylua: ignore
key.cmap({
    "%%", function()
        return vim.fn.getcmdtype() == ":" and
            string.format("%s/", vim.fn.expand("%:h")) or "%%"
    end, opts(key.expr, "Append to relative path")
})
-- }}}
