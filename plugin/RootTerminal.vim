" RootTerminal.vim: Open a terminal in the repository's root directory.
"
" DEPENDENCIES:
"
" Copyright: (C) 2021 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_RootTerminal') || (v:version < 700)
    finish
endif
let g:loaded_RootTerminal = 1

if has('terminal')
    command! RootTerminal if ! RootTerminal#Terminal()| echoerr ingo#err#Get() | endif
endif

if executable('gnome-terminal')
    command! RootGuiTerminal if ! RootTerminal#GuiTerminal()| echoerr ingo#err#Get() | endif
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
