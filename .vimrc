" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
" https://github.com/skielbasa/vim-material-monokai
Plug 'skielbasa/vim-material-monokai'

" https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

" https://github.com/yegappan/grep
Plug 'yegappan/grep'

" https://github.com/mileszs/ack.vim
Plug 'mileszs/ack.vim'

" NerdTree
Plug 'scrooloose/nerdtree'

" ESLint in Vim
Plug 'vim-syntastic/syntastic'

" Commenter
Plug 'scrooloose/nerdcommenter'

call plug#end()

" material-monokai theme settings
" https://github.com/skielbasa/vim-material-monokai
set background=dark
colorscheme material-monokai

" Tabs and spaces
filetype plugin indent on
" Show existing tab with 2 spaces width
set tabstop=2
" When indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab

" Always show current position
set ruler

" Always show line numbers
set number

" Map CTRLP to command key
" let g:ctrlp_map = '<o-p>'

" Highlight search results
set hlsearch

" Clear highlight on pressing \
nnoremap \ :noh<return>

" Map Ctrl-Shift-F Ack search
nnoremap ff :Ack<space>

" Used to use mouse selection without selecting numbers
" :set mouse=a

" Toggle NerdTree
:set nonumber
