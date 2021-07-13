ROOT TERMINAL
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

This plugin ...

### SOURCE
(Original Vim tip, Stack Overflow answer, ...)

### SEE ALSO
(Plugins offering complementary functionality, or plugins using this library.)

### RELATED WORKS
(Alternatives from other authors, other approaches, references not used here.)

USAGE
------------------------------------------------------------------------------

    :RootTerminal           Open a new :terminal window in the repository root
                            of the current buffer.

    :RootGuiTerminal        Open an external terminal emulator in the repository
                            root of the current buffer.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-RootTerminal
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim RootTerminal*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.043 or
  higher.
- Requires the VcsRoot.vim plugin (unreleased), version 1.00 or
  higher.

CONFIGURATION
------------------------------------------------------------------------------

For a permanent configuration, put the following commands into your vimrc:

You can modify the environment in which the :terminal is opened via a Dict
of environment variables (keys are names, values are values); use v:null (or
for backwards compatibility an empty List ([])) to remove an environment
variable:

    let g:RootTerminal_TerminalEnvironment = {'delete_me': [], 'added': 'val'}

The shell command that launches the terminal emulator can be tweaked via:

    let g:RootTerminal_GuiTerminalCommand = 'gnome-terminal'

If you don't want the :RootGuiTerminal command, set the value to an empty
string:

    let g:RootTerminal_GuiTerminalCommand = ''

plugmap
CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-RootTerminal/issues or email (address below).

HISTORY
------------------------------------------------------------------------------

##### GOAL
First published version.

##### 0.01    08-Feb-2021
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2021 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
