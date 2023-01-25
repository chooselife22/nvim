return function(use)
  use 'tpope/vim-surround'
  use "tpope/vim-repeat"
  use "tpope/vim-tbone"
  use 'github/copilot.vim'
  use {
    "tpope/vim-rails",
    config = [[require('config.vim-rails')]]
  }
  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
    },
  }
end
