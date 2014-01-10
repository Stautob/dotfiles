" Include the pathogen plugins
call pathogen#infect()

" Force use of "right" move keys hjkl
nnoremap <up> :m .-2<CR>==
nnoremap <down> :m .+1<CR>==
nnoremap <left> <<
nnoremap <right> >>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Quickly insert lines above or under "without" entering insert mode
nnoremap <Leader>o o<ESC>
nnoremap <Leader>O O<ESC>

" Better indentation in visual mode
vnoremap < <gv
vnoremap > >gv

" Automatically reload vimrc on changes
autocmd! bufwritepost .vimrc source %

" Automatically strip trailing whitespace from certain files
autocmd FileType c,cpp,java,python autocmd BufWritePre <buffer> :%s/\s\+$//e

" Automatically disable paste mode when leavin insert mode
autocmd InsertLeave * set nopaste

" :W saves using sudo
command! W w !sudo tee % > /dev/null

" Set the leader key to , for easier access
let mapleader=","

" Syntax highlighting on
syntax on

" Highlight the search term
set hlsearch
set incsearch
set showmatch

" Basic indentation rules
set tabstop=2
set expandtab
set shiftwidth=2
set autoindent

" Show the cursor position
set ruler
set cursorline

" Keep the cursor horizontally centered when possible
set scrolloff=999
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Show line numbers
set number
set laststatus=2

" Set the theme for dark backgrounds
colorscheme jellybeans
" set background=dark

" Press F5 for paste mode
set pastetoggle=<F3>

" Press F2 for toggling the NERDtree
map <F2> :NERDTreeToggle<CR>

" Enable filetype related plugins
filetype plugin indent on
match Error /\s\+$/

" Settings related to clang_complete
let g:clang_user_options="-Iinclude -I../include -std=c++11"
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_snippets=1
if has('mac')
  let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"
endif
let g:clang_close_preview=1
let g:clang_periodic_quickfix=1

" C++ indentation
set cino=f1s,{1s,}0,l1,b,b0,h1s,i1s,t0,>1s,:1s,(1s

set concealcursor=inv
set conceallevel=2

nnoremap <Leader><Space> :noh<CR>
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>gl :GitGutterLineHighlightsToggle<CR>
