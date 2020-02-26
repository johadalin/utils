# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

function title()
{
    if [[ $# == 0 ]]; then
      title_string="D.Va"
    else
      title_string="$*"
    fi
    # change the title of the current window or tab
    echo -ne "\033]0;$title_string\007"
}

function ssh()
{
    if ! [[ $# == 0 || -z $TMUX ]]; then
      title ${@: -1}
    fi
    /usr/bin/ssh $@
    # revert the window title after the ssh command
    title
}

# Doesn't work when running `sudo su`, but running `title` after can reset the
# terminal heading nicely.
function su()
{
    /bin/su "$@"
    # revert the window title after the su command
    title
}

##########################
# USEFUL HISTORY OPTIONS #
##########################
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000
# mark history entries with datestamps
HISTTIMEFORMAT="%d/%m/%y %T "

####################################
# Appearance/Functionality options #
####################################
# Force xterm colour
export TERM=xterm-256color
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#######################
# Aliases/Completions #
#######################
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

########################################
# Path/PS1 settings! AKA: The good bit #
########################################
title
# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/go/bin"

# You may need to install the git-completion sctipt, and potentially source them
# if they end up installed in unusual locations (e.g. on Centos or others)
# source /usr/share/doc/git/contrib/completion/git-completion.bash
# source /usr/share/doc/git/contrib/completion/git-prompt.sh

source /usr/share/git-core/contrib/completion/git-prompt.sh
# Set up git PS1 variables
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

# Defines a list of colours to cycle through. Yes. It is gross. Sorry
COLOURWHEEL=( $( seq 27 -1 22 ) $( seq 28 33) $( seq 39 -1 34 ) $( seq 40 45 ) $( seq 51 -1 46 ) $( seq 82 87 ) $( seq 81 -1 76 ) $( seq 70 75 ) $( seq 69 -1 64 ) $( seq 58 63 ) $( seq 57 -1 52 ) $( seq 88 93 ) $( seq 99 -1 94 ) $( seq 100 105 ) $( seq 111 -1 106 ) $( seq 112 117 ) $( seq 123 -1 118 ) $( seq 154 159 ) $( seq  153 -1 148 ) $( seq 142 147 ) $( seq 141 -1 136 ) $( seq 130 135 ) $( seq 129 -1 124 ) $( seq 160 165 ) $( seq 171 -1 166 ) $( seq 172 177 ) $( seq 183 -1 178 ) $( seq 184 189 ) $( seq 195 -1 190 ) $( seq 226 231 ) $( seq 225 -1 220 ) $( seq 214 219 ) $( seq 213 -1 208 ) $( seq 202 207 ) $( seq 201 -1 196 ) $( seq 160 165 ) 129 93 99 105 111 117 123 51 45 39 33 )
WHEELLENGTH=${#COLOURWHEEL[@]}
COLCOUNT=$(( $RANDOM ))

# Function to use as a Promet function. PS1 is build up inside, with some sections
# going through the colour cycling process. Too much colour cycling can get reaaallly
# perf heavy..... soo, do with that what you will.
function change_colors
{
    TIMESTAMP=$(date +%T)

    # PROMPT variable to be colour cycled into FINAL
    # Begin building up the Prompt with a timestamp
    PROMPT=`echo $(echo $TIMESTAMP)`
    PROMPT+="-D.Va"
    PROMPTLENGTH=${#PROMPT}
    FINAL=''

    # Initial colour position in the colour wheel
    COLOUR=$(( $COLCOUNT % $WHEELLENGTH ))

    # Loop that takes each character of PROMPT, surrounds it with colour escapes
    # and puts it into the FINAL prompt variable
    k=0
    while [ "$k" -le "$PROMPTLENGTH" ]; do
       CURRCOLOUR=$(( ( $COLOUR + $k ) % $WHEELLENGTH))
       FINAL+="\[\033[38;5;${COLOURWHEEL[$CURRCOLOUR]}m\]${PROMPT:$k:1}"
       k=$(($k + 1))
    done
    # Terminate the colour escaping
    FINAL+="\[\e[0m\]"

    # Increment the Colcount, so the next PS1 to be generated starts from the next offset
    COLCOUNT=$(( $COLCOUNT + 1 ))

    # Build the final PS1
    # Adds the working directory
    PS1="${FINAL} \[\e[0;36m\]\w\[\e[m\]"

    # Add virtual env dir if we're in one
    if [ -n "$VIRTUAL_ENV" ]
    then
      PS1+='\[\e[38;5;196m\](${VIRTUAL_ENV##*/})\[\e[m\]'
    fi

    # Add git branch status info
    PS1+=' $(__git_ps1 "[\[\e[0;32m\]%s\[\e[0m\]]")'

    # Finish with a trailing '$' and space
    PS1+='\[\e[0;31m\]\$\[\e[0m\] '
}
PROMPT_COMMAND=change_colors
