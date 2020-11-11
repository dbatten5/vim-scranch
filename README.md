# scranch.vim

Git branch based note taking in vim.

**scranch**: a nauseating portmanteau of *scratch* and *branch*.

## Motivation

Often when I feel the need to take a quick note in vim, it's usually tied to
the current thing I'm working on, which is often tied to a git branch, which
led to this plugin. Opening the note window brings up a new note tied to the
current git branch. New branch, new note.

## Features

- `:Scranch` to open the scranch note window and into insert mode. Leaving the
window automatically closes and saves the window.
- `:ScranchPreview` to open the scranch window but keep focus on the current
window. Same command again to close it.

With more in the pipeline, including proper documentation.

## Installation

Use your favourite plugin manager to install this package. I like `vim-plug`

```
Plug 'dbatten5/vim-scranch'
```

**NB**
This plugin currently depends on [vim-fugitive](https://github.com/tpope/vim-fugitive)
(and I think it always will) and [vim-projectroot](https://github.com/dbakker/vim-projectroot)
(hopefully to be removed soon)

## Current Limitations

While this plugin creates new notes with ease, there's currently no support
for deleting notes for stale / deleted branches. You'll just have to manage
that yourselves.

## Credits

Heavily based on [vim-scratch](https://github.com/mtth/scratch.vim)
