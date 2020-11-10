let g:scranch_directory = '/tmp/scranch'

command! -nargs=0 Scranch call scranch#open()
command! -nargs=0 ScranchPreview call scranch#preview()
