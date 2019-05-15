" Language: OpenGL Shading Language
" Maintainer: Sergey Tikhomirov <sergey@tikhomirov.io>

if exists("b:did_indent")
  finish
endif

function! GetCurrentIndent()
  "" indent shader 
  let lnum = line('.')
  if lnum < 2
    return cindent(lnum)
  endif 

  let lastIndentLine = lnum - 1
  let theIndent = cindent(lnum)
  let newIndent = indent(lastIndentLine)

  "" macro keep the same indent
  if getline(lnum) =~ '^\s*#'
    let theIndent = 0

  "" comment keep the same indent
  elseif getline(lnum) =~ '^\s*\(\/\/\|\*\|\/\*\)'
    "" next line is not empty
    if lnum < line('$') && getline(lnum + 1) !~ '^\s*$'     
      let lastIndentLine = lnum + 1
    else
      "" skip empty line.
      while lastIndentLine > 1 && getline(lastIndentLine) =~ '^\s*$' 
        let lastIndentLine = lastIndentLine - 1
      endwhile
    endif

    let newIndent = indent(lastIndentLine)

    echo 'comment L'   lnum   'indent'   theIndent   'L' lastIndentLine  'indent' newIndent   '| match'   getline(lnum) =~ '^\s*\(\/\/\|\*\|\/\*\)'

    let theIndent = newIndent
  endif

return theIndent
endfunction

setlocal autoindent cindent
setlocal formatoptions+=roq
setlocal indentexpr=GetCurrentIndent()



" vim:set sts=2 sw=2 :
