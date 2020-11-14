command! -bang -nargs=0 Scranch call scranch#open(<bang>0)
command! -nargs=0 ScranchPreview call scranch#preview()

nnoremap <silent> <Plug>(scranch-toggle-main) :call scranch#toggle_main()<cr> 
nnoremap <silent> <Plug>(scranch-add-todo) :call scranch#add_todo()<cr> 
nnoremap <silent> <Plug>(scranch-toggle-todo-completion) :call scranch#toggle_todo()<cr> 

augroup scranch
  au!
  autocmd FileType scranch setlocal syntax=markdown
augroup END
