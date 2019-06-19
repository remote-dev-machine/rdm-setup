" https://github.com/sickill/vim-monokai
 
if empty(glob('~/.vim/colors/monokai.vim'))
  silent !curl -fLo ~/.vim/colors/monokai.vim --create-dirs
    \ https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim 
endif

syntax enable
colorscheme monokai
