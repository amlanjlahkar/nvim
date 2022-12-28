vim.cmd([[
  hi javaError guibg=NONE guifg=NONE
  hi javaError2 guibg=NONE guifg=NONE
]])

local jdtls = require("jdtls")
local home = os.getenv("HOME")
local launcher_path = vim.fn.glob(home .. "/tools/lang/Java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
local config_path = home .. "/tools/lang/Java/jdtls/config_linux/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/documents/projects/code/java/workspaces/" .. project_name
local jol_path = home .. "/tools/lang/Java/jol-cli-0.9-full.jar"

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
  root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "build.gradle", "pom.xml" }),

  on_attach = require("plugin.lsp.config").on_attach,
  capabilities = require("plugin.lsp.config").capabilities,

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
      import = { maven = { enabled = true } },
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

jdtls.jol_path = jol_path
jdtls.start_or_attach(config)

-- Keymaps
local key = require("core.keymap.maputil")
local cmd, opts = key.cmd, key.new_opts
local nowait = key.nowait

-- stylua: ignore start
key.nmap({
  { "<leader>eo", cmd("lua require('jdtls').organize_imports()"),       opts(nowait, "Jdtls: Organize imports") },
  { "<leader>ev", cmd("lua require('jdtls').extract_variable()"),       opts(nowait, "Jdtls: Extract variable") },
  { "<leader>ec", cmd("lua require('jdtls').organize_constant()"),      opts(nowait, "Jdtls: Extract constant") },
  { "<leader>et", cmd("lua require('jdtls').test_nearest_method()"),    opts(nowait, "Jdtls: Test method") },
  { "<leader>eT", cmd("lua require('jdtls').test_class()"),             opts(nowait, "Jdtls: Test class") },
})

key.vmap({
  { "<leader>ev", cmd("lua require('jdtls').extract_variable(true)"),   opts(nowait, "Jdtls: Extract variable") },
  { "<leader>ec", cmd("lua require('jdtls').organize_constant(true)"),  opts(nowait, "Jdtls: Extract constant") },
  { "<leader>em", cmd("lua require('jdtls').extract_method(true)"),     opts(nowait, "Jdtls: Extract method") },
})
-- stylua: ignore end
