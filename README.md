# scranch.vim

Git branch based note taking in vim.

**scranch**: a nauseating portmanteau of *scratch* and *branch*.

## Motivation

Often when I feel the need to take a quick note in vim, it's usually tied to
the current thing I'm working on, which is often tied to a git branch, which
led to this plugin. Opening the note window brings up a new note in a
(faux-)scratch window tied to the current git branch. New branch, new note.

## Features

- `:Scranch` to open the `scranch` note window and into insert mode. Leaving 
the window automatically closes it and saves the note.
- `:ScranchPreview` to open the `scranch` window but keep focus on the current
window. Same command again to close it.

Inside a `scranch` buffer in normal mode:

- `M` to flip to the note associated with the `main` branch (or `master` if
you're [oldschool](https://github.com/github/renaming)).
- `T` to add a new todo item.
- `=` with your cursor on a todo item line to toggle completion.

With more in the pipeline.

To make your `scranch` experience richer, I'd thoroughly endorse integrating
with [vim-dirvish](https://github.com/justinmk/vim-dirvish). `:Dirvish %`
inside a `scranch` window to switch to other notes, delete old notes etc.

## Installation

Use your favourite plugin manager to install this plugin. I like `vim-plug`.

```
Plug 'dbatten5/vim-scranch'
```

**NB**
This plugin currently depends on
[vim-fugitive](https://github.com/tpope/vim-fugitive) (and likely always will).
It's recommended to have
[vim-projectroot](https://github.com/dbakker/vim-projectroot) installed too,
otherwise this plugin implements a fairly naive way of finding the project
root.

## Current Limitations

While this plugin creates new notes with ease, there's currently no support
for deleting notes for stale / deleted branches. You'll just have to manage
that yourselves. 

## Credits

Inspired by and based on [vim-scratch](https://github.com/mtth/scratch.vim).
