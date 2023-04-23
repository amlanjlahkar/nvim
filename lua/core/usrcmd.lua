local api = vim.api
local fn = vim.fn
local cmd = api.nvim_create_user_command

cmd("GhBrowse", function(opts)
  local region = function()
    local fpath = fn.fnamemodify(fn.expand("%"), ":.:h") .. "/" .. fn.expand("%:t")
    return opts.range > 0 and string.format("%s:%s-%s", fpath, opts.line1, opts.line2) or fpath
  end
  require("plenary.job")
    :new({
      command = "gh",
      args = { "browse", "--no-browser", region() },
      on_exit = vim.schedule_wrap(function(job, exit_code)
        if exit_code > 0 then
          for _, line in ipairs(job:stderr_result()) do
            vim.notify_once(line, vim.log.levels.ERROR)
          end
        else
          fn.setreg("+", job:result()[1])
          print("url copied")
        end
      end),
    })
    :start()
end, {
  range = true,
  desc = "Copy github url for selected region of current file",
})
