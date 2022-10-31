local is_available, jdtls = pcall(require, "jdtls")
if not is_available then
  return
end

local home = os.getenv("HOME")
local launcher_path =
  vim.fn.glob(home .. "/tools/language_specific/Java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
local config_path = home .. "/tools/language_specific/Java/jdtls/config_linux/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/documents/projects/personal/dev/java/" .. project_name

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  cmd = {
    "java",

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    launcher_path,
    "-configuration",
    config_path,
    "-data",
    workspace_dir,
  },
  root_dir = jdtls.setup.find_root { ".git", "mvnw", "gradlew", "pom.xml" },
  on_attach = require("config.lsp.handlers").on_attach,
  extendedClientCapabilities = extendedClientCapabilities,

  -- eclipse.jdt.ls specific settings
  -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      eclipse = { downloadSources = true },
      autobuild = { enabled = false },
      maven = { downloadSources = true },
      references = { includeDecompiledSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      format = { enabled = true },
      configuration = { updateBuildConfiguration = "interactive" },
      import = { maven = { enabled = false } },
    },
    signatureHelp = { enabled = true },
    completion = {
      enabled = true,
      filteredTypes = {
        "java.awt.*",
        "com.sun.*",
      },
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  -- Language server `initializationOptions`
  -- Extend `bundles` with paths to jar files
  -- for additional eclipse.jdt.ls plugins i.e. for debugging
  init_options = {
    -- stylua: ignore
    --[[ bundles = {
      vim.fn.glob(home .. "/tools/language_specific/debug-extensions/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
      vim.fn.glob(home .. "/tools/language_specific/Java/debug-extensions/vscode-java-test/server/*.jar"),
    }, ]]
    bundles = {},
  },

  -- Call default user commands for nvim-jdtls
  jdtls.setup.add_commands(),
}

jdtls.start_or_attach(config)

-- Keymaps
local is_wk_available, wk = pcall(require, "which-key")
if not is_wk_available then
  return
end

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local vopts = {
  mode = "v",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local mappings = {
  e = {
    name = "Jdtls",
    o = { "<Cmd>lua require('jdtls').organize_imports()<CR>", "Organize Imports" },
    v = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable" },
    c = { "<Cmd>lua require('jdtls').extract_constant()<CR>", "Extract Constant" },
    t = { "<Cmd>lua require('jdtls').test_nearest_method()<CR>", "Test Method" },
    T = { "<Cmd>lua require('jdtls').test_class()<CR>", "Test Class" },
    u = { "<Cmd>JdtUpdateConfig<CR>", "Update Config" },
  },
}

local vmappings = {
  e = {
    name = "Jdtls",
    v = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable" },
    c = { "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant" },
    m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method" },
  },
}

wk.register(mappings, opts)
wk.register(vmappings, vopts)
