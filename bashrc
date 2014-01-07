# Author: Leandro Cardoso

# Add extra PATH directories to the end
for newpath in ~/bin; do
    if [[ -d $newpath && ":$PATH:" != *:$newpath:* ]]; then
        PATH=$PATH:$newpath
    fi
done
unset newpath

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# change TERM to the awesome 256 colors terminal
case "$TERM" in
    xterm*)
        TERM=xterm-256color
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
# PS1="\u@\h:\j \w:\$ "
if [[ $EUID == 0 ]]; then # root
    PS1="\[$fgred\]\u@\h:\j \W\[$bold\]\$\[$reset\] "
else
    PS1="\[$fggreen\]\u@\h:\j \w\[$bold\]\$\[$reset\] "
fi

# grep with color
GREP_OPTIONS="--color=auto"

# long-prompt, ignore-case, colors, quit-at-exit, squeeze-blank-lines and quit-if-one-screen
LESS="-M -i -R -e -s -F"

# man page with colors
# GROFF_NO_SGR=1 # output ANSI color escape sequences in raw form
LESS_TERMCAP_mb=$blink$fgred  # blinking
LESS_TERMCAP_md=$bold$fggreen # bold (headings)
LESS_TERMCAP_me=$reset        # end mode
LESS_TERMCAP_se=$reset        # end standout
LESS_TERMCAP_so=$rev$fgyellow # standout - statusbar/search
LESS_TERMCAP_ue=$reset        # end underline
LESS_TERMCAP_us=$fgblue       # underline (paths, keywords)

# Editor
VISUAL="emacs -nw"
EDITOR="emacs -nw"

# lines which begin with a space char and lines matching the previous history entry are not saved in
# the history list
HISTCONTROL=ignoredups:ignorespace
# Increase History file size
HISTSIZE=9999
HISTFILESIZE=$HISTSIZE

# disable the annoying and useless flow control
stty -ixon
stty -ixoff
# checks the window size after each command and, if necessary, updates the values of LINES and COLUMNS
shopt -s checkwinsize
# Save multi-line commands in history as single line
shopt -s cmdhist
# minor errors in the spelling of a directory component in a cd command will be corrected.
shopt -s cdspell
# attempts spelling correction on directory names during word completion
shopt -s dirspell
# Append commands to the history file, rather than overwrite it.
shopt -s histappend
# enable recursive globbing with **
shopt -s globstar
# Bash will not attempt to search the PATH for possible completions when completion is attempted on
# an empty line.
shopt -s no_empty_cmd_completion

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

screen_title()
{
    TITLE=${HOSTNAME/\.*/}
    [[ $CUSTOMER ]] && TITLE="${TITLE}|${CUSTOMER}"
    [[ $CLEARCASE_ROOT ]] && TITLE="${TITLE}|dynamicCC"
    echo -e "setting screen title: \033k${TITLE}\033\\"
}

# My aliases
[[ -f ~/.bash_alias ]] && . ~/.bash_alias

# Print misc information
uname -a
uptime
echo
[[ -x /usr/games/fortune ]] && fortune -ac
