local api = vim.api
local fn = vim.fn

local M = {}

M.autocmd_definitions = {
  {
    "BufWritePre",
    {
      desc = "Remove trailing whitespaces on writing a buffer",
      pattern = "*",
      callback = function()
        if vim.bo.filetype ~= "diff" then
          local view = fn.winsaveview()
          vim.cmd([[keeppatterns %s/\s\+$//e]])
          fn.winrestview(view)
        end
      end,
    },
  },

  {
    "TextYankPost",
    {
      desc = "Highlight text on yank",
      callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 80 })
      end,
    },
  },

  {
    "TermOpen",
    {
      desc = "Open terminal directly in insert mode",
      command = "setl nornu nonu scl=no | startinsert",
    },
  },

  {
    "FileType",
    {
      desc = "Bind key for quick testing specific source files",
      pattern = { "python", "c", "cpp", "lua", "java" },
      callback = function()
        local cmd = require("core.util").test_code(vim.bo.filetype)
        vim.keymap.set("n", "<leader>x", function()
          if cmd then
            cmd()
          else
            print("No definition provided for " .. vim.bo.filetype)
          end
        end, { silent = true, noremap = true, desc = "Compile/interprete current buffer content" })
      end,
    },
  },

  {
    "FileType",
    {
      desc = "Enable q for quit",
      pattern = { "help", "git", "checkhealth" },
      callback = function(self)
        vim.keymap.set("n", "q", ":bd<CR>", { buffer = self.buf, silent = true, nowait = true, remap = false })
      end,
    },
  },
}

function M.setup()
  for _, entry in pairs(M.autocmd_definitions) do
    local event = entry[1]
    local opts = entry[2]
    opts.group = "_core"
    local exists, _ = pcall(api.nvim_get_autocmds, { group = opts.group })
    if not exists then
      api.nvim_create_augroup(opts.group, { clear = true })
    end
    api.nvim_create_autocmd(event, opts)
  end
end

return M.setup()
