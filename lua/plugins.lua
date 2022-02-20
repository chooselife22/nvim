vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

local nvim_lsp = require('lspconfig')

-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.colorProvider = { dynamicRegistration = false }

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	-- fzf
	use { 'junegunn/fzf', run = './install --bin', }
	use { 'ibhagwan/fzf-lua',
		requires = {
			'vijaymarupudi/nvim-fzf',
			'kyazdani42/nvim-web-devicons'
		} -- optional for icons
	}

	-- lsp
	use {
		'neovim/nvim-lspconfig',
		config = function()
			require('lspconfig').solargraph.setup{
				on_attach = on_attach
			}
			require('lspconfig').volar.setup {
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 150
				}
			}
			require('lspconfig').tailwindcss.setup{
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					tailwindCSS = {
						colorDecorators = true,
						-- emmetCompletions = true,
						experimental = {
							classRegex = {
								"\\.([^\\.]*)",
							}
						}
					}
				}
			}
		end
	}
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

	-- treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function() 
			require'nvim-treesitter.configs'.setup {
				ensure_installed = {
					'html', 'javascript', 'ruby', 'typescript'
				},
				-- highlight = {
				-- 	enable = true,
				-- 	additional_vim_regex_highlighting = true
				-- },
				indent = {
					enable = false
				},
				autotag = {
					enable = true,
				}
			} 
		end
	}
	use { 'windwp/nvim-ts-autotag'} 
	use { 'nvim-treesitter/nvim-treesitter-textobjects' }

	-- nvim-tree
	-- use {
	-- 	'kyazdani42/nvim-tree.lua',
	-- 	requires = 'kyazdani42/nvim-web-devicons',
	-- 	config = function() require'nvim-tree'.setup {
	-- 			filters = {
	-- 				dotfiles = false,
	-- 			},
	-- 	} end
	-- }

	use 'preservim/nerdtree'

	-- copilot
	use { 'github/copilot.vim', }
	-- utils
	use "tpope/vim-commentary"
	use "tpope/vim-surround"
	use "tpope/vim-fugitive"
	use "tpope/vim-endwise"
	use "tpope/vim-eunuch"
	use "tpope/vim-repeat"
	use "tpope/vim-bundler"
	use "tpope/vim-rails"
	use "tpope/vim-tbone"
	use "tpope/vim-vinegar"
	use "wsdjeg/vim-fetch"
	use "AndrewRadev/splitjoin.vim"
	use "moll/vim-bbye"
	use "slim-template/vim-slim"
	use "sheerun/vim-polyglot"

	-- colors
	use { "ellisonleao/gruvbox.nvim" }
	-- use 'folke/tokyonight.nvim'
	-- use {
	-- 	'EdenEast/nightfox.nvim',
	-- 	require('nightfox').load('nightfox')
	-- }
	

	-- statusline
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		require('lualine').setup {
			options = { theme = 'gruvbox' }
		}
	}

	-- color highlighting
	use {
		'norcalli/nvim-colorizer.lua',
		require('colorizer').setup()
	}
end)

