return {
  "nvim-lua/plenary.nvim",
  {
    "cbochs/grapple.nvim",
    --NOTE: experimental
    init = function()
      local cwd = string.match(vim.loop.cwd(), "/([.%w_%-]+)$")
      local grapple_data = vim.fn.finddir(vim.fn.stdpath("data") .. "/grapple")
      if grapple_data then
        local file = io.popen(string.format("ls -pa %s | grep -v /", grapple_data), "r")
        if file then
          for f in file:lines() do
            if string.match(f, cwd) then
              require("lazy").load({ plugins = { "grapple.nvim" } })
              break
            end
          end
          file:close()
        end
      end
    end,
    keys = { "<leader>mm", "<leader>ma" },
    config = function()
      local g = require("grapple")
      local key = require("core.keymap.maputil")
      local opts = key.new_opts

      key.nmap({
        { "<leader>ma", g.toggle, opts("Grapple: Toggle tag") },
        { "<leader>mm", g.popup_tags, opts("Grapple: Open tags' popup menu") },
        { "];", g.cycle_forward, opts("Grapple: Forward cycle tags") },
        { "[;", g.cycle_backward, opts("Grapple: Backward cycle tags") },
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    keys = "-",
    config = function()
      require("oil").setup({
        columns = { "permissions", "size", "mtime" },
        keymaps = {
          ["gh"] = "actions.toggle_hidden",
        },
        win_options = {
          rnu = false,
          nu = false,
        },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            local pattern = { ".git", "LICENSE" }
            return vim.tbl_contains(pattern, name) and true or false
          end,
        },
        preview = {
          border = "single",
        },
      })
      vim.keymap.set("n", "-", function()
        if vim.bo.filetype ~= "fugitive" then
          require("oil").open()
        end
      end, { desc = "Oil: Open parent directory" })
      vim.keymap.set("n", "<leader>ob", function()
        local entry_name = require("oil").get_cursor_entry()["name"]
        local current_dir = require("oil").get_current_dir()
        local path = current_dir .. entry_name
        if vim.fn.isdirectory(path) < 1 then
          vim.cmd("Git blame " .. path)
        else
          vim.notify(entry_name .. " is a directory!", vim.log.levels.ERROR)
        end
      end, { desc = "Oil: View git blame for file under cursor" })
    end,
  },

  {
    "notomo/cmdbuf.nvim",
    keys = { "q:", "q/", "q?", "ql", { "<C-f>", mode = "c" } },
    config = function()
      local cwh = vim.o.cmdwinheight
      local cb = require("cmdbuf")
      local key = require("core.keymap.maputil")

      --stylua: ignore start
      key.nmap({
        { "q:", function() cb.split_open(cwh) end },
        { "q/", function() cb.split_open(cwh, { type = "vim/search/forward" }) end },
        { "q?", function() cb.split_open(cwh, { type = "vim/search/backward" }) end },
        { "ql", function() cb.split_open(cwh, { type = "lua/cmd" }) end, key.new_opts(key.nowait) },
      })
      key.cmap({
        "<C-f>", function()
          cb.split_open(cwh, { line = vim.fn.getcmdline(), column = vim.fn.getcmdpos() })
        end,
      })
      --stylua: ignore end

      vim.api.nvim_create_autocmd("User", {
        desc = "Custom settings for cmdbuf window",
        group = vim.api.nvim_create_augroup("cmdbuf_setting", { clear = true }),
        pattern = "CmdbufNew",
        callback = function(self)
          vim.o.bufhidden = "wipe"
          vim.keymap.set("n", "q", ":bwipe<CR>", { silent = true, nowait = true, buffer = self.buf })
          vim.keymap.set("n", "dd", [[<cmd>lua require('cmdbuf').delete()<CR>]], { silent = true, buffer = self.buf })
        end,
      })
    end,
  },
}
