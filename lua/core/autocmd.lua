local api = vim.api
local fn = vim.fn

-- stylua: ignore
local function gcc()
  local fpath = fn.expand("%:p")
  local outfile = string.format("/tmp/%s", fn.expand("%:t:r"))
  local exit_code = nil
  require("plenary.job"):new({
      command = "gcc",
      args = { "-o", outfile, fpath },
      on_stderr = function(_, data)
        print((data and "Compilation error!"))
        exit_code = 2
      end,
    }):sync()
  return exit_code == 2 and exit_code or outfile
end

local autocmd_definitions = {
  {
    "BufWritePre",
    {
      group = "_convention",
      desc = "Remove trailing whitespaces on writing a buffer",
      pattern = "*",
      command = [[%s/\s\+$//e]],
    },
  },

  {
    "TextYankPost",
    {
      group = "_convention",
      desc = "Highlight text on yank",
      pattern = "*",
      callback = function()
        require("vim.highlight").on_yank({ higroup = "IncSearch", timeout = 50 })
      end,
    },
  },

  {
    "TermOpen",
    {
      group = "_convention",
      desc = "Open terminal directly in insert mode",
      pattern = "*",
      callback = function()
        vim.cmd([[
          setlocal norelativenumber
          setlocal nonumber
          setlocal scl=no
          startinsert
        ]])
      end,
    },
  },

  {
    "FileType",
    {
      group = "_code",
      desc = "Run interpreted/compiled code",
      pattern = { "python", "c", "cpp" },
      callback = function()
        local filetype = vim.bo.filetype
        local filename = fn.expand("%:p")
        local cc = api.nvim_create_user_command
        if filetype == "python" then
          cc("TestCode", "terminal python " .. filename, {})
        elseif filetype == "c" then
          cc("TestCode", function()
            local res = gcc()
            if res ~= 2 then
              api.nvim_exec("terminal " .. res, false)
            end
          end, {})
        elseif filetype == "cpp" then
          cc("TestCode", function()
            local res = gcc()
            if res ~= 2 then
              api.nvim_exec("terminal " .. res, false)
            end
          end, {})
        end
        vim.keymap.set("n", "<leader>x", "<cmd>TestCode<CR>", { silent = true, noremap = true })
      end,
    },
  },
}

for _, entry in ipairs(autocmd_definitions) do
  local event = entry[1]
  local opts = entry[2]
  if type(opts.group) == "string" and opts.group ~= "" then
    local exists, _ = pcall(api.nvim_get_autocmds, { group = opts.group })
    if not exists then
      api.nvim_create_augroup(opts.group, { clear = true })
    end
  end
  api.nvim_create_autocmd(event, opts)
end
