setlocal nolisp
setlocal noautoindent

setlocal indentexpr=GetCppIndent(v:lnum)

if exists("*GetCppIndent")
  finish
endif

function! GetCppIndent(lnum)
  let cindent = cindent(a:lnum)
  if a:lnum == 1 | return cindent | endif

  let pattern2 = 'namespace\s\+\S\+\s*{\s*\p*class\s\+\S\+\s*:\s*[^{]'
  let lines = join(getline(max(a:lnum-10, 1), a:lnum-1), ' ')
  
"  if  lines =~ pattern2 && getline(a:lnum) =~ '^\s*{'
"    return (indent(CppFindOccurence('class', a:lnum)) + 4)
"  else
    return cindent(a:lnum)
"  endif
endfunction

function! CppFindOccurence(pattern, lnum)
  for line in range(a:lnum+1,a:lnum-10,-1)
    if getline(line) =~ a:pattern
      return line
    endif
  endfor
  return -1
endfunction
