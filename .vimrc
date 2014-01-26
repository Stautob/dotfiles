" Include the pathogen plugins
call pathogen#infect()

" Automatically reload vimrc on changes
autocmd! bufwritepost .vimrc source %

" Automatically strip trailing whitespace from certain files
autocmd FileType c,cpp,java,python autocmd BufWritePre <buffer> :%s/\s\+$//e

" Automatically disable paste mode when leavin insert mode
autocmd InsertLeave * set nopaste

" Include custom mappings
source ~/.vim/.vimmappings

" :W saves using sudo
command! W w !sudo tee % > /dev/null

" Enable filetype related plugins
filetype plugin indent on

" Syntax highlighting on
syntax on

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
set expandtab
set shiftwidth=2
set autoindent

" C++ indentation
set cino=f1s,{1s,}0,l1,b,b0,h1s,i1s,t0,>1s,:1s,(1s

" Java indentation
autocmd FileType java set cino=f1s,{1s,}0,l1,b,b0,h1s,i1s,t0,>1s,:1s,(1s

" Settings related to clang_complete
let g:clang_user_options="-I. -Iinclude -I../include -I../inc"
autocmd FileType c let g:clang_user_options .= "-std=c99"     " when editing C files, force The c99 standard
autocmd FileType cpp let g:clang_user_options .= "-std=c++11" " when editing C++ files, force the C++11 standard
let g:clang_complete_auto = 1
let g:clang_complete_copen = 1
let g:clang_snippets=1
if has('mac')
  let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"
endif
let g:clang_close_preview=1
let g:clang_periodic_quickfix=1
set concealcursor=inv
set conceallevel=2

" Use nice symbols in airline
let g:airline_powerline_fonts = 1

