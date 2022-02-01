" RootTerminal.vim: Open a terminal in the repository's root directory.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2021-2022 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_RootTerminal') || (v:version < 700)
    finish
endif
let g:loaded_RootTerminal = 1

"- configuration ---------------------------------------------------------------

if ! exists('g:RootTerminal_TerminalEnvironment')
    let g:RootTerminal_TerminalEnvironment = {}
endif

if ! exists('g:RootTerminal_GuiTerminalCommand')
    let g:RootTerminal_GuiTerminalCommand = 'x-terminal-emulator'
    if ! executable(g:RootTerminal_GuiTerminalCommand)
	unlet g:RootTerminal_GuiTerminalCommand
    endif
endif



"- commands --------------------------------------------------------------------

if has('terminal')
    command! RootTerminal if ! RootTerminal#Terminal(ingo#compat#command#Mods('<mods>'))| echoerr ingo#err#Get() | endif
endif

if exists('g:RootTerminal_GuiTerminalCommand') && ! empty(g:RootTerminal_GuiTerminalCommand)
    command! RootGuiTerminal if ! RootTerminal#GuiTerminal()| echoerr ingo#err#Get() | endif
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
