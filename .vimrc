"---------------------------
" General Settings
"---------------------------
let mapleader = "\<Space>"
set encoding=utf-8
scriptencoding
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
set ambiwidth=double
set backspace=start,eol,indent
set bs=2
set expandtab
set guioptions-=T
set hidden
set hlsearch
set virtualedit=all
set incsearch
set laststatus=2
set nocompatible
set ruler
set shiftwidth=2
set statusline=%F%r%h%=
set showmatch
set tabstop=2
set softtabstop=2
set showcmd
set smartcase
set vb t_vb=
set whichwrap=b,s,[,],<,>,~
set number
set noswapfile
set nrformats=
set cindent
nnoremap Y y$
set display=lastline
set pumheight=10
set showmatch
set matchtime=1
set wrap
set wildmode=longest:full,full
set ignorecase
nnoremap + <C-a>
nnoremap - <C-x>
nmap <ESC><ESC> :nohlsearch<CR><ESC>
runtime macros/matchit.vim
cabbr w!! w !sudo tee > /dev/null %
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END
filetype plugin indent on
autocmd QuickFixCmdPost *grep* cwindow

"---------------------------
"" Simple commands.
"---------------------------
command! Rv source $MYVIMRC
command! Ev edit $MYVIMRC
command! Edv edit $HOME/dotfiles/.vimrc

"---------------------------
"" Vim-Plug Settings.
"---------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin()
Plug 'jbgutierrez/vim-babel', { 'for': 'javascript' }
Plug 'mattn/webapi-vim'
" Plug 'jpo/vim-railscasts-theme'
" Plug 'flowtype/vim-flow', {'for': 'javascript'}
" Plug 'w0ng/vim-hybrid'
Plug 'tomasr/molokai'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Townk/vim-autoclose'
Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }
Plug 'roxma/SimpleAutoComplPop'
Plug 'scrooloose/syntastic'
Plug 'Shougo/unite.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/vimproc', {'do' : 'make'}
" Plug 'Shougo/vimproc', {
"   \ 'build' : {
"     \ 'windows' : 'make -f make_mingw32.mak',
"     \ 'cygwin' : 'make -f make_cygwin.mak',
"     \ 'mac' : 'make -f make_mac.mak',
"     \ 'unix' : 'make -f make_unix.mak',
"   \ },
" \ }
Plug 'LeafCage/yankround.vim'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }
Plug 'mhinz/vim-startify'
Plug 'Shougo/neocomplete.vim'
Plug 'itchyny/lightline.vim'
Plug 'soramugi/auto-ctags.vim'
" Plug 'jelera/vim-javascript-syntax', { 'for': ['javascript','html'] }
Plug 'ruanyl/vim-fixmyjs', { 'for': ['javascript'] }
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/simple-javascript-indenter', { 'for': ['javascript','html'] }
Plug 'mattn/jscomplete-vim', { 'for': 'javascript' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'szw/vim-tags'
Plug '907th/vim-auto-save'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'lambdalisue/vim-unified-diff'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'koron/vim-gosrc', { 'for': 'go' }
Plug 'tpope/vim-abolish'
Plug 'Lokaltog/vim-easymotion'
Plug 'vimtaku/hl_matchit.vim'
Plug 'osyo-manga/vim-over'
" Plug 'leafgarland/typescript-vim', {
" \ 'autoload' : {
" \   'filetypes' : ['typescript'],
" \ }
" \}
Plug 'jason0x43/vim-js-indent', { 'for': 'javascript' }
" Plug 'Quramy/tsuquyomi'
Plug 'othree/yajs.vim', { 'for': ['javascript', 'html'] }
" Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'jsx'] }
Plug 'mtscout6/syntastic-local-eslint.vim', { 'for': ['javascript', 'jsx'] }
Plug 'tomtom/tcomment_vim'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'rhysd/vim-operator-surround'
Plug 'thinca/vim-qfreplace'
Plug 'tpope/vim-fugitive'
call plug#end()

"-------------------------
" Color Scheme
"-------------------------
syntax on
colorscheme molokai
autocmd colorscheme molokai highlight Visual ctermbg=8
highlight Normal ctermbg=none

"-------------------------
" Unite Settings
"-------------------------
let g:unite_enable_split_vertically = 1
:map <C-p> :Unite yankround<Return>

"-------------------------
" Unite with ag
"-------------------------
let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

"-------------------------
" neocomplete
"-------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
   \ 'default' : '',
   \ 'vimshell' : $HOME.'/.vimshell_hist',
   \ 'php' : $HOME.'/.vim/dictionaries/php.dict',
   \ 'scheme' : $HOME.'/.gosh_completions'
   \ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
 let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
 return neocomplete#close_popup() . "\<CR>"
 " For no inserting <CR> key.
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
" For cursor moving in insert mode(Not recommended)
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1
" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1
" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"-------------------------
" syntax check
"-------------------------
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_enable_highlighting = 1
let g:syntastic_php_php_args = '-l'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"-------------------------
" lightline
"-------------------------
let g:lightline = {'colorscheme': 'landscape'}
set laststatus=2
if !has('gui_running')
set t_Co=256
endif

"-------------------------
" ctags
"-------------------------
let g:auto_ctags = 1
set tags+=.git/tags
let g:auto_ctags_directory_list = ['.git']
let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes --format=2'

"-------------------------
" tagbar
"-------------------------
nmap <silent> <C-a>      :TagbarToggle<CR>
vmap <silent> <C-a> <Esc>:TagbarToggle<CR>
omap <silent> <C-a>      :TagbarToggle<CR>
imap <silent> <C-a> <Esc>:TagbarToggle<CR>
cmap <silent> <C-a> <C-u>:TagbarToggle<CR>

"-------------------------
" auto save
"-------------------------
let g:auto_save = 0
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

"-------------------------
" NERDTree
"-------------------------
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeShowHidden=1
" let file_name = expand("%:p")
" if has('vim_starting') &&  file_name == ""
"     autocmd VimEnter * execute 'NERDTree ./'
" endif
let NERDTreeIgnore = ['node_modules','.git']
let g:NERDTreeChDirMode = 2

"-------------------------
" NERDTree
"-------------------------
" Plugin key-mappings.
imap <C-s>     <Plug>(neosnippet_expand_or_jump)
smap <C-s>     <Plug>(neosnippet_expand_or_jump)
xmap <C-s>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"-------------------------
" vimdiff
"-------------------------
set diffexpr=unified_diff#diffexpr()
" configure with the followings (default values are shown below)
let unified_diff#executable = 'git'
let unified_diff#arguments = [
      \   'diff', '--no-index', '--no-color', '--no-ext-diff', '--unified=0',
      \ ]
