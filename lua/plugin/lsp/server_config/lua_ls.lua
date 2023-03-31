return {
  settings = {
    Lua = {
      completion = {
        enable = true,
        workspaceWord = true,
        callSnippet = "Replace",
      },
      diagnostics = {
        globals = { "vim" },
      },
      format = {
        enable = false,
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
