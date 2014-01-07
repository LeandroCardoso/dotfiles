# Author: Leandro Cardoso

# Add extra PATH directories to the end
for newpath in $HOME/bin; do
    if [[ -d $newpath && ":$PATH:" != *:$newpath:* ]]; then
        export PATH=$PATH:$newpath
    fi
done
unset newpath

[[ -z $PS1 ]] && return

export SHELL=$(which bash)

# change TERM to the awesome 256 colors terminal
case "$TERM" in
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
export PS1="\[$fggreen\]\h:\j \w:\[$bold\]\$\[$reset\] "

# grep with color
export GREP_OPTIONS="--color=auto"

# long-prompt, ignore-case, colors, quit-at-exit and squeeze-blank-lines
export LESS="-M -i -R -e -s"
export LESS="$LESS -F" # quit-if-one-screen

# man page with colors
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
# attempts spelling correction on directory names during word completion
shopt -s dirspell
# enable recursive globbing with **
shopt -s globstar


# Bash Completion
# ???

screen_title()
{
    TITLE=${HOSTNAME/\.*/}
    [[ $CUSTOMER ]] && TITLE="${TITLE}|${CUSTOMER}"
    [[ $CLEARCASE_ROOT ]] && TITLE="${TITLE}|dynamicCC"
    echo -e "setting screen title: \033k${TITLE}\033\\"
}

# My aliases
[[ -e $HOME/.bash_alias ]] && . $HOME/.bash_alias

# Print misc information
uname -a
uptime
#screen_title
