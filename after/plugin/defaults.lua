local api = vim.api
local opt = vim.opt
local api = vim.api

api.nvim_set_keymap('n', '<leader>ec',
    "<cmd>:e ~/.config/nvim/init.lua<CR>",
    { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader>rc',
    "<cmd>:so ~/.config/nvim/init.lua<CR>",
    { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader>ed',
    "<cmd>:e ~/.config/nvim/after/plugin/defaults.lua<CR>",
    { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader>ep',
    "<cmd>:e ~/.config/nvim/lua/custom/plugins.lua<CR>",
    { noremap = true, silent = true })
-- api.nvim_set_keymap('n', '<leader>em',
--     "<cmd>:e ~/.config/nvim/lua/mappings.lua<CR>",
--    { noremap = true, silent = true })
api.nvim_set_keymap('n', '<C-J>',
    "<C-W><C-J>",
    { noremap = true, silent = true })
api.nvim_set_keymap('n', '<C-K>',
    "<C-W><C-K>",
    { noremap = true, silent = true })
api.nvim_set_keymap('n', '<C-L>',
    "<C-W><C-L>",
    { noremap = true, silent = true })
api.nvim_set_keymap('n', '<C-H>',
    "<C-W><C-H>",
    { noremap = true, silent = true })
api.nvim_set_keymap('n', '<F5>', ':set hlsearch!<CR>', { noremap = true, silent = true })
api.nvim_set_keymap("i", "<C-J>", "copilot#Accept('<CR>')", { silent = true, expr = true })
api.nvim_set_keymap('n', '<leader>q',
    ":Bdelete<CR>",
    { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Space>', 'za', { noremap = true, silent = true })

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- local M = {}
-- -- function to create a list of commands and convert them to autocommands
-- -------- This function is taken from https://github.com/norcalli/nvim_utils
-- function M.nvim_create_augroups(definitions)
--     for group_name, definition in pairs(definitions) do
--         api.nvim_command('augroup '..group_name)
--         api.nvim_command('autocmd!')
--         for _, def in ipairs(definition) do
--             local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
--             api.nvim_command(command)
--         end
--         api.nvim_command('augroup END')
--     end
-- end
--
--
-- local autoCommands = {
--     -- other autocommands
--     open_folds = {
--         { "BufReadPost FileReadPost", "*", "normal zR" }
--     }
-- }
--
-- M.nvim_create_augroups(autoCommands)
vim.api.nvim_create_autocmd({'BufReadPost', 'BufWinEnter', 'FileReadPost'}, {
    command = "normal zR",
    pattern = '*',
})

vim.g.netrw_liststyle = 0
vim.cmd([[
    iabbrev vue3 <template lang='pug'><CR>div<CR></template><CR><CR><script setup lang='ts'><CR>import { ref, computed, watch, defineProps } from 'vue'<CR></script><CR><style scoped><CR></style>
  ]], true)
vim.cmd([[
    iabbrev vue2 <template lang='pug'><CR>div<CR></template><CR><CR><script><CR>export default {<CR>data() {<CR>return {<CR>}<CR>},<CR>props: {<CR>}<CR>}<CR></script><CR><style scoped><CR></style>
  ]], true)
vim.cmd('autocmd FileType ruby setlocal indentkeys-=.')
