local M = {
  "stevearc/oil.nvim",
  keys = "-",
}

function M.config()
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
end

return M
