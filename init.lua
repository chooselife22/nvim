require('settings')
require('plugins')
require('mappings')

vim.api.nvim_exec([[
    iabbrev vbase3 <template lang='pug'><CR>div<CR></template><CR><CR><script lang='ts'><CR>import Vue from 'vue'<CR><CR>export default Vue.extend({<CR>props: {}<CR>})<CR></script><CR><style scoped><CR></style>
  ]], true)
vim.api.nvim_exec([[
    iabbrev vbase2 <template lang='pug'><CR>div<CR></template><CR><CR><script><CR>export default {<CR>data() {<CR>return {<CR>}<CR>},<CR>props: {<CR>}<CR>}<CR></script><CR><style scoped><CR></style>
  ]], true)

vim.cmd([[
augroup Mkdir
  autocmd!
  autocmd BufNewFile * call mkdir(expand("%:p:h"), "p")
augroup END
]])

require('fzf')
require('vim-rails')
