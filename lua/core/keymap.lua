local key = require("core.utils.map")
local cmd, opts = key.cmd, key.new_opts
local nosilent = opts(key.nosilent)

-- normal {{{1
key.nmap({
    -- buffers and windows {{{2
    { "];", cmd("bn") },
    { "[;", cmd("bp") },
    { "<leader>;", "<cmd>buffers<CR>:buf<Space>", nosilent },
    { "<leader>bd", cmd("bd") },
    { "<leader>bD", cmd("%bd|e#|bd#|normal `") },
    -- 2}}}

    -- movements {{{2
    { "<leader>j", "<cmd>m .+1<CR>==" },
    { "<leader>k", "<cmd>m .-2<CR>==" },
    { "n", "nzzzv" },
    { "N", "Nzzzv" },
    { "J", "mzJ`z" },
    { "]q", cmd("cnext") },
    { "[q", cmd("cprev") },
    -- { "<C-k>", 'd$O<Esc>""p==j$' },
    -- { "<C-j>", 'd$o<Esc>""p==k$' },
    -- 2}}}

    -- misc {{{2
    { "<F11>", cmd("setlocal spell!") },
    { "<F12>", cmd("!$BROWSER %") },
    { "gV", "`[v`]" },
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

    {
        "<leader>w",
        function()
            local session = vim.fs.find("Session.vim", {
                upward = true,
                stop = os.getenv("HOME"),
                path = vim.loop.cwd(),
            })
            local mks = true
            if #session < 1 then
                vim.ui.input({
                    prompt = "Create session file? [y/n] ",
                }, function(input)
                    if not input or input ~= "y" then
                        mks = false
                    end
                end)
            end
            if mks then
                vim.cmd([[:wall | exe "mksession! " .. v:this_session]])
                vim.notify("Session saved", vim.log.levels.INFO)
            end
        end,
    },

    --stylua: ignore
    { "<leader>s", function() require("core.utils.tmux_send").send() end },
})
-- 2}}}
-- 1}}}

-- visual {{{1
key.xmap({
    { "<", "<gv" },
    { ">", ">gv" },
    { "J", ":m '>+1<CR>gv=gv" },
    { "K", ":m '<-2<CR>gv=gv" },
    { "v", "yP" },
})

key.nxmap({
    { "<C-y>", '"+y' },
    { "<C-e>", '"+y$' },
})

-- 1}}}

-- insert {{{1
-- 1}}}

-- command {{{1
key.cmap({
    {
        "%%",
        function()
            return vim.fn.getcmdtype() == ":" and string.format("%s/", vim.fn.expand("%:h")) or "%%"
        end,
        opts(key.expr, key.nosilent, "Append to relative path"),
    },
    { "<C-k>", "<HOME>", nosilent },
    { "<C-j>", "<END>", nosilent },
    { "<C-b>", "<S-Left>", nosilent },
    { "<C-e>", "<S-Right>", nosilent },
    { "<C-n>", "<Down>", nosilent },
    { "<C-p>", "<Up>", nosilent },
})
-- 1}}}

-- terminal {{{1
    key.nmap({ "<leader><leader>t", cmd("tabnew term://bash") })
    key.tmap({ "<C-N>", "<C-\\><C-N>" })
-- 1}}}
