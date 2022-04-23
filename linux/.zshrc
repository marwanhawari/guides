# This file is executed when starting any interactive zsh shell.

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Aliases
alias lss="ls -lhrt"
alias mgh="marwan -g"
alias cat="bat --paging=never --theme=ansi --style=plain"
alias dr="docker run -it --rm"
alias de="docker exec -it"
alias k="kubectl"
alias kg="kubectl get -o wide"
alias kd="kubectl describe"

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

# Kubernetes context and namespace in the PROMPT
source kube-ps1
function get_cluster_short() {
  echo "$1" | cut -d / -f1
}
function check_kube_ps1_ctx() {
  kube_ps1 | grep "N\/A"
}
function kube_ps1_autohide() {
    KUBE_PS1_CTX_VALUE="$(check_kube_ps1_ctx)"
    if [ ! -z $KUBE_PS1_CTX_VALUE ];
    then return
    fi

    KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short
    KUBE_PS1_SYMBOL_ENABLE=false
    KUBE_PS1_CTX_COLOR="202"
    KUBE_PS1_PREFIX="["
    KUBE_PS1_SUFFIX="] "
    kube_ps1
}
export PROMPT='$(kube_ps1_autohide)'$PROMPT

# Check if Docker is pointed toward minikube or the local machine
COLOR_DOCKER="%F{cyan}"
function check_docker_env() {
    if [ ! -z $MINIKUBE_ACTIVE_DOCKERD ];
    then echo "${COLOR_DOCKER}[🐳|kube]${COLOR_END} ";
    fi
}
export PROMPT='$(check_docker_env)'$PROMPT

# Activate a "base" Python 3 venv
source ~/venv/bin/activate

# A function to toggle on/off if Docker points to minikube or not
function dockerkube() {
    if [ "$1" = "" ] || [ "$1" = "on" ]; then
        eval $(minikube -p minikube docker-env);
    elif [ "$1" = "off" ]; then
        unset DOCKER_TLS_VERIFY
        unset DOCKER_HOST
        unset DOCKER_CERT_PATH
        unset MINIKUBE_ACTIVE_DOCKERD
    fi
}

# Start minikube
function kubestart() {
    # Start minikube
    minikube start --ports=30100:30100,30200:30200

    # Print the status of minikube
    minikube status

    # Print the IP for the minikube cluster
    minikube ip

    # Point the docker CLI to minikube's internal docker daemon (instead of your local docker desktop daemon)
    eval $(minikube -p minikube docker-env)

    minikube addons enable dashboard
    minikube addons enable metrics-server
}

