local function use_config(sep_namespace, plugin)
  return sep_namespace and string.format("require('config.%s')", plugin)
    or string.format("require('plugin.extend.%s')", plugin)
end

return {
  "nvim-lua/plenary.nvim",
  -- LSP {{{1
  -- 1}}}
}
