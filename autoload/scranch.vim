function! scranch#open()
  let project_dir_path = s:get_scranch_project_path()
  if !isdirectory(project_dir_path)
    call mkdir(project_dir_path, 'p')
  endif
  let size = float2nr(0.2 * winheight(0))
  execute 'topleft ' . size .  ' new ' s:get_scranch_note_path()
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
