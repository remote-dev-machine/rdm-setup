" -----------------------------------
" Auto Install Vim-Plug
" -----------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" -----------------------------------
"  Plugins
" -----------------------------------

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" https://github.com/skielbasa/vim-material-monokai
Plug 'skielbasa/vim-material-monokai'

" https://github.com/ctrlpvim/ctrlp.vim
" Plug 'ctrlpvim/ctrlp.vim'

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

" Vim handlebars
Plug 'mustache/vim-mustache-handlebars'

" Status Line
Plug 'bling/vim-airline'

" Fujitive for git
Plug 'tpope/vim-fugitive'

" Json
Plug 'elzr/vim-json'

" Goyo, minimal vim
Plug 'junegunn/goyo.vim'

" Fuzzy find using fzf
" Uncomment the following for mac if fzf is already installed
" Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'

" Auto pair brackets
Plug 'jiangmiao/auto-pairs'

" Format styled-components
Plug 'styled-components/vim-styled-components'

" Auto run prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

call plug#end()



" -----------------------------------
"   Visual Settings 
" -----------------------------------

" material-monokai theme settings
" https://github.com/skielbasa/vim-material-monokai
colorscheme material-monokai



" -----------------------------------
"   Editor Settings 
" -----------------------------------

" Load filetype-specific indent files
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

" Highlight search results
set hlsearch

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Makes search act like search in modern browsers
set incsearch 

" Syntax highlighting
syntax on

" Es6 files as javascript files
au BufNewFile,BufRead *.es6 set filetype=javascript

" Use system clipboard to copy
set clipboard=unnamedplus

" Split Management
set splitbelow                "Make splits default to below...
set splitright                "And to the right. This feels more natural.

" Used to use mouse selection without selecting numbers
" :set mouse=a

" Highlight cursor line
" set cursorline

" Visual complete for command menu
set wildmenu


" -----------------------------------
"   Key Map Settings 
" -----------------------------------

" Clear highlight on pressing \<space>
nmap <Leader><space> :nohlsearch<return>

" Map Ctrl-Shift-F Ack search
nmap ff :Ack<space>

" Map FZF search to space space 
nmap <space><space> :FZF<CR>

" Toggle NerdTree
nmap <silent> <Leader><Leader> :NERDTreeToggle<CR>

" Split screen
nmap <silent> .. :vsp<CR>
nmap <silent> // :sp<CR>

" Split screen move
" Alt-jkl;
nmap ≤ <C-W><C-J>
nmap ø <C-W><C-K>
nmap ˚ <C-W><C-H>
nmap ¬ <C-W><C-L>
nmap ≥ <C-W><C-W>

" Map space key double press to open ctrl-p
" let g:ctrlp_map = '<space><space>'

" Git shortcuts, need Fugitive installed to work
nmap <silent> gs :Gstatus<CR>
nmap <silent> gd :Gdiff<CR>

" Distraction free writing using Goyo
nmap <silent> asd :Goyo x50%<CR>
nmap <silent> asdf :Goyo!<CR>


" -----------------------------------
"   Plugin Settings 
" -----------------------------------

" Syntastic >> Config
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

" Ctrl-P >> Allow CTRLP to search in deeply nested folders
" let g:ctrlp_max_files=0
" let g:ctrlp_max_depth=6

" NERDTree >> Show hidden files
let g:NERDTreeShowHidden=1

" NERDTree arrows config
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" NERDTree Mac Vim ^G issue
" https://stackoverflow.com/questions/53657545/nerdtree-g-before-folder-and-file-names-osx-terminal-vim
let g:NERDTreeNodeDelimiter = "\u00a0"

" Goyo >> Config
function! s:goyo_enter()
  set number
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()

" Ack >> Don't print on terminal
set shellpipe=>

" Prettier auto run on save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
