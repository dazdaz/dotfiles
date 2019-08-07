"---------------------------
"" General
"---------------------------
syntax on
set background=dark
set encoding=utf8
set sh=zsh
set secure
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp,
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
set display=lastline
set pumheight=10
set showmatch
set matchtime=1
set wrap
set wildmode=longest:full,full
set ignorecase
set completeopt=noinsert,menuone,noselect
set wildmenu
set history=5000
set guifont=Cica:h15
set inccommand=split
set list
" 不可視文字を可視化する場合は以下をアンコメント
" set listchars=tab:^-,trail:-,extends:»,precedes:«,nbsp:%
filetype plugin indent on
scriptencoding utf-8

"" Clipboard
if has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamed,unnamedplus
endif

"" Resolve PATH
function! s:configure_path(name, pathlist) abort
  let path_separator = ':'
  let pathlist = split(expand(a:name), path_separator)
  for path in map(filter(a:pathlist, '!empty(v:val)'), 'expand(v:val)')
    if isdirectory(path) && index(pathlist, path) == -1
      call insert(pathlist, path, 0)
    endif
  endfor
  execute printf('let %s = join(pathlist, ''%s'')', a:name, path_separator)
endfunction
call s:configure_path('$PATH', [
    \ '/usr/local/bin',
    \])
call s:configure_path('$MANPATH', [
    \ '/usr/local/share/man/',
    \ '/usr/share/man/',
    \])

"" Fix python version
function! s:pick_executable(pathspecs) abort
  for pathspec in filter(a:pathspecs, '!empty(v:val)')
    for path in reverse(glob(pathspec, 0, 1))
      if executable(path)
        return path
      endif
    endfor
  endfor
  return ''
endfunction
let g:python_host_prog = s:pick_executable([
      \ '/usr/local/bin/python2',
      \ '/home/linuxbrew/.linuxbrew/bin/python2',
      \ '/usr/bin/python2',
      \ '/bin/python2',
      \])
let g:python3_host_prog = s:pick_executable([
      \ '/usr/local/bin/python3',
      \ '/home/linuxbrew/.linuxbrew/bin/python3',
      \ '/usr/bin/python3',
      \ '/bin/python3',
      \])

