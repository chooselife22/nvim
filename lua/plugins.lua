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

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver', 'solargraph', 'volar' }
for _, lsp in pairs(servers) do
	require('lspconfig')[lsp].setup {
		on_attach = on_attach,
	}
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

	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v1.x",
		requires = { 
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim" 
		},
		config = function ()
			-- See ":help neo-tree-highlights" for a list of available highlight groups
			vim.cmd([[
				hi link NeoTreeDirectoryName Directory
				hi link NeoTreeDirectoryIcon NeoTreeDirectoryName
			]])

			require("neo-tree").setup({
				close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				default_component_configs = {
					indent = {
						indent_size = 2,
						padding = 1, -- extra padding on left hand side
						with_markers = true,
						indent_marker = "│",
						last_indent_marker = "└",
						highlight = "NeoTreeIndentMarker",
					},
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "ﰊ",
						default = "*",
					},
					name = {
						trailing_slash = false,
						use_git_status_colors = true,
					},
					git_status = {
						highlight = "NeoTreeDimText", -- if you remove this the status will be colorful
					},
				},
				filesystem = {
					filters = { --These filters are applied to both browsing and searching
						show_hidden = true,
						respect_gitignore = true,
					},
					follow_current_file = true, -- This will find and focus the file in the active buffer every
																			 -- time the current file is changed while the tree is open.
					use_libuv_file_watcher = false, -- This will use the OS level file watchers
																					-- to detect changes instead of relying on nvim autocmd events.
					hijack_netrw_behavior = "open_split",
																-- "open_default", -- netrw disabled, opening a directory opens neo-tree
																									-- in whatever position is specified in window.position
																-- "open_split",  -- netrw disabled, opening a directory opens within the
																									-- window like netrw would, regardless of window.position
																-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
					window = {
						position = "left",
						width = 40,
						mappings = {
							["<2-LeftMouse>"] = "open",
							["<cr>"] = "open",
							["S"] = "open_split",
							["s"] = "open_vsplit",
							["C"] = "close_node",
							["<bs>"] = "navigate_up",
							["."] = "set_root",
							["H"] = "toggle_hidden",
							["I"] = "toggle_gitignore",
							["R"] = "refresh",
							["/"] = "fuzzy_finder",
							--["/"] = "filter_as_you_type", -- this was the default until v1.28
							--["/"] = "none" -- Assigning a key to "none" will remove the default mapping
							["f"] = "filter_on_submit",
							["<c-x>"] = "clear_filter",
							["a"] = "add",
							["d"] = "delete",
							["r"] = "rename",
							["c"] = "copy_to_clipboard",
							["x"] = "cut_to_clipboard",
							["p"] = "paste_from_clipboard",
							["m"] = "move", -- takes text input for destination
							["q"] = "close_window",
						}
					}
				},
				buffers = {
					show_unloaded = true,
					window = {
						position = "left",
						mappings = {
							["<2-LeftMouse>"] = "open",
							["<cr>"] = "open",
							["S"] = "open_split",
							["s"] = "open_vsplit",
							["<bs>"] = "navigate_up",
							["."] = "set_root",
							["R"] = "refresh",
							["a"] = "add",
							["d"] = "delete",
							["r"] = "rename",
							["c"] = "copy_to_clipboard",
							["x"] = "cut_to_clipboard",
							["p"] = "paste_from_clipboard",
							["bd"] = "buffer_delete",
						}
					},
				},
				git_status = {
					window = {
						position = "float",
						mappings = {
							["<2-LeftMouse>"] = "open",
							["<cr>"] = "open",
							["S"] = "open_split",
							["s"] = "open_vsplit",
							["C"] = "close_node",
							["R"] = "refresh",
							["d"] = "delete",
							["r"] = "rename",
							["c"] = "copy_to_clipboard",
							["x"] = "cut_to_clipboard",
							["p"] = "paste_from_clipboard",
							["A"]  = "git_add_all",
							["gu"] = "git_unstage_file",
							["ga"] = "git_add_file",
							["gr"] = "git_revert_file",
							["gc"] = "git_commit",
							["gp"] = "git_push",
							["gg"] = "git_commit_and_push",
						}
					}
				}
			})
		end
	}
	-- nvim-tree
	-- use {
	-- 	'kyazdani42/nvim-tree.lua',
	-- 	requires = 'kyazdani42/nvim-web-devicons',
	-- 	config = function() require'nvim-tree'.setup {
	-- 			filters = {
	-- 				dotfiles = false,
	-- 			},
	-- 			disable_netrw = true,
	-- 			hijack_netrw = true,
	-- 			auto_close = false,
	-- 			open_on_tab = false,
	-- 			hijack_cursor = true,
	-- 			hijack_unnamed_buffer_when_opening = false,
	-- 			update_cwd = true,
	-- 			update_focused_file = {
	-- 				enable = true,
	-- 				update_cwd = false,
	-- 			},
	-- 			-- open_on_tab = false,
	-- 			-- update_cwd = true
	-- 	} end
	-- }

	-- use 'preservim/nerdtree'

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
	-- use "tpope/vim-vinegar"
	use "wsdjeg/vim-fetch"
	use "AndrewRadev/splitjoin.vim"
	use "moll/vim-bbye"
	use "slim-template/vim-slim"
	use "sheerun/vim-polyglot"
	use "airblade/vim-rooter"

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

