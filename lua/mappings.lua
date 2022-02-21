vim.api.nvim_set_keymap('n', '<leader>ec',
    "<cmd>:e ~/.config/nvim/init.lua<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>es',
    "<cmd>:e ~/.config/nvim/lua/settings.lua<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ep',
    "<cmd>:e ~/.config/nvim/lua/plugins.lua<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rc',
    "<cmd>:so ~/.config/nvim/init.lua<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-e>',
    ":NeoTreeRevealToggle<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '-',
    ":NeoTreeRevealInSplitToggle<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-J>',
    "<C-W><C-J>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-K>',
    "<C-W><C-K>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-L>',
    "<C-W><C-L>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-H>',
    "<C-W><C-H>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-J>", "copilot#Accept('<CR>')", { silent = true, expr = true })
vim.api.nvim_set_keymap('n', '<leader>q',
    ":Bdelete<CR>",
    { noremap = true, silent = true })
