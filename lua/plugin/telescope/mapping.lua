local fn = require("plugin.telescope.function")
local tb = fn.pick("telescope.builtin")

local key = require("core.utils.map")
local opts = key.new_opts

local M = {
    prefix = "<leader>q",
}

function M:setup()
    local p = self.prefix
    key.nmap({
        --stylua: ignore start
        { p .. "d", function() fn.get_dwots() end },
        { p .. "h", function() tb.help_tags() end },
        { p .. "n", function() fn.get_nvim_conf() end },
        { p .. "o", function() tb.oldfiles(_, { cwd_only = true }) end },
        { p .. "p", function() tb.find_files(_, { no_ignore = true }) end },
        { p .. "s", function() fn.get_relative_file() end },
        { p .. "u", function() tb.resume() end },
        { p .. "v", function() tb.git_files() end },
        --stylua: ignore end
        {
            p .. ";",
            function()
                tb.git_status(_, {
                    git_icons = {
                        added = "+",
                        changed = "~",
                        copied = ">",
                        deleted = "x",
                        renamed = "^",
                        unmerged = "<->",
                        untracked = "?",
                    },
                })
            end,
        },

        {
            p .. "b",
            function()
                local listed = #vim.fn.getbufinfo({ buflisted = true })
                if listed == 1 then
                    vim.notify("No other listed buffers found", vim.log.levels.INFO)
                    return
                end
                tb.buffers(_, {
                    ignore_current_buffer = true,
                    attach_mappings = function(prompt_bufnr, map)
                        map("i", "<C-d>", function()
                            require("telescope.actions").delete_buffer(prompt_bufnr)
                        end)
                        return true
                    end,
                })
            end,
            opts("Telescope: Listed buffers"),
        },

        {
            p .. "g",
            function()
                tb.live_grep(false, {
                    layout_strategy = "horizontal",
                    path_display = { shorten = 3 },
                    preview = true,
                })
            end,
        },

        {
            p .. "w",
            function()
                local opt = {}
                require("plugin.telescope.extra.set_bg"):pick(true, fn.use_theme(opt))
            end,
            opts("Telescope: Set wallpaper"),
        },

        {
            p .. "l",
            function()
                require("plugin.telescope.extra.logsearch").pick_files()
            end,
            opts("Telescope: Search git log"),
        },
    })
end

return M