"" leader mapping
let mapleader = "\<Space>"
tnoremap <ESC> <C-\><C-n>
nnoremap cn *Ncgn
nnoremap cN *NcgN
nnoremap <Leader>%s  :%s/\v
nmap <ESC><ESC> :nohlsearch<CR><ESC>
map <C-g> :echo expand('%:p')<Return>
nnoremap <Leader>co :copen<cr>
nnoremap <Leader>cl :cclose<cr>
nnoremap <expr> <Leader>a (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Ag\<cr>"
nnoremap <expr> <Leader>x (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Commands\<cr>"
nnoremap <expr> <Leader>f (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <expr> <Leader>d (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":GFiles?\<cr>"
nnoremap <expr> <Leader>b (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Buffers\<cr>"
nnoremap <expr> <Leader>h (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":History:\<cr>"
nnoremap <expr> <Leader>r (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Ripgrep\<cr>"
nnoremap <expr> <Leader>w (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Windows\<cr>"
nnoremap <Leader>gm :Gmerge<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gca :Gcommit -a -m "
nnoremap <Leader>gps :Dispatch! git push origin<cr>
nnoremap <Leader>gpl :Dispatch! git pull origin<cr>
nnoremap <Leader>t :new \| :terminal<CR>
nnoremap <Leader>T :tabnew \| :terminal<CR>
nnoremap <Leader>vt :vne \| :terminal<CR>
nnoremap <Leader>n :ALENextWrap<CR>
nnoremap <Leader>got :GoToggleBreakpoint<CR>
nnoremap <Leader>god :GoDebug<CR>
map <C-]> :tab <CR>:exec("tjump ".expand("<cword>"))<CR>
map <leader><C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

nnoremap <C-x>sc :<C-u>call <SID>change_case("sc")<CR>
nnoremap <C-x>sk :<C-u>call <SID>change_case("sk")<CR>
nnoremap <C-x>cs :<C-u>call <SID>change_case("cs")<CR>
nnoremap <C-x>ck :<C-u>call <SID>change_case("ck")<CR>
nnoremap <C-x>kc :<C-u>call <SID>change_case("kc")<CR>
nnoremap <C-x>ks :<C-u>call <SID>change_case("ks")<CR>

"" change case (snake,camel,kebab)
function! s:change_case(v1, ...)
  let t = a:v1
  let p = getpos(".")
  if t == "sc"
    let s = substitute(expand("<cword>"), "_\\(.\\)", "\\u\\1", "g")
    execute ":normal diw"
  elseif t == "sk"
    let s = substitute(expand("<cword>"), "_", "-", "g")
    execute ":normal diw"
  elseif t == "cs"
    let s = substitute(expand("<cword>"), "\\(\\u\\)", "_\\l\\1", "g")
    execute ":normal diw"
  elseif t == "ck"
    let s = substitute(expand("<cword>"), "\\(\\u\\)", "-\\l\\1", "g")
    execute ":normal diw"
  elseif t == "kc"
    let s = substitute(expand("<cWORD>"), "-\\(.\\)", "\\u\\1", "g")
    execute ":normal diW"
  elseif t == "ks"
    let s = substitute(expand("<cWORD>"), "-", "_", "g")
    execute ":normal diW"
  endif
  execute ":normal i" . s
  call setpos(".", p)
endfunction

"" autocmd
autocmd BufWritePre * :%s/\s\+$//ge
autocmd VimEnter * nested if @% != '' | :NERDTreeFind | wincmd p | endif
autocmd InsertLeave * set nopaste
autocmd QuickFixCmdPost *grep* cwindow
autocmd Filetype json setl conceallevel=0
" cnahge from rustc to cargo run when quickrun
let g:quickrun_config = {}
autocmd BufNewFile,BufRead *.rs  let g:quickrun_config.rust = {'exec' : 'cargo run'}
"" augroup
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END
augroup FiletypeGroup
  autocmd!
  au BufNewFile,BufRead *.yml.j2,*.yaml.j2 set ft=yaml " or, set ft=ansible by vim-ansible-yaml plugin
  au BufNewFile,BufRead *.conf,*.conf.j2 set ft=conf
augroup END

"" custom commands
command! -nargs=* -complete=file Rg :tabnew | :silent grep --sort-files <args>
command! -nargs=* -complete=file RgfastUnsort :tabnew | :silent grep <args>
command! -bang -nargs=* Ripgrep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview({'options': '--exact --reverse --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
command! Rv source $MYVIMRC
command! Ev tabnew | edit $MYVIMRC
command! Edv edit $HOME/dotfiles/.vimrc
cabbr w!! w !sudo tee > /dev/null %

"" terminal colors
autocmd ColorScheme * hi LineNr ctermfg=239
autocmd ColorScheme * hi Normal ctermbg=none
if !has('gui_running')
      \ && exists('&termguicolors')
      \ && $COLORTERM ==# 'truecolor'
  if !has('nvim')
    let &t_8f = "\e[38;2;%lu;%lu;%lum"
    let &t_8b = "\e[48;2;%lu;%lu;%lum"
  endif
  set termguicolors
endif
let g:terminal_color_0  = "#1b2b34" "black
let g:terminal_color_1  = "#ed5f67" "red
let g:terminal_color_2  = "#9ac895" "green
let g:terminal_color_3  = "#fbc963" "yellow
let g:terminal_color_4  = "#669acd" "blue
let g:terminal_color_5  = "#c695c6" "magenta
let g:terminal_color_6  = "#5fb4b4" "cyan
let g:terminal_color_7  = "#c1c6cf" "white
let g:terminal_color_8  = "#65737e" "bright black
let g:terminal_color_9  = "#fa9257" "bright red
let g:terminal_color_10 = "#343d46" "bright green
let g:terminal_color_11 = "#4f5b66" "bright yellow
let g:terminal_color_12 = "#a8aebb" "bright blue
let g:terminal_color_13 = "#ced4df" "bright magenta
let g:terminal_color_14 = "#ac7967" "bright cyan
let g:terminal_color_15 = "#d9dfea" "bright white
let g:terminal_color_background="#1b2b34" "background
let g:terminal_color_foreground="#c1c6cf" "foreground

"---------------------------
"" Vim-Plug
"---------------------------
"" Settings
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin()
"" [general]
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'cohama/lexima.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Shougo/unite.vim'
Plug 'LeafCage/yankround.vim'
Plug 'osyo-manga/vim-anzu'
Plug 'tpope/vim-dispatch'
Plug 'itchyny/lightline.vim'
Plug 'soramugi/auto-ctags.vim'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'lambdalisue/vim-unified-diff'
Plug 'Lokaltog/vim-easymotion'
Plug 'tmhedberg/matchit'
Plug 'vimtaku/hl_matchit.vim'
Plug 'w0rp/ale'
Plug 'tomtom/tcomment_vim'
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-operator-surround'
Plug 'osyo-manga/vim-operator-stay-cursor'
Plug 'thinca/vim-qfreplace'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug '/usr/local/opt/fzf' " installed fzf via brew
Plug 'junegunn/fzf.vim'
Plug 'thinca/vim-quickrun'
" [lsp]
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" [html/css]
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'javascript'] }
" [php]
Plug 'lvht/phpcd.vim', { 'for': ['php'] }
" [go]
Plug 'tpope/vim-pathogen', { 'for': 'go' } " for vim-godebug
Plug 'jodosha/vim-godebug', { 'for': 'go' }
" [terraform]
Plug 'hashivim/vim-terraform', { 'for': ['tf', 'terraform'] }
" [dockerfile]
Plug 'ekalinin/Dockerfile.vim', { 'for': ['tf', 'Dockerfile'] }
call plug#end()



"---------------------------
"" Plugin configuration
"---------------------------
"" hybrid material theme
colorscheme hybrid_material

"" unite w/ yankround
let g:unite_enable_split_vertically = 1
nnoremap <C-p> :Unite -create -buffer-name=yankround yankround<Return>
let g:yankround_max_history = 80

"" vim-anzu
" mapping
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" statusline
set statusline=%{anzu#search_status()}

"" lsp w/ gopls
if executable('gopls')
  " let g:lsp_async_completion = 1
  let g:lsp_diagnostics_enabled = 0 " use ale to cieck errors
  augroup LspGo
    au!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'go-lang',
        \ 'cmd': {server_info->['gopls']},
        \ 'whitelist': ['go'],
        \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
  augroup END
endif

"" completion
" " deoplete
" let g:deoplete#enable_smart_case = 1
" let g:deoplete#enable_at_startup = 1
" inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
" inoremap <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function() abort
"   return deoplete#close_popup() . "\<CR>"
" endfunction

"" lightline
set laststatus=2
set t_Co=256
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = {
  \'colorscheme': 'wombat',
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['readonly', 'filename', 'modified'],
  \    ['ale'],
  \  ]
  \},
  \'component_function': {
  \  'ale': 'ALEStatus'
  \},
\}

"" ale
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_fixers = {
	\ 'go'   : ['goimports'],
  \ 'ruby': ['rubocop'],
  \ 'rust': ['rustfmt'],
\}
let g:ale_fix_on_save = 1
let g:ale_linters = {
  \ 'ruby' : ['rubocop','ruby'],
  \ 'yaml' : [''],
	\ 'go'   : ['golangci-lint'],
  \ 'rust' : ['rls'],
\}
let g:ale_go_golangci_lint_options = '--fast --enable-all -D errcheck'

"" auto-ctags / ctags
let g:auto_ctags = 0
let g:auto_ctags_directory_list = ['.git']
let g:auto_ctags_tags_args = '--tag-relative=yes --recurse --sort=yes --append=no --format=2'
let g:auto_ctags_filetype_mode = 1

"" tagbar
let g:tagbar_width = 60
nmap <C-a>      :TagbarToggle<CR>
vmap <C-a> <Esc>:TagbarToggle<CR>
omap <C-a>      :TagbarToggle<CR>
imap <C-a> <Esc>:TagbarToggle<CR>
cmap <C-a> <C-u>:TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_type_yaml = {
    \ 'ctagstype' : 'Yaml',
    \ 'kinds'     : [
        \ 'h:headers:0:1',
    \ ],
    \ 'sort'    : 0,
\ }
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'Markdown',
    \ 'kinds'     : [
        \ 'c:chapsters:0:1',
        \ 's:sections',
        \ 'S:subsections',
        \ 't:subsubsections',
        \ 'T:level 4 subsections:0:1',
        \ 'u:level 5 subsections:0:1',
        \ 'r:regex:1:0',
    \ ],
    \ 'sort'    : 0,
\ }

"" neosnippet
imap <C-s>     <Plug>(neosnippet_expand_or_jump)
smap <C-s>     <Plug>(neosnippet_expand_or_jump)
xmap <C-s>     <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"" vimdiff
set diffexpr=unified_diff#diffexpr()
let unified_diff#executable = 'git'
let unified_diff#arguments = [
      \   'diff', '--no-index', '--no-color', '--no-ext-diff', '--unified=0',
      \ ]
let unified_diff#iwhite_arguments = [
      \   '--ignore--all-space',
      \ ]

"" easymotion
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
let g:EasyMotion_leader_key=";"
let g:EasyMotion_grouping=1

"" for hl_matchit
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft = 'vim\|ruby\|sh\|php\|javascript\|go\|rust'

"" tab control
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
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
  execute 'nnoremap [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" Tab map
map [Tag]c :tablast <bar> tabnew<CR>
map [Tag]x :tabclose<CR>
map [Tag]n :tabnext<CR>
map [Tag]p :tabprevious<CR>

"" NERDTree
nnoremap <C-e> :NERDTreeToggle<cr>
let g:NERDTreeShowHidden=1
let NERDTreeIgnore = ['node_modules$','\.git$', "\.DS_Store$"]
let g:NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 45
let g:nerdtree_tabs_open_on_console_startup = 1
" highlight in NERDTree
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction
function! SyncNERDTree()
 if strlen(expand('%')) > 0 && &modifiable && IsNERDTreeOpen() && !&diff && !empty(&ft) && &ft != "quickrun" && &ft != "qfreplace"
   NERDTreeFind
   wincmd p
 endif
endfunction
autocmd BufEnter * call SyncNERDTree()

"" emmet
let g:user_emmet_leader_key='<C-Y>'
let g:user_emmet_mode='in'
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss,javascript EmmetInstall

"" operetor-user
map sa <Plug>(operator-surround-append)
map sd <Plug>(operator-surround-delete)
map sr <Plug>(operator-surround-replace)
map y <Plug>(operator-stay-cursor-yank)

"" vp doesn't replace paste buffer
map P "0p

"" ripgrep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

"" terraform
let g:terraform_fmt_on_save = 1


