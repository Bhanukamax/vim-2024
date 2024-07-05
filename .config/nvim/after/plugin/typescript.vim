let g:original_errorformat = &errorformat

function! SetMakeTsc()
  set makeprg=NODE_DISABLE_COLORS=1\ tsc\ -p\ ./tsconfig.json\ --noUnusedLocals
  let  g:original_errorformat = &errorformat
  set errorformat=%f(%l\\,%c):\ %m
endfunction

function! SetMakeEslint()
  set makeprg=npx\ eslint\ -c\ .eslintrc.json\ ./src/**/*.ts\ ./src/**/*.tsx --fix
  set errorformat=g:original_errorformat
endfunction
