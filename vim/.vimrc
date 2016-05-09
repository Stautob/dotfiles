" Include the pathogen plugins
call pathogen#infect()

let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" Enable mouse
set mouse=a

noremap <LeftDrag> <LeftMouse>
noremap! <LeftDrag> <LeftMouse>

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

" Multicursors do not quit on <ESC>
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0

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

"let g:jellybeans_background_color_256="none"
let g:molokai_original = 0

colorscheme molokai

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   guibg=red   ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=green ctermbg=234

" Hightlight trailing whitespace as errors
match Error /\s\+$/

" Basic indentation rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
