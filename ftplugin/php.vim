function! IPhpInsertUse()
  call PhpInsertUse()
  call feedkeys('a',  'n')
endfunction
autocmd FileType php nmap <silent> gi :call IPhpInsertUse()<CR>
