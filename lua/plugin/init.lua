local fn = vim.fn

-- bootstrap packer installation
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("Installing packer and corresponding plugins, please wait...", vim.log.levels.INFO)
  vim.api.nvim_exec(string.format("silent !git clone --depth 1 https://github.com/wbthomason/packer.nvim %s", install_path), false)

  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end

  BOOTSTRAP_PACKER = true
end

local function use_config(plugin)
  return string.format('require("config.plugin.%s")', plugin)
end

require("packer").startup({
  function(use)
    -- Core {{{1
    use("wbthomason/packer.nvim")
    use({
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient")
      end,
    })
    use({ "nvim-lua/plenary.nvim", module_pattern = "plenary.*" })

    -- LSP and Completion {{{2
    use({
      "neovim/nvim-lspconfig",
      requires = "folke/trouble.nvim",
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
      config = function()
        require("config/lsp")
      end,
    })

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
    use("williamboman/mason-lspconfig")

    use("jose-elias-alvarez/null-ls.nvim")

    use({
      "SmiteshP/nvim-navic",
      after = "nvim-lspconfig",
      config = use_config("navic"),
    })

    use({
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter" },
      wants = { "LuaSnip" },
      requires = {
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      },
      config = use_config("cmp"),
    })

    use({
      "L3MON4D3/LuaSnip",
      after = "nvim-cmp",
      config = use_config("luasnip"),
    })
    -- 2}}}

    -- Treesitter {{{2
    use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
      config = use_config("treesitter"),
    })

    use({
      "windwp/nvim-ts-autotag",
      ft = "html",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    })
    -- 2}}}

    -- Debugging {{{2
    use({ "mfussenegger/nvim-dap", ft = { "java" } })
    use({ "rcarriga/nvim-dap-ui", after = "nvim-dap" })
    -- 2}}}

    -- language specific {{{2
    use({ "mfussenegger/nvim-jdtls", ft = "java" })
    -- 2}}}
    -- 1}}}

    -- Intuitve Development {{{
    use({ "tpope/vim-fugitive", opt = true, cmd = "Git" })
    use({ "ThePrimeagen/harpoon", config = use_config("harpoon") })

    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      requires = "nvim-telescope/telescope.nvim",
      run = "make",
      config = function()
        require("config.telescope")
      end,
    })
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })

    use({
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup()
      end,
    })
    -- }}}

    -- UI {{{
    use({ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" })
    use({ "lewis6991/gitsigns.nvim", config = use_config("gitsigns") })
    use({ "folke/which-key.nvim", config = use_config("which_key") })
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
