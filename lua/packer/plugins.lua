local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print('Installing packer...(reopen neovim for the changes to take effect)')
end
local is_available, packer = pcall(require, "packer")
if not is_available then
    return
end

return packer.startup({function(use)
    -- imp
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use 'nathom/filetype.nvim'
    use { 'nvim-lua/plenary.nvim', module_pattern = "plenary.*" }
    use { 'kyazdani42/nvim-web-devicons', module = "nvim-web-devicons" }

    -- buffer indicator
    use {
        'akinsho/bufferline.nvim',
        config = function()
            require('config/plugin/bufferline')
        end
    }

    -- git integration
    use { 'tpope/vim-fugitive', opt = true, cmd = {'Git'} }
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('config/plugin/gitsigns')
        end
    }

    -- fuzzy finding
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-telescope/telescope-fzy-native.nvim' }
        },
        config = function()
            require('config/plugin/telescope')
        end
    }

    -- lsp related
    use {
        'neovim/nvim-lspconfig', as = 'lsp',
        ft = { 'cpp', 'c', 'objc', 'objcpp' },
        config = function()
            require('config/plugin/lsp')
        end
    }
    use {
        'hrsh7th/nvim-cmp', as = 'cmp',
        event = { "InsertEnter" },
        requires = {
            { 'hrsh7th/cmp-buffer', after = 'cmp'},
            { 'hrsh7th/cmp-path' , after = 'cmp' },
            { 'hrsh7th/cmp-nvim-lsp', after = 'cmp' },
            { 'L3MON4D3/LuaSnip', event = 'InsertEnter' },
            { 'saadparwaiz1/cmp_luasnip', after = 'cmp' },
        },
        config = function()
            require('config/plugin/cmp')
        end
    }
    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        after = 'lsp', 
        config = function()
            require('trouble').setup()
        end 
    }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', opt = true,
        ft = { 'bash', 'sh', 'zsh', 'cpp', 'c', 'css', 'html', 'javascript', 'lua', 'python', 'vim', "yaml" },
        config = function()
            require('config/plugin/treesitter')
        end
    }

    -- misc
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('config/plugin/indentline')
        end
    }
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end
    }
    use {
        'ThePrimeagen/harpoon',
        config = function()
            require('config/plugin/harpoon')
        end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- colorscheme
    use 'rktjmp/lush.nvim'

    if packer_bootstrap then
        require('packer').sync()
    end
end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'rounded' })
            end
        },
        profile = {
            enable = true,
            threshold = 1
        },
        compile_path = fn.stdpath('config')..'/lua/packer/packer_compiled.lua'
    }
})
