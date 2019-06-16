" Navigation between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-u> <C-w>h
nnoremap <C-i> <C-w>l

" Resize splits easily
nnoremap <S-j> mm :resize +2<CR>`mh 
nnoremap <S-k> mm :resize -2<CR>`m
nnoremap <S-h> mm :vertical resize -2<CR>`m
nnoremap <S-l> mm :vertical resize +2<CR>`m

" Create new splits
nnoremap <leader>\ :vsp<CR>
nnoremap <leader>- :sp<CR>

" Close other splits
nnoremap <leader>o :only<CR> 

