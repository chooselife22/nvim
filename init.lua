require('settings')
require('plugins')
require('mappings')

vim.api.nvim_exec([[
    iabbrev vbase <template lang='pug'><CR>div<CR></template><CR><CR><script lang='ts'><CR>import Vue from 'vue'<CR><CR>export default Vue.extend({<CR>props: {}<CR>})<CR></script><CR><style scoped><CR></style>
  ]], true)

require('fzf')
require('vim-rails')
