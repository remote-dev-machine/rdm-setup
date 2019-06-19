" https://github.com/itchyny/lightline.vim

 Plug 'itchyny/lightline.vim'

 " Always show status line
 set laststatus=2

 " Add the following to ZSHRC if status line doesnt have colors
 " export TERM=xterm-256color
 " Then uncomment the following
 if !has('gui_running')
   set t_Co=256
 endif

 let g:lightline = {
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ],
       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
       \ },
       \ 'component_function': {
       \   'gitbranch': 'fugitive#head'
       \ },
       \ }
