local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print('Installing packer...(reopen neovim for the changes to take effect)')
    vim.cmd "packadd packer.nvim"
end
local is_available, packer = pcall(require, "packer")
if not is_available then
    return
end

-- function to conveniently source plugin configurations
function use_config(plugin)
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
        requires = {{ 'nvim-telescope/telescope-fzy-native.nvim' }},
        config = use_config("telescope")
    }

    -- lsp related
    use {
        'neovim/nvim-lspconfig', as = 'lsp',
        ft = { 'cpp', 'c', 'objc', 'objcpp' },
        config = use_config("lsp")
    }
    use {
        'hrsh7th/nvim-cmp', as = 'cmp',
        event = { "InsertEnter" },
        wants = { 'snip' },
        requires = {
            { 'hrsh7th/cmp-buffer', after = 'cmp'},
            { 'hrsh7th/cmp-path' , after = 'cmp' },
            { 'hrsh7th/cmp-nvim-lsp', after = 'cmp' },
            { 'saadparwaiz1/cmp_luasnip', after = 'cmp' },
        },
        config = use_config("cmp")
    }
    use {
        'L3MON4D3/LuaSnip', as = 'snip',
        after = 'cmp',
        config = use_config("luasnip")
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
        ft = { 'bash', 'sh', 'zsh', 'cpp', 'c', 'css', 'html', 'javascript', 'lua', 'python', "yaml" },
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
            require('nvim-autopairs').setup()
        end
    }
    use {
        'ThePrimeagen/harpoon',
        config = use_config("harpoon")
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- colorscheme
    use 'sainnhe/everforest'

    if packer_bootstrap then
        require("packer").sync()
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
        compile_path = fn.stdpath('config') .. '/lua/packer/packer_compiled.lua'
    }
})
