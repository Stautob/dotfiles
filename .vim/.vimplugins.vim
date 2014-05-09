" This is the plugin configuration for vim

" 'indent-guides' configuration
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" 'airline' configuration
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 0
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }
let g:airline#extensions#eclim#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" 'youcompleteme' configuration
let g:ycm_enable_diagnostic_signs = 0
