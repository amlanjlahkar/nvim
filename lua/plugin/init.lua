local fn = vim.fn

-- bootstrap packer installation
local function ensure_packer()
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify("Installing packer and corresponding plugins, please wait...", vim.log.levels.INFO)
    vim.cmd(string.format("silent !git clone --depth 1 https://github.com/wbthomason/packer.nvim %s", install_path))
    vim.opt.runtimepath:append(install_path)
    return true
  end
  return false
end
local bootstrap = ensure_packer()

local function extend(plugin)
  return string.format("require('plugin.extend.%s')", plugin)
end

local function use_config(plugin)
  return string.format("require('config.%s')", plugin)
end

require("packer").startup({
  function(use)
    -- Core {{{1
    use("wbthomason/packer.nvim")
    use("lewis6991/impatient.nvim")
    use({ "nvim-lua/plenary.nvim", module_pattern = "plenary.*" })

    -- LSP {{{2
    use({
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup({
          ui = {
            border = "single",
            icons = {
              package_installed = " ",
              package_pending = "勒",
              package_uninstalled = " ",
            },
          },
        })
      end,
    })
    use({
      "williamboman/mason-lspconfig",
      config = function()
        local servers = require("config.lsp.server").pass_servers()
        require("mason-lspconfig").setup({
          ensure_installed = servers,
          automatic_installation = false,
        })
      end,
    })
    use({
      "neovim/nvim-lspconfig",
      opt = true,
      ft = {
        "c",
        "objc",
        "cpp",
        "objcpp",
        "lua",
        "html",
        "css",
        "javascript",
        "java",
        "php",
        "python",
        "sh",
        "bash",
        "json",
        "yaml",
      },
      config = use_config("lsp"),
    })
    use({ "jose-elias-alvarez/null-ls.nvim", opt = true, module = "null-ls" })
    use({ "folke/trouble.nvim", opt = true, after = "nvim-lspconfig" })

    -- Debugging {{{3
    use({ "mfussenegger/nvim-dap", opt = true, module = "dap", ft = { "java" } })
    use({ "rcarriga/nvim-dap-ui", opt = true, after = "nvim-dap" })
    -- 3}}}

    -- Language specific {{{3
    use({ "mfussenegger/nvim-jdtls", opt = true, ft = "java" })
    -- 3}}}
    -- 2}}}

    -- Completion {{{2
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      },
      event = "InsertEnter",
      config = use_config("completion"),
    })

    use({
      "L3MON4D3/LuaSnip",
      requires = { { "rafamadriz/friendly-snippets", opt = true } },
      after = "nvim-cmp",
    })
    -- 2}}}

    -- Treesitter {{{2
    use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
        local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
        ts_update()
      end,
      config = extend("treesitter"),
    })

    use({
      "windwp/nvim-ts-autotag",
      opt = true,
      after = "nvim-treesitter",
      ft = "html",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    })
    -- 2}}}
    -- 1}}}

    -- Ease of Workflow {{{1
    -- Git Integration {{{2
    use({ "tpope/vim-fugitive", opt = true, cmd = "Git" })
    use({ "lewis6991/gitsigns.nvim", config = extend("gitsigns") })
    -- 2}}}

    use({ "ThePrimeagen/harpoon", opt = true, keys = "<leader>h", config = extend("harpoon") })

    use({
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-telescope/telescope-fzf-native.nvim", run = "make", module = "telescope" } },
      config = use_config("telescope"),
    })

    use({
      "numToStr/Comment.nvim",
      keys = { "gc", "gb" },
      config = function()
        require("Comment").setup()
      end,
    })

    use({
      "kylechui/nvim-surround",
      -- keys = { "ys", "cs", "ds", { "v", "S" } },
      config = function()
        require("nvim-surround").setup()
      end,
    })
    -- 1}}}

    -- UI {{{
    use({ "stevearc/dressing.nvim", config = extend("dressing") })
    use({ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" })
    -- use({ "folke/which-key.nvim", config = extend("which_key") })
    -- use({ "SmiteshP/nvim-navic", after = "nvim-lspconfig", config = extend("navic") })

    -- colorscheme
    use("xiyaowong/nvim-transparent")
    use("RRethy/nvim-base16")
    -- }}}

    -- Neorg {{{
    --[[ use {
      "nvim-neorg/neorg",
      config = use_config "neorg",
    } ]]
    -- }}}

    if bootstrap then
      require("packer").sync()
    end
  end,

  config = {
    display = {
      compact = true,
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
      prompt_border = "single",
      moved_sym = " ",
      error_sym = " ",
      done_sym = " ",
      removed_sym = " ",
    },
    profile = {
      enable = false,
      threshold = 1,
    },
    compile_path = fn.stdpath("config") .. "/lua/plugin/packer_compiled.lua",
  },
})

-- extras
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = fn.stdpath("config") .. "/lua/plugin/init.lua",
  command = "source <afile> | PackerCompile",
})

local key = require("core.keymap.maputil")
local cmd, opts = key.cmd, key.new_opts
key.nmap({
  { "<leader>pi", cmd("PackerInstall"), opts("Packer: Install missing plugins") },
  { "<leader>py", cmd("PackerSync"), opts("Packer: Sync plugin repositories") },
  { "<leader>ps", cmd("PackerStatus"), opts("Packer status") },
})
