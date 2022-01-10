" https://www.reddit.com/r/vim/comments/dj37wt/plugin_for_conventional_commits/
"
nnoremap    <buffer> i  i<C-r>=<sid>commit_type()<CR>

fun! s:commit_type()
  call complete(1, ['Fix: ', 'Feat: ', 'Refact: ', 'Doc: ', 'Test: ', 'CI: ', 'Perf: ', 'SecFix: Bundle Audit '])
  nunmap <buffer> i
  return ''
endfun
