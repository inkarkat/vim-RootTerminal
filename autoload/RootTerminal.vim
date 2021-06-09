" RootTerminal.vim: Open a terminal in the repository's root directory.
"
" DEPENDENCIES:
"
" Copyright: (C) 2021 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! RootTerminal#Terminal() abort
    let l:vcsRoot = VcsRoot#Root()
    if empty(l:vcsRoot)
	call ingo#err#Set('Cannot determine project root')
	return 0
    endif

    if ! ingo#fs#path#Equals(l:vcsRoot, getcwd())
	" XXX: Need to turn off 'autochdir' so that the changed directory has an
	" effect on the opened terminal window.
	if exists('+autochdir') && &autochdir
	    let l:saved_autochdir = &autochdir
	    set noautochdir
	endif

	let l:save_cwd = getcwd()
	let l:chdirCommand = ingo#workingdir#ChdirCommand()
	execute l:chdirCommand ingo#compat#fnameescape(l:vcsRoot)
    endif
    let [l:save_VIM, l:save_VIMRUNTIME] = [$VIM, $VIMRUNTIME]
    unlet! $VIM $VIMRUNTIME
    try
	terminal

	if exists('l:saved_autochdir')
	    let &autochdir = l:saved_autochdir
	elseif exists('l:save_cwd')
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
