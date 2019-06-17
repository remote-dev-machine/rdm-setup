" Highlight search results
set hlsearch

" Find  next searched item as I type
set incsearch

" Ignore case by default for search
" Search can be made case sensitive by adding \C before text to be searched
set ignorecase

" Smart case search
set smartcase

" Substitute
nnoremap <leader>s :%s//g<left><left>
