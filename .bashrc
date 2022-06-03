# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# add julia's bin folder (full path) to system PATH environment variable
export PATH="$PATH:/home/andrea/julia-1.7.2/bin"

# set PATH so it includes user's private .scripts if it exists
if [ -d "$HOME/.scripts" ] ; then
    PATH="$HOME/.scripts:$PATH"
fi

###########################################
## My own variables 
###########################################
HPC="ab1820@login.hpc.ic.ac.uk"
# PROJ='/home/andrea/Documents/P1Brazil'
# SCRIPTS='/home/andrea/git/phyloflows/scripts'
DEEPANALYSES='/home/andrea/Documents/Box/ratmann_deepseq_analyses/live'
DEEPDATA='/home/andrea/Documents/Box/ratmann_pangea_deepsequencedata'
SOFTWARE='/home/andrea/git/Phyloscanner.R.utilities/misc_data_analysis_RCCS1519/software'
FLOWS='/home/andrea/git/phyloflows'
SUBMISSION='/home/andrea/Documents/P1Brazil/submission/naturemed_v3'
MARKING='/home/andrea/Documents/marking'

set -o vi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/andrea/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/andrea/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/andrea/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/andrea/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> shortcuts
function lsh() {
        N=${1:-10}
        ls -t | head -n $N
}

# >>> Encryption and Decription of the Box repository >>>

function decrypt() {

    if [ -z "$1"  ]; then
        echo "Usage: $0 [directory] ";
        exit 0;
    fi
    sudo mount -t ecryptfs $1 $1\
            -o ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_passthrough=no,ecryptfs_enable_filename_crypto=no

    if [ "$1" == "Box" ]; then
            source "$1"/helpers.sh 
    fi
}


function encrypt() {

    if [ -z "$1"  ]; then
        echo "Usage: $0 [directory] ";
        exit 0;
    fi
        sudo umount $1 
}

# >>> Set Background script >>>

function setbg() {

        # Copied from Luke Smith
        # This script without an argument sets /usr/share/backgrounds/warty-final-ubuntu.png
        # as a background. Otherwise, can give a directory name to select a random image.
        # Note that the directory must only contain images:

        cp /usr/share/backgrounds/warty-final-ubuntu.png ~/.config/wall.png

        [ -f "$1" ] && cp "$1" ~/.config/wall.png && notify-send -i "$HOME/.config/wall.png" "Wallpaper changed"

                [ -d "$1" ] && mv "$( find "$1"/*.{jpg,jpeg,png} -type f | shuf -n 1)" ~/.config/wall.png && notify-send -i "$HOME/.config/wall.png" "Random Wallpaper chosen"

        # If pywall installed, use it.
        type wal >/dev/null 2>&1 && { wal -c
                wal -s -i ~/.config/wall.png -o ~/.config/wal/postrun
                xsetroot -name "fsignal:xrdb"
                killall dwnblocks
                setsid dwmblocks >/dev/null & } >/dev/null 2>&1

        gsettings set org.gnome.desktop.background picture-uri ~/.config/wall.png


}


# >>> lynx quick search setup, copied from rwxrob >>>

rawurlencode () {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER)
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}

duck () {
        declare url=$(rawurlencode "$*")
        lynx "https://duckduckgo.com/lite?q=$url"
}
alias '?'=duck

# >>> disable interpretations of CTRL+S (useful for CTRL+S in nvim)
stty -ixon

