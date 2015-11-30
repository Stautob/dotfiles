" Include the pathogen plugins
call pathogen#infect()

" Include custom mappings
runtime .vimmappings.vim

" Include project custom settings
runtime .vimprojects.vim

" Include plugin settings
runtime .vimplugins.vim

" Automatically reload vimrc on changes
autocmd! bufwritepost .vimrc source %

" Automatically strip trailing whitespace from certain files
autocmd FileType c,cpp,java,python,fish autocmd BufWritePre <buffer> :%s/\s\+$//e

" Automatically disable paste mode when leavin insert mode
autocmd InsertLeave * set nopaste

" :W saves using sudo
command! W w !sudo tee % > /dev/null

" Enable filetype related plugins
filetype plugin indent on
set foldmethod=syntax
set foldlevel=99

" Syntax highlighting on
syntax on

" indent on
filetype plugin indent on

" Disable vi compatibility mode
set nocompatible

" Set /tmp as the directory for swap files
set backupdir=/var/tmp
set directory=/var/tmp

" Highlight the search term while typing
set hlsearch
set incsearch
set showmatch

" Show the cursor position
set ruler
set cursorline

" Keep the cursor horizontally centered when possible
set scrolloff=999

" Show line numbers
set number
set laststatus=2
set numberwidth=3

"set t_Co=256
" Set the theme for dark backgrounds
let g:jellybeans_overrides = {
\  'Normal': {
\    '256ctermbg': 'none',
\  },
\  'NonText': {
\    '256ctermbg': 'none',
\  },
\}
"\  'Normal': {
"\    '256ctermbg': 'none',
"\  },
"\  'LineNr': {
"\    '256ctermbg': 'none',
"\  },
"\  'SpecialKey': {
"\    '256ctermbg': 'none',
"\  },
"\  'MatchParen': {
"\    '256ctermbg': 'none',
"\    'attr': 'bold',
"\  },
"\  'IncSearch': {
"\    '256ctermbg': 'none',
"\    'attr': 'bold',
"\  },
"\  'VertSplit': {
"\    '256ctermbg': 'none',
"\  },
"\  'Visual': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '240',
"\  },
"\  'Folded': {
"\    '256ctermbg': 'none',
"\  },
"\  'FoldColumn': {
"\    '256ctermbg': 'none',
"\  },
"\  'DiffAdd': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '22',
"\  },
"\  'DiffChange': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '24',
"\  },
"\  'DiffDelete': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '52',
"\  },
"\  'DiffText': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '81',
"\  },
"\  'SignColumn': {
"\    '256ctermbg': 'none',
"\  },
"\  'Conceal': {
"\    '256ctermbg': 'none',
"\  },
"\  'SpellBad': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '88',
"\  },
"\  'SpellCap': {
"\    '256ctermbg': 'none',
"\    '265ctermfg': '20'
"\  },
"\  'SpellRare': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '53',
"\  },
"\  'SpellLocal': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '23',
"\  },
"\  'Pmenu': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '240',
"\  },
"\  'PmenuSel': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '254',
"\  },
"\  'PmenuSbar': {
"\    '256ctermbg': 'none',
"\  },
"\  'PmenuThumb': {
"\    '256ctermbg': 'none',
"\  },
"\  'TabLine': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '145',
"\  },
"\  'TabLineSel': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '254',
"\  },
"\  'CursorColumn': {
"\    '256ctermbg': 'none',
"\  },
"\  'ColorColumn': {
"\    '256ctermbg': 'none',
"\  },
"\  'DbgBreakPt': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '53',
"\  },
"\  'IndentGuidesOdd': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '235',
"\  },
"\  'IndentGuidesEven': {
"\    '256ctermbg': 'none',
"\    '256ctermfg': '234',
"\  },
"\  'PreciseJumpTarget': {
"\    '256ctermbg': 'none',
"\  },
"\}

"let g:jellybeans_background_color_256="none"

colorscheme jellybeans

" Hightlight trailing whitespace as errors
match Error /\s\+$/

" Basic indentation rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
