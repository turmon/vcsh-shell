#
# bash login init file
#
# login shells read this file
#

[ -z "$HOST" ] && export HOST=`hostname`
[ -z "$HOSTTYPE" ] && export HOSTTYPE=`arch`

# no core dumps
ulimit -c 0
umask 022

# needed for PATH below
CONFIG=unknown
if [ -d /dsw ]; then
  CONFIG=mist
elif [ -d /Applications ]; then
  CONFIG=mac
fi

# needed for PATH below
if [ $CONFIG == mac ]; then
  MATLABROOT=/Applications/MATLAB
  # this is a fix for font rendering and other issues on Mac
  export MATLAB_JAVA="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
  # theoretically, this could be done in /etc/launchd.conf, but this
  # does not work.  I did it by a matlab-specific launchd
  # plist file, in /Library/LaunchDaemons, and it seemed to work.  
  # Uncomment if it fails after reboot.
  # launchctl setenv MATLAB_JAVA "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
elif [ $CONFIG == mist ]; then
  MATLABROOT=/tps/matlab
else
  MATLABROOT=$CONFIG
fi
export MATLABROOT


#
# PATH
#
# TBD: this should perhaps not assign directly to PATH,
# but add on.
PATH=.:$HOME/unix/bin/$HOSTTYPE:\
$HOME/unix/bin/sh:\
$MATLABROOT/bin:\
/usr/local/bin:\
/usr/X11/bin:\
/usr/sbin:/sbin:/usr/ucb:/bin:/usr/bin
export PATH

# 
#  ENVIRONMENT
# 
export LC_ALL=C  # see locale(1) or environ(5)
export EXINIT='set ignorecase report=1 shiftwidth=2 wa wrapscan terse wm=4 opt redraw | map  k| map  j'
export MORE=-sc
export LESS="-ceiqRP(%lb/%L) ?f%f:<stdin>. ?e?x[next\: %x]:[END].:?p%pb\%..%t "
export LESSOPEN="|lesspipe.sh %s"
# setenv PRINTER franklin
# setenv LPDEST $PRINTER
#setenv VISUAL gnuclient
#setenv EDITOR vi
export PAGER=less
export CVS_RSH=ssh
export REPLYTO=turmon@jpl.nasa.gov   # correct return for cmd-line mail
export MEXEXT=`mexext` # in $MATLABROOT/bin or ~/unix/bin/sh

# read .bashrc if it exists
#   that is for non-login shells
[ -f ~/.bashrc ] && source ~/.bashrc

