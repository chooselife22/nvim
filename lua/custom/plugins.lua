return function(use)
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-tbone'
  use 'tpope/vim-vinegar'
  use 'slim-template/vim-slim'
  use 'nvim-tree/nvim-web-devicons'
  require'nvim-web-devicons'.setup {
    -- your personnal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    override = {
      zsh = {
        icon = "",
        color = "#428850",
        cterm_color = "65",
        name = "Zsh"
      }
    };
    -- globally enable different highlight colors per icon (default to true)
    -- if set to false all icons will have the default icon's color
    color_icons = true;
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true;
  }
  use 'github/copilot.vim'
  use {
    'tpope/vim-rails',
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
  use 'prichrd/netrw.nvim'
  require'netrw'.setup {
    -- mappings = {
    --   ['p'] = function(payload)
    --     -- Payload is an object describing the node under the cursor, the object
    --     -- has the following keys:
    --     -- - dir: the current netrw directory (vim.b.netrw_curdir)
    --     -- - node: the name of the file or directory under the cursor
    --     -- - link: the referenced file if the node under the cursor is a symlink
    --     -- - extension: the file extension if the node under the cursor is a file
    --     -- - type: the type of node under the cursor (0 = dir, 1 = file, 2 = symlink)
    --     print(vim.inspect(payload))
    --   end,
    -- },
    use_devicons = true,
  }
end
