local key = require("core.utils.map")
local opts = key.new_opts

return {
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = "<leader>g",
        config = function()
            local function lcheck(file)
                file = file or vim.fn.expand("%:p")
                local def_args = "log --all --stat --follow -p "
                vim.ui.input({ prompt = "Search string: " }, function(input)
                    if not input then
                        return
                    end
                    if #input < 1 then
                        vim.cmd("Git! " .. def_args .. file)
                    else
                        vim.cmd(string.format("Git! %s -S %s %s", def_args, input, file))
                    end
                end)
            end
            key.nmap({
                { "<leader>gg", ":tab Git<CR>", opts("Open git interface") },
                { "<leader>gl", lcheck, opts("Check git log") },
            })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        opts = function()
            return {
                signs = {
                    delete = { text = "" },
                    topdelete = { text = "" },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    key.nmap({
                        { "]c", gs.next_hunk, opts(bufnr) },
                        { "[c", gs.prev_hunk, opts(bufnr) },
                        { "<leader>gR", gs.reset_buffer, opts(bufnr) },
                        { "<leader>gp", gs.preview_hunk, opts(bufnr) },
                        { "<leader>gd", gs.toggle_deleted, opts(bufnr) },
                    })
                    key.nxmap({
                        { "<leader>gr", ":Gitsigns reset_hunk<CR>", opts(bufnr) },
                        { "<leader>gs", ":Gitsigns stage_hunk<CR>", opts(bufnr) },
                    })
                    key.xomap({ "ih", ":<C-U>Gitsigns select_hunk<CR>", opts(bufnr) })
                end,
            }
        end,
    },
}
