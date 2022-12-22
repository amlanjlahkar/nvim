require("dressing").setup({
  input = {
    border = "single",
  },
  win_options = {
    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
  },
  select = {
    get_config = function(opts)
      if opts.kind == "codeaction" then
        return {
          backend = "telescope",
          telescope = {
            layout_strategy = "vertical",
          },
        }
      end
    end,
  },
})
