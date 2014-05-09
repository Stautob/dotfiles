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
autocmd FileType c,cpp,java,python autocmd BufWritePre <buffer> :%s/\s\+$//e

" Automatically disable paste mode when leavin insert mode
autocmd InsertLeave * set nopaste

" :W saves using sudo
command! W w !sudo tee % > /dev/null

" Enable filetype related plugins
filetype plugin indent on

" Syntax highlighting on
syntax on

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

" Set the theme for dark backgrounds
colorscheme jellybeans

" Hightlight trailing whitespace as errors
match Error /\s\+$/

" Basic indentation rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
