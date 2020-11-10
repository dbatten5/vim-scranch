function! scranch#open()
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

" utility

function! s:open_window()
  call s:create_project_dir()
  let size = float2nr(0.2 * winheight(0))
  execute 'topleft ' . size .  ' new ' s:get_scranch_note_path()
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
