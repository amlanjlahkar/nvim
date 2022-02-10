local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print('Installing packer...(reopen neovim for the changes to take effect)')
end
local is_available, packer = pcall(require, "packer")
if not is_available then
    return
end

-- function to conveniently source plugin configurations
local function use_config(plugin)
    return string.format('require("config/plugin/%s")', plugin)
end

return packer.startup({function(use)
    -- imp
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use { 'nvim-lua/plenary.nvim', module_pattern = "plenary.*" }
    use { 'kyazdani42/nvim-web-devicons', module = "nvim-web-devicons" }

    -- buffer indicator
    use {
        'akinsho/bufferline.nvim',
        config = use_config("bufferline")
    }

    -- git integration
    use { 'tpope/vim-fugitive', opt = true, cmd = {'Git'} }
    use {
        'lewis6991/gitsigns.nvim',
        config = use_config("gitsigns")
    }

    -- fuzzy finding
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-telescope/telescope-fzy-native.nvim',
        config = use_config("telescope")
    }

    -- lsp related
    use {
        'neovim/nvim-lspconfig',
        ft = { 'cpp', 'c', 'objc', 'objcpp', 'lua' },
        config = [[ require('config/lsp') ]]
    }
    use {
        'hrsh7th/nvim-cmp',
        event = { "InsertEnter" },
        wants = { "LuaSnip" },
        requires = {
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path' , after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        },
        config = use_config("cmp")
    }
    use {
        'L3MON4D3/LuaSnip',
        after = "nvim-cmp",
        config = use_config("luasnip")
    }
    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        after = "nvim-lspconfig",
        config = use_config("trouble")
    }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', opt = true,
        ft = { 'bash', 'sh', 'zsh', 'cpp', 'c', 'css', 'html', 'javascript', 'lua', 'python', 'vim', 'yaml' },
        config = use_config("treesitter")
    }

    -- misc
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = use_config("indentline")
    }
    use {
        'windwp/nvim-autopairs',
        config = function()
            require("nvim-autopairs").setup()
        end
    }
    use {
        'ThePrimeagen/harpoon',
        config = use_config("harpoon")
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require("Comment").setup()
        end
    }

    -- colorscheme
    use 'sainnhe/everforest'

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end
        },
        profile = {
            enable = true,
            threshold = 1
        },
        compile_path = fn.stdpath('config') .. '/lua/packer/packer_compiled.lua'
    }
})
