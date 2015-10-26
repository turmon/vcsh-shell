# 
# this file is sourced by .bash_profile
#
# this should contain *interactive* commands for *bash* shells
# don't set PS1 manually before running this
# 

# return if not interactive
if [ -z "$PS1" ]; then
    return
fi

# prompt - standard user:dir
# unusual second-line prompt allows whole line to be pasted
PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h: \[\e[33m\]\w\[\e[0m\]\n$ '

# noclobber is set here, but unset for non-interactive shells
set -o noclobber
# leave after second ctrl-D
IGNOREEOF=1
export CLICOLOR=1

[[ -n `which brew 2> /dev/null` ]] && \
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# push just-executed command into $HISTFILE
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

# history control
HISTCONTROL=ignoreboth
HISTIGNORE="&:ls:fg:bg:history:exit"
# set history length (units: commands/lines)
HISTSIZE=10000
HISTFILESIZE=10000
HISTTIMEFORMAT="%Y.%m.%d_%T  "

shopt -s cdspell
shopt -s cmdhist
# command-line completion
set completion-ignore-case on
set visible-stats on
set show-all-if-ambiguous on
set bell-style visible
set colored-stats on

CDPATH=".:..:~:~/Mike:~/Mike/Projects:~/matlab/mfile"

if [ -f ~/.bash_completion ]; then
   # NB: this file has been modified by me
   source ~/.bash_completion
   complete -F _ssh firefox-proxy
fi

# functions
#   which file -- full pathname
wf()  { echo $(cd $(dirname "$1") > /dev/null && pwd -P)/$(basename "$1"); }
wff() { echo ${HOST}:$(cd $(dirname "$1") > /dev/null && pwd -P)/$(basename "$1"); }
# finger and look for headers like: ^First.Maiden-Last@some.domain
#   optional second arg filters on that name (useful?)
lookup() { 
  finger "$1@jpl.nasa.gov" | \
  awk '/^[[:alnum:].-]+@.*nasa\.gov/ {p++} ; p==1 {print} ; p > 1 && /@.*nasa\.gov/ {print p, $0}' ; }
# special spotlight query for the filename, similar to locate(1)
mdf  () { mdfind -name "$@"; } # any path component
mdff () { mdfind "kMDItemFSName == $1"; } # exact filename match
ff() { find . -name "$@" -print; }
# gnuplot one-liner -- gp file.dat
gp() { gnuplot -p -e "plot \"$1\""; }
# stdin/stdout to /dev/null
quiet() { nice "$@" < /dev/null > /dev/null 2>&1 ; }

# aliases
# basics
alias ls="ls -hF"
alias cp="cp -i"
alias mv="mv -i"
alias mx="chmod a+x"
alias df="df -h" 		# human-readable
alias du="du -h" 		# human-readable
alias gr="grep -n -i"
alias m=less
alias lpr="lpr -h"
alias top="top -o cpu" # sort on cpu
alias h="history 22"
alias hs="history 10"
alias hl="history | less"
alias f="history | fgrep"
alias term='set -f;\
        eval `tset -s -I -Q -m:\?vt200`;\
        set +f'
# local rsync (version 3 preserves ACLs + other metadata)
alias lsync="/usr/local/bin/rsync -aNAXvz --rsync-path=/usr/local/bin/rsync"
#
alias amacs='open -a Aquamacs'
alias gkon='open -a GraphicConverter'
alias safari='open -a Safari'
alias chrome='open -a Google\ Chrome'
alias firefox='open -a Firefox'
alias qt7='open -a QuickTime\ Player\ 7'
alias firefox-proxy="ssh -qTnN -D 2001"

#
alias c1="tr -d '\n' | pbcopy" # copy just one line, without trailing newline
##
# some darwin aliases
##
alias dlclean="xattr -d com.apple.quarantine"
alias dlls="xattr -l"
alias ..='cd ..'
alias ssh-tunnel="ssh -C2qTnN -D 2001 turmon@turmon.org"

