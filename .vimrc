" ----------------------------------------------------------------------
" NATIVE CONFIG
" ----------------------------------------------------------------------

" Specify that we will use Vim and not vi
set nocompatible

" Set a global <Leader>
let mapleader = "\<Space>"

" Omnifunc autocomplete
set omnifunc=syntaxcomplete#Complete

" Set color themes
syntax on
let g:dracula_italic = 0
colorscheme dracula
" Fix as described in
" https://github.com/dracula/vim/issues/65#issuecomment-377496609
highlight Normal ctermbg=None

" Auto source vim files on save
augroup Reload_vimrc
	autocmd!
	autocmd BufWritePost *.vim* source $MYVIMRC | echom "Reloaded vim file..."
augroup END

" Show relative numbers with numberWidth = 5
set number
set relativenumber
set numberwidth=5

" Soft tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Netrw settings
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
autocmd FileType netrw setl bufhidden=delete

" Es6 files as javascript files
au BufNewFile,BufRead *.es6 set filetype=javascript

" Highlight search results
set hlsearch

" Find next searched item as I type
set incsearch

" Ignore case by default for search
" Search can be made case sensitive by adding \C before text to be searched
set ignorecase

" Smart case search
set smartcase

" Open new split panes to right and bottom
set splitbelow
set splitright

" Re-balance splits on vim resize
autocmd VimResized * :wincmd =

" ----------------------------------------------------------------------
" PLUGINS
" ----------------------------------------------------------------------

" Auto install Plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins
call plug#begin('~/.vim/plugged')
  Plug 'mileszs/ack.vim'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'tpope/vim-surround'
  Plug 'joukevandermaas/vim-ember-hbs'
call plug#end()


" ----------------------------------------------------------------------
" MAPPINGS
" ----------------------------------------------------------------------

" Toggle between current and previous buffers
" nnoremap <leader>b :b#<CR>

" Escape out of insert and visual mode with jk or kj 
inoremap jk <Esc>
inoremap kj <Esc>
vnoremap jk <Esc>
vnoremap kj <Esc>

"Easier way to enter command mode
nnoremap <leader>; :

" Stop using arrow keys
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>

" Easier way to save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Clear search highlight
nnoremap <silent> <leader>n :nohls<CR>

" Page down and page up
nnoremap <C-j> <C-f>
nnoremap <C-k> <C-b>

" Netrw settings
nnoremap <leader>f :Vexplore<CR>

" Navigation between splits
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

" Resize splits easily
nnoremap <S-j> mm :resize +2<CR>`mh 
nnoremap <S-k> mm :resize -2<CR>`m
nnoremap <S-l> mm :vertical resize -2<CR>`m
nnoremap <S-h> mm :vertical resize +2<CR>`m

" Create new splits
nnoremap <leader>\ :vsp<CR>
nnoremap <leader>- :sp<CR>

" Close other splits
nnoremap <leader>o :only<CR> 

" Ack find
nnoremap <C-f> :Ack<space>

" FZF fuzzy find files
nnoremap <leader><leader> :FZF<CR>
