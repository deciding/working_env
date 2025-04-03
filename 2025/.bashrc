# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1



# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1) HISTSIZE=1000 HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias mem="ps aux --sort -rss | awk -F' ' 'NR>1{SUM+=\$4}END{print SUM, 80}'"
alias emem="watch -d -n 0.5 \"ps aux --sort -rss | awk -F' ' 'NR>1{SUM+=\\\$4}END{print SUM, 80}'\""
alias egpu="watch -d -n 0.5 nvidia-smi --query-gpu=memory.used,memory.total --format=csv"
alias edu="du -cBM --max-depth=1 2> >(grep -v 'Permission denied') | sort -n"
alias dockertmp="du -hsc /var/lib/docker/overlay2/LONGHASHHHHHHH/diff/tmp"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias npy="python -c 'import numpy as np;import sys;val=np.load(sys.argv[1], allow_pickle=True);print(val.shape);print(val)'"
alias h5="python -c $'import h5py\nimport numpy as np\nimport sys\nwith h5py.File(sys.argv[1], \"r\") as f:\n  for key in f.keys():\n    print(key);\n    val=np.array(f[key])
\n    print(val.shape)\n    print(val)'"


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export PYTHONIOENCODING=utf-8
#source ~/.local/bin/virtualenvwrapper.sh
#source /usr/local/bin/virtualenvwrapper.sh
export LANG="en_US.utf8"
export LC_ALL="en_US.utf8"
export LC_CTYPE="en_US.utf8"


nvmon_helper() {
    # Step 1: Get GPU index, memory usage, and UUID mapping
    declare -A gpu_mem gpu_uuid
    while IFS=',' read -r index mem uuid; do
        index=$(echo $index | xargs)
        mem=$(echo $mem | xargs)
        uuid=$(echo $uuid | xargs)
        gpu_mem["$index"]="$mem"
        gpu_uuid["$index"]="$uuid"
    done < <(nvidia-smi --query-gpu=index,memory.used,gpu_uuid --format=csv,noheader,nounits)

    # Step 2: Get GPU UUID and associated running PIDs
    declare -A gpu_users
    while IFS=',' read -r uuid pid; do
        # Skip if PID is empty or invalid
        uuid=$(echo $uuid | xargs)
        pid=$(echo $pid | xargs)
        [[ -z "$pid" || ! -d "/proc/$pid" ]] && echo Z$pid && continue

        # Get user from /proc/$pid/status and passwd database
        user=$(ps -o user= -p "$pid" 2>/dev/null)
        #user=$(awk '/^Uid:/ {print $2}' "/proc/$pid/status" 2>/dev/null | \
        #       xargs -I{} getent passwd {} 2>/dev/null | \
        #       cut -d: -f1)

        # Only add user if we successfully got a username
        [[ -n "$user" ]] && gpu_users["$uuid"]+="$user "
    done < <(nvidia-smi --query-compute-apps=gpu_uuid,pid --format=csv,noheader,nounits)

    # Step 3: Print results, merging GPU memory and user info
    for ((index=0; index<${#gpu_mem[@]}; index++)); do
        uuid=${gpu_uuid[$index]}
        mem=${gpu_mem[$index]}
        users=$(echo "${gpu_users[$uuid]}" | tr ' ' '\n' | sort -u | tr '\n' ' ' | sed 's/ $//')
        echo "GPU$index: ${mem} MiB | Users: ${users:-None}"
    done
}

alias nvmon="watch -n 5 -d -x bash -ic nvmon_helper"

export PATH=$HOME/local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
export CPATH=$HOME/local/include:$CPATH
export LIBRARY_PATH=$HOME/local/lib:$LIBRARY_PATH
export PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig:$PKG_CONFIG_PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/zhangzn/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/zhangzn/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/zhangzn/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/zhangzn/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

