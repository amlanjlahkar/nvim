local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print('Installing packer...(reopen neovim for the changes to take effect)')
end
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

return packer.startup({function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'

    -- info bars
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
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('gitsigns').setup()
        end
    }

    -- fuzzy finding
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'kyazdani42/nvim-web-devicons'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzy-native.nvim'}},
        config = function()
            require('config/plugin/telescope')
        end
    }

    -- lsp related
    use {
        'neovim/nvim-lspconfig',
        ft = { 'cpp', 'c', 'objc', 'objcpp' },
        config = function()
            require('config/plugin/lsp')
        end
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
            {'saadparwaiz1/cmp_luasnip'},
        },
        config = function()
            require('config/plugin/cmp')
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', opt = true,
        ft = { 'cpp', 'c', 'css', 'html', 'javascript', 'lua', 'python', 'vim' },
        config = function()
            require('config/plugin/treesitter')
        end
    }

    -- good to have
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
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require('config/plugin/harpoon')
        end
    }

    -- colorscheme
    use 'sainnhe/gruvbox-material'

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
        compile_path = fn.stdpath('config')..'/lua/packer/packer_compiled.lua'
    }
})
