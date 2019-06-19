" https://github.com/vim-syntastic/syntastic

Plug 'vim-syntastic/syntastic'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_signs = 1

" Javascript checkers
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_es6_checkers = ['eslint']
let g:syntastic_js_checkers = ['eslint']
