" Vimrc
" This file loads the vim configurations from config files
" specified in configFiles/ folder.

" Specify that we will use Vim and not vi
set nocompatible

" Set a global <Leader>
let mapleader = "\<Space>"

" Source config files from /configFiles and /plugins
" Symlink the current directory to .vim
" ln -s absolute/path/to/vim/folder ~/.vim
function! s:SourceConfigFilesFrom(directory)
	let directory_wildcard = '~/.vim/' . a:directory . '/*'
	for config_file in split(glob(directory_wildcard), '\n')
		if filereadable(config_file)
			execute 'source' config_file
		endif
	endfor
endfunction

call s:SourceConfigFilesFrom('configFiles')
