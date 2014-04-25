" Settings related to clang_complete

let g:clang_user_options="-I. -Iinclude -I../include -I../inc -I/opt/X11/include -I/usr/local/include -I/usr/pkg/include"
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_snippets=1
if system("uname")=="Darwin\n"
  let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"
endif
let g:clang_close_preview=1
let g:clang_periodic_quickfix=1
set concealcursor=inv
set conceallevel=2
