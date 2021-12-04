# Linux guide

## General
* The `~/` directory is an alias for the home directory. Same as the `${HOME}/` directory.
* Executing a script `sh script.sh` or `bash script.sh` or `./script.sh` (if `script.sh` is given executable permission) will create a _new shell_, run the commands, and copy the output back to the current shell. Thus environment changes will not be carried over.
* Source-ing a script `source script.sh` or `. ./script.sh` (zsh) or `. script.sh` (bash) will run the commands in the _current shell_. You should use `source` if you want to make changes to the current shell.
  * This is why when activating a python venv, you want to run `source venv/bin/activate`. That way your current shell will enter the venv.
* Add environment variables to your dotfiles using the `export` command - ex: `export NAME="marwan"`
* Chaining commands:
  * With `command1 && command2`, `command2` will only execute if `command1` exits with a status code of 0 (noraml exit).
  * With `command1 ; commadn2`, `command2` will execute regardless of how `command1` exits.

## Dotfiles
### bash
* Order of execution for interactive login shells: `/etc/profile` --> `~/.bash_profile` --> `~/.profile` --> `~/.bash_login`
* Order of execution for interactive non-login shells: `/etc/bash.bashrc` --> `~/.bashrc`
* Link the `.bashrc` file to the `.bash_profile` so that your config files are run regardless of the type of shell.
  * Make a one line `.bash_profile` file with this line `[ -r ~/.bashrc ] && [ -f ~/.bashrc ] && source ~/.bashrc` at the top.
  * Now you can add all your aliases, paths, environment variables, etc. to just the `.bashrc` file.

### zsh
* Order of execution for interactive login shells: `/etc/zshenv` --> `~/.zshenv` --> `~/.zprofile` --> `~/.zshrc` --> `~/.zlogin`
* Order of execution for interactive non-login shells: `/etc/zshenv` --> `~/.zshenv` --> `~/.zshrc`
* Because the `.zshrc` file is run whether its a login shell or not, you only need to add your configurations to the `.zshrc` file.

<p align="center">
  <img src="https://github.com/marwanhawari/guides/blob/main/images/dotfiles.png" alt="dotfiles" width="600"/>
</p>
source: https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html

### nano
* nano is a simple-to-use text editor
* Configure nano with the `~/.nanorc` file.
* You can import syntax highlighting from other nanorc files. Many come built in with nano in the `/usr/share/nano/` but I just copy all those files over to a new `~/.nano/` directory and write at the top of my `~/.nanorc` file: `include ~/.nano/*`.

## tmux hotkeys
* Start a session with a given name: `tmux new -s <session-name>`
* Vertical split: `ctrl+b %`
* Horizontal split: `ctrl+b "`
* Move panes: `ctrl+b <left/right/up/down-arrow-key>`
* New window: `ctrl+b c`
  * Rename window: `ctrl+b ,`
  * Switch window: `ctrl+b <window-name>`
* Detach a session (from within tmux): `ctrl+b d`
* Re-enter a session (from outside tmux): `tmux attach -t <session-name>`
* List tmux sessions: `tmux ls`
* Rename a session: `tmux rename-session -t <old-session-name> <new-session-name>`
* End a session: `tmux kill-session -t <session-name>`
* Show all hotkeys: `ctrl+b ?`
