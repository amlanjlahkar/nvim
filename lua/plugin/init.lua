local fn = vim.fn

-- bootstrap packer installation
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("Installing packer and corresponding plugins, please wait...", vim.log.levels.INFO)
  vim.api.nvim_exec(
    string.format("silent !git clone --depth 1 https://github.com/wbthomason/packer.nvim %s", install_path),
    false
  )

  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end

  BOOTSTRAP_PACKER = true
end

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
    use("lewis6991/impatient.nvim") -- already loaded from core, but is defined here to pull new changes
    use({ "nvim-lua/plenary.nvim", module_pattern = "plenary.*" })

    -- LSP {{{2
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

    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig")
    use({ "jose-elias-alvarez/null-ls.nvim", opt = true, module = "lspconfig" })
    use({ "folke/trouble.nvim", opt = true, module = "lspconfig" })

    -- Debugging {{{3
    use({ "mfussenegger/nvim-dap", opt = true, module = "lspconfig", ft = { "java" } })
    use({ "rcarriga/nvim-dap-ui", opt = true, after = "nvim-dap" })
    -- 3}}}

    -- Language specific {{{3
    use({ "mfussenegger/nvim-jdtls", opt = true, module = "lspconfig", ft = "java" })
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

    use({
      "kylechui/nvim-surround",
      keys = { "ys", "cs", "ds" },
      config = function()
        require("nvim-surround").setup()
      end,
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

    -- Intuitve Development {{{
    use({ "tpope/vim-fugitive", opt = true, cmd = "Git" })
    use({ "ThePrimeagen/harpoon", opt = true, keys = { "<leader>h", "]h", "[h" }, config = extend("harpoon") })

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
    -- }}}

    -- UI {{{
    use({ "stevearc/dressing.nvim", config = extend("dressing") })
    use({ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" })
    use({ "lewis6991/gitsigns.nvim", config = extend("gitsigns") })
    use({ "folke/which-key.nvim", config = extend("which_key") })
    use({ "SmiteshP/nvim-navic", after = "nvim-lspconfig", config = extend("navic") })

    -- colorscheme
    use("RRethy/nvim-base16")
    -- }}}

    -- Neorg {{{
    --[[ use {
      "nvim-neorg/neorg",
      config = use_config "neorg",
    } ]]
    -- }}}

    if BOOTSTRAP_PACKER then
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

-- autocmd to source and recompile whenever this file gets written/modified
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  group = packer_group,
  pattern = fn.stdpath("config") .. "/lua/plugin/init.lua",
})
