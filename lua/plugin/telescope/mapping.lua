local M = {}

local extra = require("plugin.telescope.extra")
local fn = require("plugin.telescope.function")
local tb = fn.pick("telescope.builtin")

local key = require("core.keymap.maputil")
local cmd, opts = key.cmd, key.new_opts

function M.setup()
  key.nmap({
    { "<leader>tn", fn.get_nvim_conf, opts("Telescope: Nvim config") },
    { "<leader>tf", fn.get_relative_file, opts("Telescope: Buffer relative files") },
    { "<leader>td", fn.get_dwots, opts("Telescope: Dwots") },
    { "<leader>tr", fn.reload_module, opts("Telescope: Reload lua module") },
    { "<leader>tt", tb.find_files, opts("Telescope: Find files") },
    { "<leader>th", tb.help_tags, opts("Telescope: Help tags") },

    {
      "<leader>to",
      function()
        tb.oldfiles(_, { cwd_only = true })
      end,
      opts("Telescope: Oldfiles"),
    },

    {
      "<leader>tc",
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
      opts("Telescope: Git status"),
    },

    {
      "<leader>tb",
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
      "<leader>tg",
      function()
        tb.live_grep(false, { layout_strategy = "horizontal", path_display = { shorten = 3 }, preview = true })
      end,
      opts("Telescope: Live grep"),
    },

    {
      "<leader>tw",
      function()
        extra.set_bg()
      end,
      opts("Telescope: Set wallpaper"),
    },
  })
end

return M
