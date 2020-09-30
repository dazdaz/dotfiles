nmap <C-q> :Vista!!<CR>

let g:vista_default_executive = 'ctags'

let g:vista_executive_for = {
  \ 'rust': 'vim_lsp',
  \ 'python': 'vim_lsp',
  \ 'go': 'vim_lsp',
  \ 'vim': '',
  \ }

let g:vista_sidebar_width = 48

