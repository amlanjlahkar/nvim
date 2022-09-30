local get_autocmds = vim.api.nvim_get_autocmds
local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup
local create_command = vim.api.nvim_create_user_command
local map = vim.keymap.set

local autocmd_definitions = {
  { "BufWritePre", {
      group = "_convention",
      desc = "Remove trailing whitespaces on writing a buffer",
      pattern = { "*" },
      command = [[%s/\s\+$//e]],
    },
  },

  { "TextYankPost", {
      group = "_convention",
      desc = "Highlight text on yank",
      pattern = "*",
      callback = function()
        require("vim.highlight").on_yank { higroup = "IncSearch", timeout = 100 }
      end,
    },
  },

  { "TermOpen", {
      group = "_convention",
      desc = "Open terminal directly in insert mode",
      pattern = "*",
      command = "setlocal norelativenumber nonumber | startinsert",
    },
  },

  { "BufWritePost", {
      group = "_interprete",
      desc = "Interprete python code from the terminal",
      pattern = "*.py",
      callback = function()
        local filetype = vim.bo.filetype
        local filename = vim.fn.expand "%"
        if filetype == "python" then
          create_command("TestCode", "vnew | terminal python " .. filename, {})
        end
        map("n", "<leader>x", "<cmd>TestCode<CR>", { silent = true, noremap = true })
      end,
    },
  },
}

for _, entry in ipairs(autocmd_definitions) do
  local event = entry[1]
  local opts = entry[2]
  if type(opts.group) == "string" and opts.group ~= "" then
    local exists, _ = pcall(get_autocmds, { group = opts.group })
    if not exists then
      create_augroup(opts.group, { clear = true })
    end
  end
  create_autocmd(event, opts)
end
