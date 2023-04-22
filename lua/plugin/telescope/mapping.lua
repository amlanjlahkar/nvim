local M = {}

local fn = require("plugin.telescope.function")
local tb = fn.pick("telescope.builtin")

local key = require("core.keymap.maputil")
local cmd, opts = key.cmd, key.new_opts

function M.setup()
  -- stylua: ignore start
  key.nmap({
    {
      "<leader>tt", function()
        tb.find_files()
      end, opts("Telescope: Find files"),
    },

    {
      "<leader>to", function()
        tb.oldfiles(_, { cwd_only = true })
      end, opts("Telescope: Oldfiles"),
    },

    {
      "<leader>tc", function()
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
      end, opts("Telescope: Git status"),
    },

    {
      "<leader>tb", function()
        local listed = #vim.fn.getbufinfo({ buflisted = true })
        if listed == 1 then
          vim.notify("No other listed buffers found", vim.log.levels.INFO)
          return
        end
        tb.buffers(_, {
          ignore_current_buffer = true,
          attach_mappings = function(prompt_bufnr, map)
            map("i", "<C-d>", function() require("telescope.actions").delete_buffer(prompt_bufnr) end)
            return true
          end
        })
      end, opts("Telescope: Listed buffers"),
    },

    {
      "<leader>tg", function()
        tb.live_grep(false, { layout_strategy = "horizontal", preview = true })
      end, opts("Telescope: Live grep"),
    },

    {
      "<leader>th", function()
        tb.help_tags()
      end, opts("Telescope: Help tags"),
    },

    {
      "<leader>tn", function()
        fn.get_nvim_conf()
      end, opts("Telescope: Nvim config"),
    },

    {
      "<leader>tf", function()
        fn.get_relative_file()
      end, opts("Telescope: Buffer relative files"),
    },

    {
      "<leader>td", function()
        fn.get_dwots()
      end, opts("Telescope: Dwots"),
    },

    {
      "<leader>tw", function()
        fn.set_bg()
      end, opts("Telescope: Set wallpaper"),
    },

    {
      "<leader>tr", function()
        fn.reload_module()
      end, opts("Telescope: Reload lua module"),
    },
  })
  -- stylua: ignore end
end

return M
