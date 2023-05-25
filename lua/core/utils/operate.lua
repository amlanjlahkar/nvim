local api = vim.api
local ui = vim.ui

local M = {}

---Parse specified arguments
--(note: if provided, the first single occurence of the '%' symbol in `cmd` is replaced with `filepath`,
--otherwise `filepath` is appeneded to `cmd`)
---@param cmd string shell command to execute
---@param filepath string absolute location to file on which `cmd` to be performed
---@return table|nil #table with two properties: cmd and args
local function gen_cmdict(cmd, filepath)
  if #cmd < 2 then
    return
  end
  local subst_start, _ = string.find(cmd, "%s%%%s?")
  if subst_start then
    cmd = string.format("%s %s %s", cmd:sub(1, subst_start -1), filepath, cmd:sub(subst_start + 3))
  else
    cmd = string.format("%s %s", cmd, filepath)
  end

  local cmdict = { args = {} }
  cmdict.cmd = string.match(cmd, "%S+")

  if vim.tbl_contains({ "rm", "shred" }, cmdict.cmd) then
    vim.notify("Aborted due to potentially dangerous operation!", vim.log.levels.WARN)
    return
  end

  local substr, i = string.sub(cmd, #cmdict["cmd"] + 2), 1
  for arg in string.gmatch(substr, "%S+") do
    cmdict.args[i] = arg
    i = i + 1
  end
  return cmdict
end

local function jobstart(cmd, args)
  require("plenary.job")
    :new({
      command = cmd,
      args = args,
      on_exit = vim.schedule_wrap(function(j, code)
        -- TODO: better error output
        if code > 0 then
          vim.notify("exited due to error", vim.log.levels.ERROR)
          return
        end
        if #j:result() < 1 then
          print("Done")
        else
          local bufname = "op_result"
          ---@diagnostic disable-next-line: param-type-mismatch
          local buf = vim.fn.bufnr(bufname)
          if buf < 0 then
            buf = api.nvim_create_buf(true, true)
            api.nvim_buf_set_name(buf, bufname)
          end
          api.nvim_buf_set_lines(buf, 0, -1, false, j:result())
          api.nvim_buf_set_option(buf, "modifiable", false)
          vim.cmd("sb | buf " .. buf)
        end
      end),
    })
    :start()
end

---Perform shell operation on specified file.
--(note: meant to be used with file browser plugins such as oil)
---@param file string absolute location to file
---@param prompt string prompt text for command input
function M.operate(file, prompt)
  ui.input({
    prompt = prompt,
    completion = "shellcmd",
  }, function(input)
    if input then
      local cmdict = gen_cmdict(input, file)
      local args = {}
      if cmdict and cmdict.args then
        args = cmdict.args
      else
        return
      end
      jobstart(cmdict.cmd, args)
    end
  end)
end

return M
