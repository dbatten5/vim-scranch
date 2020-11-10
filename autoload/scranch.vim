function! scranch#open()
  let note_path = s:get_scranch_note_path()
  let note_bufnr = bufnr(note_path)
  let note_winnr = bufwinnr(note_bufnr)
  if note_bufnr == -1 || note_winnr == -1
    let project_dir_path = s:get_scranch_project_path()
    if !isdirectory(project_dir_path)
      call mkdir(project_dir_path, 'p')
    endif
    let size = float2nr(0.2 * winheight(0))
    execute 'topleft ' . size .  ' new ' s:get_scranch_note_path()
    execute 'normal! G'
    execute 'startinsert!'
  else
    if note_bufnr != -1
      if winnr() != note_winnr
        execute note_winnr . 'wincmd w'
      endif
    endif
  endif
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
