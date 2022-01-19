vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

local nvim_lsp = require('lspconfig')

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
			require('lspconfig').solargraph.setup{}
			require('lspconfig').volar.setup {
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 150
				}
			}
		end
	}

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
end)

