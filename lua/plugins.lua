return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'        -- Package manager

  use {'dracula/vim', as = 'dracula'}  -- Theme

  use 'navarasu/onedark.nvim'        -- Theme

  use 'itchyny/lightline.vim'       -- Statusline

  use 'doums/darcula'               -- Theme 

  use 'kyazdani42/nvim-tree.lua'    -- File explorer

  use 'nvim-tree/nvim-web-devicons'   -- File explorer icons

  use 'romgrk/barbar.nvim'            -- Bufferline

  use 'neovim/nvim-lspconfig'         -- Collection of configurations for built-in LSP client

  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp

  use 'L3MON4D3/LuaSnip' -- Snippets plugin

end)