let unified_diff#iwhite_arguments = [
      \   '--ignore--all-space',
      \ ]

"-------------------------
" incsearch
"-------------------------
"map /  <Plug>(incsearch-forward)
"map ?  <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)

"-------------------------
" easymotion
"-------------------------
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
let g:EasyMotion_leader_key=";"
let g:EasyMotion_grouping=1

"-------------------------
" visualmark.vim
"-------------------------
" http://nanasi.jp/articles/vim/visualmark_vim.html
"map <unique> <F3> <Plug>Vm_toggle_sign
"map <silent> <unique> mm <Plug>Vm_toggle_sign

"-------------------------
" TypeScript
"-------------------------
let g:js_indent_typescript = 1
let g:tsuquyomi_definition_split = 3
"let g:typescript_compiler_options = '--module commonjs --target ES5 --noImplicitAny'

"-------------------------
" for hl_matchit
"-------------------------
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft = 'vim\|ruby\|sh\|php\|javascript\|go'

"-------------------------
" vim-go
"-------------------------
let g:go_bin_path = expand(globpath($GOPATH, "bin"))
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "gofmt"
let g:go_disable_autoinstall = 0
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

"-------------------------
" tab control
"-------------------------
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2
" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" Tab map
map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>

"-------------------------
" roxma/SimpleAutoComplPop
"-------------------------
autocmd FileType go call sacp#enableForThisBuffer({ "matches": [
  \ { '=~': '\v[a-zA-Z]{4}$' , 'feedkeys': "\<C-x>\<C-o>"} ,
  \ { '=~': '\.$'            , 'feedkeys': "\<C-x>\<C-o>", "ignoreCompletionMode":1} ,
  \ ]
  \ })

"-------------------------
" jsx
"-------------------------
let g:jsx_ext_required = 1        " ファイルタイプがjsxのとき読み込む．
let g:jsx_pragma_required = 0     " @から始まるプラグマでは読み込まない．
augroup Vimrc
  autocmd!
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

"-------------------------
" emmet
"-------------------------
let g:user_emmet_leader_key='<c-u>'
let g:user_emmet_mode='i'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

"-------------------------
" eslint
"-------------------------
let g:syntastic_javascript_checkers=['eslint']

"-------------------------
" startify
"-------------------------
let g:startify_files_number = 5
let g:startify_list_order = [
        \ ['♻  最近使ったファイル:'],
        \ 'files',
        \ ['♲  最近使ったファイル(カレントディレクトリ下):'],
        \ 'dir',
        \ ['⚑  セッション:'],
        \ 'sessions',
        \ ['☺  ブックマーク:'],
        \ 'bookmarks',
        \ ]
let g:startify_bookmarks = ["~/.vimrc", "~/.gvimrc"]
function! s:filter_header(lines) abort
    let longest_line   = max(map(copy(a:lines), 'len(v:val)'))
    let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction

"-------------------------
" easy-align
"-------------------------
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"-------------------------
" operetor-user
"-------------------------
nmap s <Plug>(operator-replace)
map <silent> sa <Plug>(operator-surround-append)
map <silent> sd <Plug>(operator-surround-delete)
map <silent> sr <Plug>(operator-surround-replace)

"-------------------------
" env
"-------------------------
if has("mac")
" mac用の設定
elseif has("unix")
" unix固有の設定
elseif has("win64")
" 64bit_windows固有の設定
elseif has("win32unix")
" Cygwin固有の設定
elseif has("win32")
" 32bit_windows固有の設定
endif
