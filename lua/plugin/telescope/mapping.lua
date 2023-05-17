local fn = require("plugin.telescope.function")
local tb = fn.pick("telescope.builtin")

local key = require("core.utils.map")
local opts = key.new_opts

local M = {
  prefix = "<leader>q",
}

function M:setup()
  key.nmap({
    {
      self.prefix .. "n",
      function()
        fn.get_nvim_conf()
      end,
      opts("Telescope: Nvim config"),
    },

    -- {
    --   self.prefix .. "s",
    --   function()
    --     fn.get_relative_file()
    --   end,
    --   opts("Telescope: Buffer relative files"),
    -- },

    {
      self.prefix .. "d",
      function()
        fn.get_dwots()
      end,
      opts("Telescope: Dwots"),
    },

    {
      self.prefix .. "h",
      function()
        tb.help_tags()
      end,
      opts("Telescope: Help tags"),
    },

    {
      self.prefix .. "p",
      function()
        tb.find_files(_, { no_ignore = true })
      end,
      opts("Telescope: Find files"),
    },

    {
      self.prefix .. "v",
      function()
        tb.git_files()
      end,
      opts("Telescope: Git tracked files"),
    },

    {
      self.prefix .. "o",
      function()
        tb.oldfiles(_, { cwd_only = true })
      end,
      opts("Telescope: Oldfiles"),
    },

    {
      self.prefix .. ";",
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
      self.prefix .. "b",
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
      self.prefix .. "g",
      function()
        tb.live_grep(false, { layout_strategy = "horizontal", path_display = { shorten = 3 }, preview = true })
      end,
      opts("Telescope: Live grep"),
    },

    {
      self.prefix .. "w",
      function()
        local opt = {}
        require("plugin.telescope.extra.set_bg"):pick(true, fn.use_theme(opt))
      end,
      opts("Telescope: Set wallpaper"),
    },
  })
end

return M
