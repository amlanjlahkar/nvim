local fn = vim.fn
local exec = vim.api.nvim_command
local frmt = string.format

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  exec(frmt("!git clone --depth 1 https://github.com/wbthomason/packer.nvim %s", install_path))
  -- add packer.nvim to runtimepath on first creation
  local rtp_addition = vim.fn.stdpath "data" .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  BOOTSTRAP_PACKER = true
end

-- function to conveniently source plugin configurations
local function use_config(plugin)
  return string.format('require("config/plugin/%s")', plugin)
end

return require("packer").startup {
  function(use)
    -- Core {{{1
    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"
    -- use 'github/copilot.vim'
    use { "nvim-lua/plenary.nvim", module_pattern = "plenary.*" }

    -- LSP and Completion {{{2
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      ft = { "c", "objc", "cpp", "objcpp", "lua", "html", "css", "javascript", "php" },
      config = function()
        require "config/lsp"
      end,
    }
    use {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "config/lsp/null-ls"
      end,
    }
    use {
      "williamboman/nvim-lsp-installer",
      after = "nvim-lspconfig",
    }
    use {
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter" },
      wants = { "LuaSnip" },
      requires = {
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      },
      config = use_config "cmp",
    }
    use {
      "L3MON4D3/LuaSnip",
      after = "nvim-cmp",
      config = use_config "luasnip",
    }
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      after = "nvim-lspconfig",
      config = use_config "trouble",
    }
    -- }}}

    -- Treesitter {{{2
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = use_config "treesitter",
    }
    -- 2}}}
    -- }}}

    -- Intuitve Development {{{
    use { "tpope/vim-fugitive", opt = true, cmd = "Git" }
    use {
      "tpope/vim-ragtag",
      ft = { "html", "php", "xml" },
    }
    use {
      "nvim-telescope/telescope.nvim",
      keys = { "<C-f>", "<leader>tn", "<leader>tg" },
      requires = "nvim-telescope/telescope-fzy-native.nvim",
      config = use_config "telescope",
    }
    use {
      "kylechui/nvim-surround",
      event = "InsertEnter",
      config = function()
        require("nvim-surround").setup()
      end,
    }
    use {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()
      end,
    }
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    }
    use {
      "ThePrimeagen/harpoon",
      config = use_config "harpoon",
    }
    -- }}}

    -- UI {{{
    use { "Pocco81/TrueZen.nvim", cmd = "TZMinimalist" }
    use { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" }
    use {
      "jose-elias-alvarez/buftabline.nvim",
      config = use_config "buftabline",
    }
    use {
      "lewis6991/gitsigns.nvim",
      config = use_config "gitsigns",
    }
    -- colorscheme
    use "RRethy/nvim-base16"
    -- }}}

-- Neorg {{{
  use {
    "nvim-neorg/neorg",
    config = use_config "neorg",
  }
-- }}}

    if BOOTSTRAP_PACKER then
      require("packer").sync()
    end
  end,

  config = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
    },
    profile = {
      enable = false,
      threshold = 1,
    },
    compile_path = fn.stdpath "config" .. "/lua/plugins/packer_compiled.lua",
  },
}
