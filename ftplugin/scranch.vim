if !hasmapto('<Plug>(scranch-toggle-main)', 'n')
  execute 'nmap <buffer> M <Plug>(scranch-toggle-main)'
endif
if !hasmapto('<Plug>(scranch-add-todo)', 'n')
  execute 'nmap <buffer> T <Plug>(scranch-add-todo)'
endif
if !hasmapto('<Plug>(scranch-toggle-todo-completion)', 'n')
  execute 'nmap <buffer> - <Plug>(scranch-toggle-todo-completion)'
endif

nnoremap <buffer><silent> g? :help ScranchMappings<CR>
