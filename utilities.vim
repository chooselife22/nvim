" Check OS
if !exists("g:env")
    if has("win64") || has("win32") || has("win16")
        let g:env = "WINDOWS"
    else
        let g:env = toupper(substitute(system('uname'), '\n', '', ''))
    endif
endif
" Set root_dir
if g:env =~ 'DARWIN'
  " ... to do Mac OS X-specific stuff.
endif

if g:env =~ 'LINUX'
  let g:root_dir = "~/.config/nvim"
endif

if g:env =~ 'WINDOWS'
  let g:root_dir = "~/AppData/Local/nvim"
endif

if g:env =~ 'CYGWIN'
  " ... to do Cygwin-specific stuff.
 endif

if g:env =~ 'MINGW'
  " ... to do mingw-specific stuff (git bash, mainly).
endif
