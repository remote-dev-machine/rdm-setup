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

" Open new split panes to right and bottom
set splitbelow
set splitright

" Re-balance splits on vim resize
autocmd VimResized * :wincmd =
