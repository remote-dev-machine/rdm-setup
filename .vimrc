"Always show current position
set ruler

"Always show line numbers
set number

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Enable syntax highlighting
syntax enable 

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

"color scheme
colorscheme monokai
set t_Co=256  " vim-monokai now only support 256 colours in terminal.

execute pathogen#infect()
call pathogen#helptags()

map <space>m :NERDTreeToggle <CR> 
