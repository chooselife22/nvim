return function(use)
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-tbone'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-eunuch'
  -- :Remove: Delete a file on disk without E211: File no longer available.
  -- :Delete: Delete a file on disk and the buffer too.
  -- :Move: Rename a buffer and the file on disk simultaneously. See also :Rename, :Copy, and :Duplicate.
  -- :Chmod: Change the permissions of the current file.
  -- :Mkdir: Create a directory, defaulting to the parent of the current file.
  -- :Cfind: Run find and load the results into the quickfix list.
  -- :Clocate: Run locate and load the results into the quickfix list.
  -- :Lfind/:Llocate: Like above, but use the location list.
  -- :Wall: Write every open window. Handy for kicking off tools like guard.
  -- :SudoWrite: Write a privileged file with sudo.
  -- :SudoEdit: Edit a privileged file with sudo.
  -- Typing a shebang line causes the file type to be re-detected. Additionally the file will be automatically made executable (chmod +x) after the next write.
  use 'slim-template/vim-slim'
  -- use 'davydovanton/vim-html2slim'
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use { 'junegunn/fzf.vim' }
  use 'github/copilot.vim'
  use {
    'tpope/vim-rails',
    config = [[require('config.vim-rails')]]
  }
  use({'prichrd/netrw.nvim',
    config = function()
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
  })
  use 'wsdjeg/vim-fetch'
  use {
    'ckolkey/ts-node-action',
    after = 'nvim-treesitter',
    config = function() -- Optional
      require("ts-node-action").setup({})
      vim.keymap.set({ "n" }, "T", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
    end
  }
  use({
    'Wansmer/treesj',
    requires = { 'nvim-treesitter' },
    keys = { '<space>m', '<space>j', '<space>s' },
    config = function()
      require('treesj').setup({
        -- Use default keymaps
        -- (<space>m - toggle, <space>j - join, <space>s - split)
        use_default_keymaps = true,

        -- Node with syntax error will not be formatted
        check_syntax_error = true,

        -- If line after join will be longer than max value,
        -- node will not be formatted
        max_join_length = 99999,

        -- hold|start|end:
        -- hold - cursor follows the node/place on which it was called
        -- start - cursor jumps to the first symbol of the node being formatted
        -- end - cursor jumps to the last symbol of the node being formatted
        cursor_behavior = 'hold',

        -- Notify about possible problems or not
        notify = true,
        langs = {},

        -- Use `dot` for repeat action
        dot_repeat = true,
      })
    end,
  })
  use 'sbdchd/neoformat'
  use({
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  })
  use({
    'NvChad/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup {
        filetypes = { "*" },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue or blue
          RRGGBBAA = false, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = false, -- CSS rgb() and rgba() functions
          hsl_fn = false, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
          virtualtext = "■",
          -- update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      }
    end
  })
  use({'nvim-tree/nvim-web-devicons',
    config = function()
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
    end
  })
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help indent_blankline.txt`
  --use({
  --  'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
  --  config = function()
  --    require('ibl').setup {
  --      indent = {
  --        char = '┊',
  --      },
  --      whitespace = {
  --        remove_blankline_trail = true
  --      }
  --    }
  --  end
  --})
  -- use({
  --   'JoosepAlviste/nvim-ts-context-commentstring',
  --   config = function()
  --     require('ts_context_commentstring').setup {
  --       enable_autocmd = false,
  --       languages = {
  --         typescript = {
  --           -- Uncomment the following lines to use the alternative commentstring
  --           -- commentstring = '// %s',
  --           -- single_line_comment = 'auto',
  --           -- multi_line_comment = 'auto',
  --         },
  --         javascript = {
  --           -- Uncomment the following lines to use the alternative commentstring
  --           -- commentstring = '// %s',
  --           -- single_line_comment = 'auto',
  --           -- multi_line_comment = 'auto',
  --         },
  --         typescriptreact = {
  --           -- Uncomment the following lines to use the alternative commentstring
  --           -- commentstring = '// %s',
  --           -- single_line_comment = 'auto',
  --           -- multi_line_comment = 'auto',
  --         },
  --         javascriptreact = {
  --           -- Uncomment the following lines to use the alternative commentstring
  --           -- commentstring = '// %s',
  --           -- single_line_comment = 'auto',
  --           -- multi_line_comment = 'auto',
  --         },
  --       },
  --     }
  --   end
  -- })
end
