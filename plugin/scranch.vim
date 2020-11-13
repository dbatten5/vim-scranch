command! -nargs=0 Scranch call scranch#open()
command! -nargs=0 ScranchPreview call scranch#preview()

augroup scranch
  au!
  autocmd FileType scranch setlocal syntax=markdown
augroup END
