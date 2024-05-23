local key = require("utils.map")
local cmd, opts = key.cmd, key.new_opts
local nosilent = opts(key.nosilent)
local api = vim.api

-- normal {{{1
key.nmap({
    -- buffers and windows {{{2
    { "];", cmd("bn") },
    { "[;", cmd("bp") },
    { "<leader>;", "<cmd>ls!<CR>:buf<Space>", nosilent },
    { "<leader>bd", cmd("bd") },
    { "<leader>bD", cmd("%bd|e#|bd#|normal `") },
    -- 2}}}

    -- movements {{{2
    { "<leader>j", "<cmd>m .+1<CR>==" },
    { "<leader>k", "<cmd>m .-2<CR>==" },
    { "gl", "$" },
    { "n", "nzzzv" },
    { "N", "Nzzzv" },
    { "J", "mzJ`z" },
    { "]q", cmd("cnext") },
    { "[q", cmd("cprev") },
    -- { "<C-j>", 'd$o<Esc>""p==k$' },
    -- 2}}}

    -- misc {{{2
    { "gh", ":helpgrep ", nosilent },
    { "<F11>", cmd("setlocal spell!") },
    { "<F12>", cmd("!$BROWSER %") },
    { "gV", "`[v`]" },

    {
        "<leader>s", function()
            require("utils.tmux_send").send()
        end,
    },

    {
        "<leader>d",
        function()
            local start = api.nvim_get_current_buf()
            vim.cmd("vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis")
            local scratch = api.nvim_get_current_buf()
            vim.cmd("wincmd p | diffthis")
            for _, buf in ipairs({ scratch, start }) do
                vim.keymap.set("n", "q", function()
                    api.nvim_buf_delete(scratch, { force = true })
                    vim.keymap.del("n", "q", { buffer = start })
                end, { buffer = buf })
            end
        end,
        opts("Get relative diff for current file"),
    },

    {
        "<leader>w",
        function()
            local session = vim.fs.find("Session.vim", {
                upward = true,
                stop = os.getenv("HOME"),
                path = vim.uv.cwd(),
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
    { "<C-l>", "%" },
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
    { "<C-k>", "<HOME>", nosilent },
    { "<C-j>", "<END>", nosilent },
    { "<C-b>", "<S-Left>", nosilent },
    { "<C-e>", "<S-Right>", nosilent },
    { "<C-n>", "<Down>", nosilent },
    { "<C-p>", "<Up>", nosilent },

    {
        "%%",
        function()
            return vim.fn.getcmdtype() == ":" and string.format("%s/", vim.fn.expand("%:h")) or "%%"
        end,
        opts(key.expr, key.nosilent, "Append to relative path"),
    },
})
-- 1}}}

-- terminal {{{1
key.nmap({ "<leader><leader>t", cmd("tabnew term://bash") })
key.tmap({ "<C-N>", "<C-\\><C-N>" })
-- 1}}}
