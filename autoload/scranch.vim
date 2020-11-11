function! scranch#open()
  execute s:branch_existence_check()
  let note_path = s:get_scranch_note_path()
  let note_bufnr = bufnr(note_path)
  let note_winnr = bufwinnr(note_bufnr)
  " either buffer doesn't exist or is hidden
  if note_bufnr == -1 || note_winnr == -1
    call s:open_window()
  " buffer is on screen not active
  elseif note_bufnr != -1 && winnr() != note_winnr
    " move to it
    execute note_winnr . 'wincmd w'
  endif
  execute 'startinsert!'
  call s:activate_autocmds(bufnr('%'))
endfunction

function! scranch#preview()
  execute s:branch_existence_check()
  let buf_name = s:get_scranch_note_path()
  let note_winnr = bufwinnr(buf_name)
  " scranch window is currently open
  if note_winnr != -1
    execute note_winnr . 'close'
  else
    call s:open_window()
    call s:deactivate_autocmds()
    execute bufwinnr(bufnr('#')) . 'wincmd w'
    call s:activate_autocmds(bufnr(buf_name))
  endif
endfunction

function! scranch#toggle_main()
  execute ':e ' . s:get_main_note_path()
endfunction

function! scranch#add_todo()
  call append(line('.'), '[ ] ')
  execute 'normal! j'
  execute 'startinsert!'
endfunction

function! scranch#toggle_todo()
  let line_nr = line('.')
  let cur_line = getline('.')
  if cur_line =~ '\[\ \]'
    let new_line = substitute(cur_line, '\[\ \]', '\[x\]', 'g')
  elseif cur_line =~ '\[x\]'
    let new_line = substitute(cur_line, '\[x\]', '\[\ \]', 'g')
  else
    echo 'scranch: not on a todo item!'
    return 0
  endif
  call setline(line_nr, new_line)
endfunction

" utility

function! s:get_main_note_path()
  let project_path = s:get_scranch_project_path()
  if filereadable(project_path . '/master.md')
    return project_path . '/master.md'
  endif
  return project_path .'/main.md'
endfunction

function! s:branch_existence_check()
  if fugitive#head() == ''
    echo 'scranch: not inside a git repo!'
    return 'return 0'
  endif
  return ''
endfunction

function! s:open_window()
  if fugitive#head() == ''
    return 0
  endif
  call s:create_project_dir()
  let size = float2nr(0.2 * winheight(0))
  execute 'topleft ' . size .  ' new ' s:get_scranch_note_path()
  setlocal filetype=scranch
  silent execute 'normal! G$'
endfunction

function! s:create_project_dir()
  let project_dir_path = s:get_scranch_project_path()
  if !isdirectory(project_dir_path)
    call mkdir(project_dir_path, 'p')
  endif
endfunction

function! s:close_window()
  execute ':w'
  let prev_bufnr = bufnr('#')
  call s:deactivate_autocmds()
  close
endfunction

function! s:create_window_and_move_to_it()
  let project_dir_path = s:get_scranch_project_path()
  if !isdirectory(project_dir_path)
    call mkdir(project_dir_path, 'p')
  endif
  let size = float2nr(0.2 * winheight(0))
  execute 'topleft ' . size .  ' new ' s:get_scranch_note_path()
  execute 'normal! G'
  execute 'startinsert!'
endfunction

function! s:get_project_name()
  let project = projectroot#guess()
  return substitute(split(project, '/')[-1], ' ', '_', 'g')
endfunction

function! s:get_scranch_project_path()
  return g:scranch_directory . '/' . s:get_project_name()
endfunction

function! s:get_branch_name()
  return substitute(fugitive#head(), '/', '_', 'g')
endfunction

function! s:get_scranch_note_path()
  return s:get_scranch_project_path() . '/' . s:get_branch_name() . '.md'
endfunction

function! s:activate_autocmds(buf_name)
  augroup ScranchAutoHide
    autocmd!
    execute 'autocmd Winleave <buffer=' . a:buf_name . '> nested call <SID>close_window()'
  augroup END
endfunction

function! s:deactivate_autocmds()
  augroup ScranchAutoHide
    autocmd!
  augroup END
endfunction
