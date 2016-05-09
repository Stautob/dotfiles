" Set the leader key to , for easier access
let mapleader=","

" move lines up and down in normal mode
nnoremap <up> :m .-2<CR>==
nnoremap <down> :m .+1<CR>==

" do rather scroll than move lines with scrollwheel
noremap <ScrollWheelUp> 5gk
noremap <ScrollWheelDown> 5gj
" smooth scroll
noremap <A-ScrollWheelUp> gk
noremap <A-ScrollWheelDown> gj

" indent lines in normal mode
nnoremap <left> <<
nnoremap <right> >>

" Move blocks up and down in visual mode
vnoremap <up> :m '<-2<CR>gv=gv
vnoremap <down> :m '>+1<CR>gv=gv

" Don't do anything in insert mode with the arrow keys
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" move "file lines" not "display lines"
nnoremap j gj
nnoremap k gk

" Quickly insert lines above or under "without" entering insert mode
nnoremap <Leader>o o<ESC>
nnoremap <Leader>O O<ESC>

" Quickly insert line above or below during insert mode
inoremap <Leader>o <ESC>o
inoremap <Leader>O <ESC>O

" Clear search-highlighting with L-Space
nnoremap <Leader><Space> :noh<CR>

" Don't lose selection when indendint in visual mode
vnoremap < <gv
vnoremap > >gv

" Toggle "cursor-centering"
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" ------------------------------
" Function key mappings
" ------------------------------

" Press F2 for toggling the NERDtree
nnoremap <F2> :NERDTreeToggle<CR>
inoremap <F2> <ESC>:NERDTreeToggle<CR>

" Press F3 for paste mode
set pastetoggle=<F3>

" Press F4 for toggling the Eclim ProjectTree
nnoremap <F4> :ProjectTreeToggle<CR>
inoremap <F4> <ESC>:ProjectTreeToggle<CR>

" Press F6 to reindent the hole file
map <F6> mzgg=G`zmz

nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>gl :GitGutterLineHighlightsToggle<CR>
