set spell
set spelloptions=camel

syntax match typescriptVariableDeclaration /[A-Za-z_$]\k*/
  \ contains=@Spell
  \ nextgroup=typescriptTypeAnnotation,typescriptAssign
  \ contained skipwhite skipempty
syntax match typescriptVariableDeclaration /[A-Za-z_$]\k*/
  \ contains=@Spell

syntax match typescriptIdentifierName /\<\K\k*/ 
            \ transparent contains=@Spell,@_semantic
            \ nextgroup=@afterIdentifier skipwhite skipnl 

syntax match typescriptDestructureVariable /[A-Za-z_$]\k*/ 
            \ contains=@Spell
            \ contained nextgroup=typescriptDefaultParam skipwhite skipempty 

" syntax region tsxClassNameString
"       \ start=/className\\="/ skip=/\\"/ end=/"/ 
"       \ display contained contains=tsxEntity

syntax region  jsxClassName
  \ start=+\z(className["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ end=+$+
  " \ contains=typescriptSpecial
  " \ nextgroup=@typescriptSymbols
  " \ skipwhite skipempty
  " \ extend
  "


" Remove spell checking on jsx classNames
" <tag className={this.props.key}>
"      ~~~
syntax match tsxAttrib
    \ /className/
    \ nextgroup=tsxClassNameEqual skipwhite
    \ contained
    \ display
" <tag id="sample">
"        ~
syntax match tsxClassNameEqual +=+ display contained
  \ nextgroup=tsxClassString skipwhite
" <tag id="sample">
"         s~~~~~~e
syntax region tsxClassString contained start=+"+ skip=+\\"+ end=+"+
      \ contains=tsxEntity display
syntax region tsxClassString contained start=+'+ skip=+\\'+ end=+'+ 
      \ contains=tsxEntity display


set include=^\\s*import.*from "\\zs[\@\|.].*\\ze"

let s:debug = 0

function! Log(text)
  if s:debug 
    echo a:text
  endif
endfunction

function! FindTSorTSX(base, name) 
  let search = fnameescape(a:base) . '/**/*' . a:name . '.tsx'
  call Log ("looking for ts or tsx: " . search)
  let found = glob(search)
  if len(found)
    call Log( ">> FOUND: " . search)
    call Log( "GOT: " . found)
    return found
  else
    call Log( "NOT FOUND: " . search)
  endif
  let found = glob(fnameescape(a:name . '.ts'))
  if len(found)
    return found
  endif
  return ''
endfunction

function! TSInclude(name)
  let parent = join(split(expand("%"), "/")[:-2], "/")
  call Log( "CURRENT FILE: " . expand("%"))
  call Log( "LOOKING FOR: " . a:name)
  " return "./package.json"
  if a:name[0:1] == './'
    call Log( "it's a relative parent include")
    let found = FindTSorTSX(parent, a:name[2:])
    if len(found)
      return found
    endif
  endif
  " @ does not get parsed here somehow
  " eg: @/lib/foo
  if a:name[0] == '/'
    let found = glob("./src" . a:name . ".ts")
    if len(found)
      return found
    endif
    let found = glob("./src" . a:name . ".tsx")
    if len(found)
      return found
    endif
  endif

  let found = glob ('./src/**/*' . a:name . ".ts")
  if len(found)
    return found
  endif
endfunction

set includeexpr=TSInclude(v:fname)
"set includeexpr=
"

function! TSTest(name)
  let file = glob("./**/*/quests/" . a:name . "*")
  echo file
endfunction


