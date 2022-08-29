vim.g.encoding = "utf-8"

vim.g.number = true

vim.g.shiftwidth = 2 
vim.g.tabstop = 2
vim.g.softtabstop = 2
vim.g.expandtab = true
vim.g.smarttab = true
vim.g.autoindent = true
vim.g.copyindent = true

vim.g.showmode = true
vim.g.showcmd = true

vim.g.showmatch = true

vim.wo.wrap = true

vim.g.hlsearch = true
vim.g.incsearch = true
vim.g.ignorecase = true
vim.g.smartcase = true

vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.g.copilot_no_tab_map = true

vim.g.splitjoin_ruby_curly_braces = 0
vim.g.splitjoin_ruby_hanging_args = 0
vim.g.splitjoin_ruby_do_block_split = 0

vim.g.camelcasemotion_key = '<leader>'

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.o.termguicolors = true

-- vim.g.gutentags_enable = true
