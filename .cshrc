# .cshrc
# 
# this file is sourced by .cshrc and .tcshrc
# 
# mjt recreated 15 sep 1997
# turmon mods for darwin, 12/2002
#
setenv CONFIG unknown
if ( -d /dsw ) then
  setenv CONFIG mist
endif
if ( -d /Applications ) then
  setenv CONFIG mac
endif
#
limit coredumpsize 0
umask 022
set noclobber
# 
# exit now on noninteractive shell
if ($?USER == 0 || $?prompt == 0) exit
echo In cshrc
#
#  Interactive shell setup
#
set ftp=/net/aimls/export/home/00/ftp/pub/users/mjt/  # ftp dir
# 
#  Shell variables
#
set prompt = "\
|`hostname`: You called? "	# .tcshrc resets this
set cdpath=( .. ~ ~/Mike ~/Mike/Projects ~/matlab/mfile )
set history = 200
set filec
set fignore = (.o .lof .lot .aux .blg .toc .bak .pyc)
set autolist		# list options when tab expands nonuniquely
set listmax = 100	# autolist at most n files on filec
set autoexpand		# expand !'s on filec
set autocorrect		# correct filenames on filec
set addsuffix		# add trailing / to expansions
set ampm		# all times in am/pm format
set complete=enhance    # case correction in filec and _ - . as wordsep
set ellipsis
set nobeep
set autologout = 0
set implicitcd          # dir name as command does cd
unset ignoreeof 
set savehist = 200
#
#  Aliases
#
# basics
if ( $CONFIG == mist ) then
  alias ls ls -F --color=tty
else
  alias ls        ls -F
endif
alias cp        cp -i
alias mv        mv -i
alias mx        chmod a+x
alias df	df -k 		# in kbyte
alias du	du -k 		# in kbyte
alias gr        grep -n -i
alias ff        'find . -name "\!*" -print'
alias rfind     'find . -type f -exec grep \!* {} \;'
alias rgrep	'find . -type f -print0 | xargs -0 grep -i \!* '
alias m         less
alias j         jobs
alias lpr 	lpr -h
alias top       top -o cpu # sort on cpu
if ( $CONFIG == mac) then
  alias mail       mail -b turmon  # bcc myself
else
  alias mail       mailx -b turmon  # bcc myself
endif
alias h         "history | tail -22"
alias hl        "history | less"
alias hs        "history | tail -10"
alias f         'history | fgrep \!*'
alias background 'nice \!* < /dev/null >& /dev/null &'
alias term      'set noglob;\\
        eval `tset -s -I -Q -m:\?vt200`;\\
        unset noglob'
# local rsync (version 3 preserves ACLs + other metadata)
alias lsync /usr/local/bin/rsync -aNAXvz --rsync-path=/usr/local/bin/rsync
# wrapper aliases to throw away output streams
alias no_err	'eval "( ( \!* ) > /dev/tty ) >& /dev/null"'
alias no_out	'eval "( ( \!* ) > /dev/null ) >& /dev/tty"'
#
alias amacs 'open -a Aquamacs'
alias gkon 'open -a GraphicConverter'
alias chrome 'open -a Google\ Chrome'
alias safari 'open -a Safari'
alias firefox 'open -a Firefox'
alias qt7 'open -a QuickTime\ Player\ 7'
alias firefox-proxy ssh -qTnN -D 2001
# gnuplot one-liner: 
#  gp form supplies quotes: gp file.dat
alias gp  gnuplot -p -e \'plot \"'\!*'\"\'
#  gpp form removes quotes allowing: gpp "file.dat" using 1:3
alias gpp gnuplot -p -e \'plot '\!*'\'
#
alias wf  '\ls -d1 $cwd/\!*' # what file
alias wff '\ls -d1 $cwd/\!* | sed "s/^/${HOST}:/"' # what freaking file
alias c1 "tr -d '\n' | pbcopy" # copy just one line, without trailing newline
# finger and look for headers like: ^First.Maiden-Last@some.domain
alias lookup 'finger \!*@jpl.nasa.gov | awk "/^[[:alnum:].-]+@.*nasa\.gov/ {p++} ; p==1 {print} ; p > 1 && /@.*nasa\.gov/ {print p, $ 0}"'
alias lmat '\rm -f /tmp/lmat.$$.*.out; /Applications/MATLAB72/etc/lmstat -f MATLAB | tee `date +/tmp/lmat.$$.%a-%R.out`'
##
# some darwin aliases
##
alias dlclean   xattr -d com.apple.quarantine
alias dlls      xattr -l
alias MvMac	/Developer/Tools/MvMac
alias CpMac	/Developer/Tools/CpMac
alias .   	'pwd'
alias ..	'cd ..'
alias line	'sed -n '\''\!:1 p'\'' \!:2'	# eg: line 5 file
alias ssh-tunnel ssh -C2qTnN -D 2001 turmon@turmon.org
# special spotlight query for the filename, similar to locate(1)
alias mdf mdfind \'kMDItemFSName == \"\!\*\"\'
if ($?TERM_PROGRAM == 1) then
  if ("$TERM_PROGRAM" == "Apple_Terminal") then
    alias settermtitle 'echo -n "]2;\!:1"'
  endif
endif
