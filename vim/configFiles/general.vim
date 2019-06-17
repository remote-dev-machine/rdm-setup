" Auto source vim files on save
augroup Reload_vimrc
	autocmd!
	autocmd BufWritePost *.vim* source $MYVIMRC | echom "Reloaded vim file..."
augroup END

" Show relative numbers with numberWidth = 5
set relativenumber
set numberwidth=5

" Escape out of insert mode with jk or kj 
inoremap jk <Esc>
inoremap kj <Esc>
vnoremap jk <Esc>
vnoremap kj <Esc>

" Stop using arrow keys
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>

" Soft tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Easier way to save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
highlight ColorColumn ctermbg=yellow
