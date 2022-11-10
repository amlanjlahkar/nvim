require("dressing").setup({
  input = {
    border = "single",
  },
  select = {
    get_config = function(opts)
      if opts.kind == "codeaction" then
        return {
          backend = "telescope",
          telescope = {
            layout_strategy = "vertical",
          }
        }
      end
    end,
  },
})
