" vimrc — hand-rolled, replaces the generated vim-bootstrap config (2026-09-11).
" Plugin versions are recorded in ~/.vim/plugin-versions and reproducible via
" ~/.vim/plug.snapshot.vim (see :PlugSnapshot).

let &termencoding = &encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" ============================================================================
" vim-plug
" ============================================================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" --- interface / navigation ---
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" --- git ---
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" --- statusline / display ---
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'

" --- editing ---
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'Raimondi/delimitMate'

" --- python ---
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'kalekundert/vim-coiled-snake'
Plug 'Konfekt/FastFold'
Plug 'psf/black'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tartansandal/vim-compiler-pytest'
Plug 'mgedmin/coverage-highlight.vim'

" --- lint / LSP ---
Plug 'dense-analysis/ale'

" --- filetypes / tools ---
Plug 'tpope/vim-sleuth'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'aklt/plantuml-syntax'
Plug 'wannesm/wmgraphviz.vim'

" --- theme ---
Plug 'dracula/vim', { 'as': 'dracula' }

" REVIEW — kept for now; revisit whether actually used (migration note 2026-09-11):
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

call plug#end()

filetype plugin indent on
syntax on

" ============================================================================
" Core settings
" ============================================================================
set backspace=indent,eol,start
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set smarttab
set hidden
set history=1000
set scrolloff=5
set display=truncate
set colorcolumn=+1
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set switchbuf=useopen,split
set formatoptions+=j
set sessionoptions-=options
set viewoptions-=options

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac
if exists('$SHELL')
  set shell=$SHELL
else
  set shell=/bin/sh
endif

" Session management (vim-session)
let g:session_directory = '~/.vim/session'
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_command_aliases = 1

" ============================================================================
" Display
" ============================================================================
set ruler
set number
set wildmenu
set wildmode=list:longest,list:full
set laststatus=2
set title
set titlestring=%F
set modeline
set modelines=10
set mouse=a
set mousemodel=popup
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif
set autoread

" Clipboard
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Wildignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

" Filetype overrides
autocmd FileType text setlocal textwidth=78
augroup filetype
  au BufNewFile,BufRead *.inc   set ft=php
  au BufNewFile,BufRead *.ihtml set ft=html
  au BufNewFile,BufRead *.tac   set ft=python
  au BufNewFile,BufRead *.tpl   set ft=html
augroup END

" Correctly highlight $() and other modern affordances in filetype=sh.
if !exists('g:is_posix') && !exists('g:is_bash') && !exists('g:is_kornshell') && !exists('g:is_dash')
  let g:is_posix = 1
endif

" The matchit plugin makes the % command work better.
packadd! matchit

let g:debianfullname = 'Ralph Meijer'
let g:debianemail = 'ralphm@ik.nu'

" ============================================================================
" Theme
" ============================================================================
set background=dark
if (has('termguicolors'))
  set termguicolors
endif
colorscheme dracula
set guifont=Monospace\ 11

" ============================================================================
" vim-airline
" ============================================================================
let g:airline_theme = 'dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_symbols = {}
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" ============================================================================
" indentLine
" ============================================================================
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = ''
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" ============================================================================
" NERDTree
" ============================================================================
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder = ['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

" ============================================================================
" Tagbar
" ============================================================================
nnoremap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" ============================================================================
" fzf
" ============================================================================
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" ============================================================================
" ALE
" ============================================================================
let g:ale_linters = {}
:call extend(g:ale_linters, {'python': ['flake8'], })
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
let g:ale_python_auto_virtualenv = 1
let g:ale_completion_enabled = 1

if has('autocmd')
  function ALELSPMappings()
    let l:lsp_found = 0
    for l:linter in ale#linter#Get(&filetype) | if !empty(l:linter.lsp) | let l:lsp_found = 1 | endif | endfor
    if (l:lsp_found)
      nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>
      nnoremap <buffer> <C-^> :ALEFindReferences<CR>
    else
      silent! unmap <buffer> <C-]>
      silent! unmap <buffer> <C-^>
    endif
  endfunction
  autocmd BufRead,FileType * call ALELSPMappings()
