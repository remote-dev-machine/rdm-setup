" ----------------------------------------------------------------------
" NATIVE CONFIG
" ----------------------------------------------------------------------

" Specify that we will use Vim and not vi
set nocompatible

" Set hidden for buffers
set hidden

" Set a global <Leader>
let mapleader = "\<Space>"

" Turn on syntax highlight
syntax on

" Always show sign column for any errors
set signcolumn=yes

" Auto source vim files on save
augroup Reload_vimrc
autocmd!
autocmd BufWritePost *.vim* source $MYVIMRC | echom "Reloaded vim file..."
augroup END

" Show relative numbers with numberWidth = 5
set number
set relativenumber

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

" Install
" ----------------------------------------------------------------------
" Auto install Plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Resets for plugins
" ----------------------------------------------------------------------
" Ale
" Use Coc for lsp
let g:ale_disable_lsp = 1
" Enable airline for diagnostics
let g:airline#extensions#ale#enabled = 1


" Load plugins
" ----------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
  Plug 'morhetz/gruvbox', { 'as': 'gruvbox' }
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'joukevandermaas/vim-ember-hbs'
  Plug 'vim-airline/vim-airline'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'dense-analysis/ale'
  Plug 'jiangmiao/auto-pairs'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-rhubarb'
call plug#end()

" ----------------------------------------------------------------------
" PLUGIN CONFIGS
" ----------------------------------------------------------------------

" Gruvbox
" ----------------------------------------------------------------------
" Set color themes
set background=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_sign_column='bg0'
colorscheme gruvbox

" Ripgrep via FZF
" ----------------------------------------------------------------------
" CTRL-A CTRL-Q to select all and build quickfix list
" https://github.com/junegunn/fzf.vim/issues/185#issuecomment-322120216
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -g "!.git"'

" coc.nvim
" ----------------------------------------------------------------------
" Install Extensions
" :CocInstall coc-json coc-css coc-elixir coc-ember coc-eslint coc-html coc-stylelint coc-solargraph coc-tsserver coc-yaml coc-vimlsp

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=500

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Ale
" ----------------------------------------------------------------------
" Always on diagnostics sign in gutter
let g:ale_sign_column_always = 1

" Signs for ale
let g:ale_sign_error = '‣'
let g:ale_sign_warning = '‣'

" Disable all highlights since they add clutter
let g:ale_set_highlights = 0

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

" Ripgrep find
nnoremap <C-f> :Rg<space>

" FZF fuzzy find files
nnoremap <leader><leader> :FZF<CR>

" Git status using fugitive
nnoremap gs :Git<CR>

" Git blame using fugitive
nnoremap gb :Git blame<CR>

" Git diff in split using fugitive
nnoremap gd :Gdiffsplit<CR>

" Git log using fugitive
nnoremap gl :Git log<CR>

" Git browse to open github
nnoremap gh :Gbrowse<CR>
vnoremap gh :Gbrowse<CR>
