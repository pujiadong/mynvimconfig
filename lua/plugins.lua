return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'

  use {'dracula/vim', as = 'dracula'}

  use 'navarasu/onedark.nvim'

  use 'itchyny/lightline.vim'

  use 'doums/darcula'

  use 'kyazdani42/nvim-tree.lua'

  use 'nvim-tree/nvim-web-devicons'

  use 'romgrk/barbar.nvim'

  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

end)