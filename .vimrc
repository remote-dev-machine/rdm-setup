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
nnoremap <silent> \\ :NERDTreeToggle<CR>

" Syntax highlighting
syntax on

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_es6_checkers = ['eslint']
let g:syntastic_js_checkers = ['eslint']

" Es6 files as javascript files
au BufNewFile,BufRead *.es6 set filetype=javascript

" Use system clipboard to copy
set clipboard=unnamedplus

" Allow CTRLP to search in deeply nested folders
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
