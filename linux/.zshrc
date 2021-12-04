# This file is executed when starting any interactive zsh shell.

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Aliases
alias lss="ls -lhrt"

# Colorize the "ls" command in zsh
export CLICOLOR=1

# Change the "ls" colors to the default Linux terminal colors
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# Default zsh command prompt
# PS1="%n@%m %1~ %# "
# Added full working directory to command prompt
# PS1="%n@%m [%~] %# "
# Colored the full working directory
# PS1="%n@%m %{%F{red}%}[%~]%{%f%} %# "

# Show and colorize the current git branch in the command prompt.
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/ [\1]/p'
}
COLOR_END='%f'
COLOR_USR='%f'
COLOR_DIR='%F{1}'
COLOR_GIT='%F{27}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}[%~]${COLOR_GIT}$(parse_git_branch)${COLOR_END} %# '

# Activate a "base" Python 3 venv
source ~/.venv_base/bin/activate
