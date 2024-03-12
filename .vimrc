" vimrc

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

let &termencoding = &encoding
set encoding=utf-8

if has("python3")
  py3 import sys,os; sys.path.append(os.path.expanduser("~/.vim/"))
  py3 import vindect
endif

let python_highlight_all=1

set smarttab

set listchars=tab:>-,trail:-
set switchbuf=useopen,split
set wildmode=list:longest,full
set colorcolumn=+1	" Show vertical bar at textwidth+1
set modeline

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

if !has("gui_running")
  set background=dark
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  "set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup filetype
    au BufNewFile,BufRead *.inc   set ft=php
    au BufNewFile,BufRead *.ihtml set ft=html
    au BufNewFile,BufRead *.tac   set ft=python
    au BufNewFile,BufRead *.tpl   set ft=html
  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

let g:debianfullname="Ralph Meijer"
let g:debianemail="ralphm@ik.nu"

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
let g:ale_python_auto_virtualenv = 1
let g:ale_completion_enabled = 1

if has("autocmd")
	function ALELSPMappings()
		let l:lsp_found=0
		for l:linter in ale#linter#Get(&filetype) | if !empty(l:linter.lsp) | let l:lsp_found=1 | endif | endfor
		if (l:lsp_found)
			nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>
			nnoremap <buffer> <C-^> :ALEFindReferences<CR>
		else
			silent! unmap <buffer> <C-]>
			silent! unmap <buffer> <C-^>
		endif
	endfunction
	autocmd BufRead,FileType * call ALELSPMappings()
endif " has("autocmd")

let g:markdown_fenced_languages = ['apache', 'bash', 'go', 'html', 'py=python', 'python', 'js=javascript', 'json', 'yaml']

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
