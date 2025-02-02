local key = require("utils.map")
local opts = key.new_opts

return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        config = function()
            vim.g.fugitive_no_maps = 1
            key.nmap({
                { "<leader>gg", ":tab Git<CR>", opts("Fugitive: Open git interface") },
                {
                    "<leader>gv",
                    ":Gvdiffsplit! ",
                    opts(key.nosilent, "Fugitive: Populate the cmdline with Gvdiffsplit for additional arguments"),
                },
            })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        -- enabled = false,
        lazy = false,
        opts = function()
            return {
                signs = {
                    delete = { text = "" },
                    topdelete = { text = "" },
                },

                attach_to_untracked = false,

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
