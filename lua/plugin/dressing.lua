local M = {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
}

function M.opts()
  return {
    input = {
      border = "single",
      get_config = function(opts)
        if string.match(opts.prompt, "Arguments to pass: ") then
          return {
            relative = "win",
          }
        end
      end,
    },
    win_options = {
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
    },
    select = {
      builtin = { border = "single" },
      telescope = { layout_strategy = "vertical" },
      get_config = function(opts)
        -- JdtWipeDataAndRestart
        if string.match(opts.prompt, "wipe the data folder") then
          return {
            backend = "builtin",
            builtin = { width = 0.8, height = 0.3 },
          }
        end
      end,
    },
  }
end

return M
