# Author: Leandro Cardoso

# Extra PATH directories

# Add bin dirs at the beggining
# /opt/freeware/bin: AIX, must be put in the beginning of the PATH
for newpath in $HOME/bin/strip /opt/freeware/bin $HOME/opt/$(uname -s)-$(uname -m)/bin $HOME/opt/$(uname -s)-$(uname -m)/*/bin; do
    if [[ -d $newpath && ":$PATH:" != *:$newpath:* ]]; then
        export PATH=$newpath:$PATH
    fi
done

# Add bin dirs at the end
# /usr/ucb: SunOS
for newpath in /usr/ucb /usr/local/bin $HOME/bin; do
    if [[ -d $newpath && ":$PATH:" != *:$newpath:* ]]; then
        export PATH=$PATH:$newpath
    fi
done

# Add local MANPATH
for newpath in $HOME/opt/$(uname -s)-$(uname -m)/man $HOME/opt/$(uname -s)-$(uname -m)/*/share/man; do
    if [[ -d $newpath && ":$MANPATH:" != *:$newpath:* ]]; then
        export MANPATH=$newpath:$MANPATH
    fi
done

unset newpath

export SHELL=$(which bash)

[[ -z $PS1 ]] && return

# change TERM to the awesome 256 colors terminal
export TERMINFO=$HOME/.terminfo
case "$TERM" in
    putty*)
        export TERM=putty-256color
        ;;
    screen*)
        export TERM=screen-256color
        ;;
    xterm*)
        export TERM=xterm-256color
        ;;
esac

# Foreground colors
fgblack=$(tput setaf 0)  # Black
fgred=$(tput setaf 1)    # Red
fggreen=$(tput setaf 2)  # Green
fgyellow=$(tput setaf 3) # Yellow
fgblue=$(tput setaf 4)   # Blue
fgpurple=$(tput setaf 5) # Purple
fgcynan=$(tput setaf 6)  # Cyan
fgwhite=$(tput setaf 7)  # White
# Background colors
bgblack=$(tput setab 0)  # Black
bgred=$(tput setab 1)    # Red
bggreen=$(tput setab 2)  # Green
bgyelow=$(tput setab 3)  # Yellow
bgblue=$(tput setab 4)   # Blue
bgpurple=$(tput setab 5) # Purple
bgcyan=$(tput setab 6)   # Cyan
bgwhite=$(tput setab 7)  # White
# Misc
reset=$(tput sgr0)      # Text Reset
bold=$(tput bold)
dim=$(tput dim)
underline=$(tput smul)   # underline
blink=$(tput blink)
rev=$(tput rev)          # reverse

# Prompt
# export PS1="\h:\j \w:\$ "
# These machines do not support color prompt :-(
if [[ $(uname -s) == HP-UX || $(uname -s) == AIX ]]; then
    export PS1="\[$rev\]\h:\j \w:\[$bold\]\$\[$reset\] "
else
    export PS1="\[$fggreen\]\h:\j \w:\[$bold\]\$\[$reset\] "
fi

# grep with color (linux)
export GREP_OPTIONS="--color=auto"

# long-prompt, ignore-case, colors, quit-at-exit and squeeze-blank-lines
export LESS="-M -i -R -e -s"
[[ $(uname -s) == Linux && $(lsb_release -i -s) == RedHat* ]] && export LESS="$LESS -F" # quit-if-one-screen

# man page with colors (linux)
# export GROFF_NO_SGR=1 # output ANSI color escape sequences in raw form
export LESS_TERMCAP_mb=$blink$fgred  # blinking
export LESS_TERMCAP_md=$bold$fggreen # bold (headings)
export LESS_TERMCAP_me=$reset        # end mode
export LESS_TERMCAP_se=$reset        # end standout
export LESS_TERMCAP_so=$rev$fgyellow # standout - statusbar/search
export LESS_TERMCAP_ue=$reset        # end underline
export LESS_TERMCAP_us=$fgblue       # underline (paths, keywords)

