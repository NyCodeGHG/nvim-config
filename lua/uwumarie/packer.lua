-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require('packer').startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')
    use('NyCodeGHG/presence.nvim')

    use({
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } },
    })
    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    })

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use({
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
    })
    use('ray-x/lsp_signature.nvim')
    use('simrat39/rust-tools.nvim')

    use({ 'catppuccin/nvim', as = 'catppuccin' })
    -- Visualize lsp progress
    use({
        'j-hui/fidget.nvim',
    })

    use('cohama/lexima.vim')

    use('gpanders/editorconfig.nvim')
    -- Transparency
    use('xiyaowong/nvim-transparent')
    use('lewis6991/impatient.nvim')
    use('JoosepAlviste/nvim-ts-context-commentstring')
    use({
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })
        end,
    })

    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    })
    use('mhartington/formatter.nvim')
    use('onsails/lspkind.nvim')

    use('fladson/vim-kitty')
end)
