" https://github.com/prettier/vim-prettier

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Format on save
let g:prettier#autoformat = 0

" single quotes over double quotes
" " Prettier default: false
let g:prettier#config#single_quote = 'true'

" none|es5|all
" " Prettier default: none
let g:prettier#config#trailing_comma = 'all'

" Running before saving, changing text or leaving insert mode:
"
" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