endif

" ============================================================================
" jedi-vim (completion engine disabled; goto/rename via LSP where available)
" ============================================================================
let g:jedi#completions_enabled = 0
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = '<leader>g'
let g:jedi#goto_definitions_command = '<leader>d'
let g:jedi#documentation_command = 'K'
let g:jedi#usages_command = '<leader>n'
let g:jedi#rename_command = '<leader>r'
let g:jedi#show_call_signatures = '0'
let g:jedi#completions_command = '<C-Space>'
let g:jedi#smart_auto_mappings = 0

" ============================================================================
" UltiSnips (snippets)
" ============================================================================
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<c-b>'
let g:UltiSnipsEditSplit = 'vertical'

" ============================================================================
" Markdown
" ============================================================================
let g:markdown_fenced_languages = ['apache', 'bash', 'go', 'html', 'py=python', 'python', 'js=javascript', 'json', 'yaml']

" ============================================================================
" vim-coiled-snake (folding)
" ============================================================================
function! g:CoiledSnakeConfigureFold(fold)
  let a:fold.min_lines = 1

  if get(a:fold.parent, 'type', '') == ''
    let a:fold.num_blanks_below = 2
  endif

  " Only fold imports if there are at least 3 of them.
  elseif a:fold.type == 'import'
    let a:fold.min_lines = 3
  endif

  " If the whole program is shorter than 30 lines, don't fold anything.
  if line('$') < 30
    let a:fold.ignore = 1
  endif
endfunction

" ============================================================================
" Commands & functions
" ============================================================================
" Remove trailing whitespace
command! FixWhitespace :%s/\s\+$//e

" Convenient command to see the difference between the current buffer and the
" file it was loaded from.
if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

function! s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=79
endfunction

" ============================================================================
" Autocmd rules
" ============================================================================
" The PC is fast enough, do syntax highlight syncing from start unless 200 lines.
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

" Remember cursor position (exclude commit messages).
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
augroup END

" Plain text wrapping.
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" Python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END
let python_highlight_all = 1

" ============================================================================
" Mappings
" ============================================================================
" Leader
let mapleader = ','

" Search centering
nnoremap n nzzzv
nnoremap N Nzzzv
" Clear search highlight (also on Ctrl-L: clear + diff update below)
nnoremap <silent> <leader><space> :noh<CR>

" Splits
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Buffers
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>
noremap <leader>c :bd<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
noremap <Leader>te :tabe <C-R>=expand('%:p:h') . '/' <CR>

" Set working directory to current file's
nnoremap <leader>. :lcd %:p:h<CR>

" Terminal
nnoremap <silent> <leader>sh :terminal<CR>

" Window switching
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Maintain visual mode after indenting / shifting
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Git (fugitive)
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Git commit --verbose<CR>
noremap <Leader>gsh :Git push<CR>
noremap <Leader>gll :Git pull<CR>
noremap <Leader>gs :Git<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gd :Gvdiffsplit<CR>
noremap <Leader>gr :GRemove<CR>

" Package clipboard
noremap <leader>p "+gP<CR>

" Sessions (vim-session)
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" fzf
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
nmap <leader>y :History:<CR>

" Open current line on GitHub
nnoremap <Leader>o :.GBrowse<CR>

" Abbreviations
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" ============================================================================
" Terminal behaviour
" ============================================================================
" Fix window resize in kitty: vim's GPM fallback disables SIGWINCH.
if $TERM == 'xterm-kitty'
  set ttymouse=sgr
endif

" Typing responsiveness: repaint only when pausing, snappier Esc, faster hold.
set lazyredraw
set ttimeoutlen=50
set updatetime=300

" ============================================================================
" Misc
" ============================================================================
" CTRL-U in insert mode deletes a lot; break undo so it can be undone.
inoremap <C-U> <C-G>u<C-U>

" Also clear search highlight and update the diff when clearing the screen.
nnoremap <c-l> :nohlsearch<cr>:diffupdate<cr><c-l>

" Diff colours
hi DiffChange guibg=DarkMagenta
hi DiffAdd guibg=DarkBlue
hi DiffDelete guibg=DarkCyan