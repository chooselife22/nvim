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
      'hrsh7th/cmp-nvim-lua',
    },
  }
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'nvim_lua' },
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
  use 'wsdjeg/vim-fetch'
  use {
    'ckolkey/ts-node-action',
    after = 'nvim-treesitter',
    config = function() -- Optional
      require("ts-node-action").setup({})
      vim.keymap.set({ "n" }, "T", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
    end
  }
end
