" RootTerminal.vim: Open a terminal in the repository's root directory.
"
" DEPENDENCIES:
"
" Copyright: (C) 2021-2022 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! s:SetEnvironment( environment ) abort
    let l:oldEnvironment = {}
    for l:key in keys(a:environment)
	let l:oldEnvironment[l:key] = ingo#compat#getenv(l:key)
	call ingo#compat#setenv(l:key, a:environment[l:key])
    endfor
    return l:oldEnvironment
endfunction

function! RootTerminal#Terminal( mods ) abort
    let l:vcsRoot = VcsRoot#Root()
    if empty(l:vcsRoot)
	call ingo#err#Set('Cannot determine project root')
	return 0
    endif

    let l:save_autochdir = []
    if ! ingo#fs#path#Equals(l:vcsRoot, getcwd())
	" XXX: Need to turn off 'autochdir' so that the changed directory has an
	" effect on the opened terminal window.
	let l:save_autochdir = ingo#option#autochdir#Disable()

	let l:save_cwd = getcwd()
	let l:chdirCommand = ingo#workingdir#ChdirCommand()
	execute l:chdirCommand ingo#compat#fnameescape(l:vcsRoot)
    endif

    let [l:save_VIM, l:save_VIMRUNTIME] = [$VIM, $VIMRUNTIME]
    unlet! $VIM $VIMRUNTIME
    let l:save_environment = s:SetEnvironment(g:RootTerminal_TerminalEnvironment)

    try
	execute a:mods 'terminal'
	let b:cwd = l:vcsRoot
	let b:VcsRoot = l:vcsRoot   " XXX: vcscommand.vim uses bufname() to determine the current working directory; that doesn't work with terminal buffers that run !/bin/bash. By setting this explicitly, we avoid the plugin invocation through VcsRoot.vim.

	if ! ingo#option#autochdir#Restore(l:save_autochdir) && exists('l:save_cwd')
	    " Need to restore the cwd of the previous (original) window, not of
	    " the terminal window.
	    wincmd p
	    execute l:chdirCommand ingo#compat#fnameescape(l:save_cwd)
	    wincmd p
	endif

	return 1
    catch /^Vim\%((\a\+)\)\=:/
	return 0
    finally
	call s:SetEnvironment(l:save_environment)
	let [$VIM, $VIMRUNTIME] = [l:save_VIM, l:save_VIMRUNTIME]
    endtry
endfunction

function! RootTerminal#GuiTerminal() abort
    let l:vcsRoot = VcsRoot#Root()
    if empty(l:vcsRoot)
	call ingo#err#Set('Cannot determine project root')
	return 0
    endif

    let l:vcsChangeDirCommand = (ingo#fs#path#Equals(l:vcsRoot, getcwd()) ? '' : 'cd ' . ingo#compat#shellescape(l:vcsRoot))
    silent let l:output = system(ingo#list#JoinNonEmpty([l:vcsChangeDirCommand, 'unset VIM VIMRUNTIME', g:RootTerminal_GuiTerminalCommand], ' && '))
    if v:shell_error != 0
	call ingo#err#Set(ingo#msg#MsgFromShellError(g:RootTerminal_GuiTerminalCommand, l:output))
	return 0
    endif
    return 1
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
