local M = {}
local ls_root_path = "/home/amlan/tools/lua_lsp"
M.setup = {
  cmd = { ls_root_path .. "/bin/lua-language-server", "-E", ls_root_path .. "/main.lua" },
  settings = {
    Lua = {
      completion = {
        enable = true,
        callSnippet = "Replace",
      },
      runtime = {
        version = "LuaJIT",
        path = (function()
          local runtime_path = vim.split(package.path, ";")
          table.insert(runtime_path, "lua/?.lua")
          table.insert(runtime_path, "lua/?/init.lua")
          return runtime_path
        end)(),
      },
      diagnostics = {
        enable = true,
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

return M