# Editor
export VISUAL="emacs -nw"
export EDITOR="emacs -nw"

# Increase History file size
export HISTSIZE=9999
export HISTFILESIZE=$HISTSIZE

# Language
if [[ -n "$(locale -a | grep en_US.utf8)" ]]; then
    export LC_ALL=en_US.utf8
fi

# Set Time Zone (see tzselect)
export TZ=America/Sao_Paulo
#export TZ=Europe/Berlin
#export TZ=Asia/Kolkata

# fix the backspace key
stty erase ^?
# disable the annoying and useless flow control
stty -ixon
stty -ixoff

# checks the window size after each command and, if necessary, updates the values of LINES and COLUMNS
shopt -s checkwinsize
# minor errors in the spelling of a directory component in a cd command will be corrected.
shopt -s cdspell
# Append commands to the history file, rather than overwrite it.
shopt -s histappend
# Save multi-line commands in history as single line
shopt -s cmdhist
# Bash will not attempt to search the PATH for possible completions when completion is attempted on an empty line.
shopt -s no_empty_cmd_completion
if (( ${BASH_VERSINFO[0]} >= 4 )); then
    # attempts spelling correction on directory names during word completion
    shopt -s dirspell
    # enable recursive globbing with **
    shopt -s globstar
fi

# Set Oracle and Perl to run cleartool in arizona
if [[ $HOSTNAME == arizona && ( -z $ORACLE_HOME || -z $PERL_ROOT ) ]]; then
    echo Set Oracle
    . setappx oracle 10.2
    echo Set Perl
    . setappx perl 5.8.8
fi

# Bash Completion
if (( ${BASH_VERSINFO[0]} == 4 && ${BASH_VERSINFO[1]:0:2} >= 1 )); then
    [[ -n $BASH_COMPLETION ]] || BASH_COMPLETION=$HOME/bash_completion-2.0
    [[ -n $BASH_COMPLETION_DIR ]] || BASH_COMPLETION_DIR=$HOME/bash_completion.d-2.0
    [[ -n $BASH_COMPLETION_COMPAT_DIR ]] || BASH_COMPLETION_COMPAT_DIR=$HOME/bash_completion.d-2.0
elif  (( (${BASH_VERSINFO[0]} == 2 && ${BASH_VERSINFO[1]:0:2} > 4) || ${BASH_VERSINFO[0]} > 2 )); then
    [[ -n $BASH_COMPLETION ]] || BASH_COMPLETION=$HOME/bash_completion-1.1
    [[ -n $BASH_COMPLETION_DIR ]] || BASH_COMPLETION_DIR=$HOME/bash_completion.d-1.1
    [[ -n $BASH_COMPLETION_COMPAT_DIR ]] || BASH_COMPLETION_COMPAT_DIR=$HOME/bash_completion.d-1.1
fi

if [[ -r $BASH_COMPLETION ]]; then
    . $BASH_COMPLETION
fi

screen_title()
{
    TITLE=${HOSTNAME/\.*/}
    [[ $CUSTOMER ]] && TITLE="${TITLE}|${CUSTOMER}"
    [[ $CLEARCASE_ROOT ]] && TITLE="${TITLE}|dynamicCC"
    echo -e "setting screen title: \033k${TITLE}\033\\"
}

# My aliases
[[ -e $HOME/.bash_alias ]] && . $HOME/.bash_alias
[[ -e $HOME/.bscsenv ]] && . $HOME/.bscsenv

# Print misc information
echo
uname -a
uptime
echo Bash Version: $BASH_VERSION
echo Bash Completion: $(basename $BASH_COMPLETION)
echo Term: $TERM
echo Lang: $LC_ALL
screen_title
echo ${fggreen}Color Test${reset}
ipcs -a | grep $USER &>/dev/null && echo Shared Memory is being used
echo

# List screen sessions
if [[ ! $STY && $SHLVL = 1 && -x /usr/bin/screen ]]; then
    screen -ls
fi

# Restore SSH session (useful to agent forward)
if [[ $STY ]]; then
    ssh_restore
fi
