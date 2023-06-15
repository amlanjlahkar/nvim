local key = require("core.utils.map")
local opts = key.new_opts

return {
    {
        "tpope/vim-fugitive",
        keys = "<leader>f",
        config = function()
            local function lcheck(file)
                file = file or vim.fn.expand("%:p")
                local def_args = "log --all --stat -p "
                vim.ui.input({ prompt = "string> " }, function(input)
                    if not input then
                        return
                    end
                    if input == "" then
                        vim.cmd.Git(def_args .. file)
                    else
                        vim.cmd.Git(string.format("%s -S %s %s", def_args, input, file))
                    end
                end)
            end
            key.nmap({
                { "<leader>fo", ":tab Git<CR>", opts("Open git interface") },
                { "<leader>fl", lcheck, opts("Check git log") },
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
          --stylua: ignore start
          key.nmap({
            { "]c", gs.next_hunk, opts(bufnr, "Gitsigns: next hunk") },
            { "[c", gs.prev_hunk, opts(bufnr, "Gitsigns: previous hunk") },
            { "<leader>gR", gs.reset_buffer, opts(bufnr, "Gitsigns: reset buffer") },
            { "<leader>gp", gs.preview_hunk, opts(bufnr, "Gitsigns: preview_hunk") },
            { "<leader>gr", gs.reset_hunk, opts(bufnr, "Gitsigns: reset hunk") },
            { "<leader>gs", gs.stage_hunk, opts(bufnr, "Gitsigns: stage hunk") },
            { "<leader>gv", gs.select_hunk, opts(bufnr, "Gitsigns: stage hunk") },
            { "<leader>gd", gs.diffthis, opts(bufnr, "Gitsigns: diff file with current index") },
          })
          key.xmap({
            { "<leader>gr", ":Gitsigns reset_hunk<CR>", opts(bufnr, "Gitsigns: reset hunk") },
            { "<leader>gs", ":Gitsigns stage_hunk<CR>", opts(bufnr, "Gitsigns: stage hunk") },
          })
                    --stylua: ignore end
                end,
            }
        end,
    },
}
