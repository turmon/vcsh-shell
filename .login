# .login
# 
# mjt recreated 15 sep 1997
# turmon altered for darwin dec 2002
# turmon updating for mist env jan 2008
#
# CONFIG is set in .cshrc
#
if ( $CONFIG == mac ) then
  setenv MATLABROOT /Applications/MATLAB
  setenv MATLAB_JAVA "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
  # theoretically, could be done in /etc/launchd.conf, but this
  # does not work.  I did it by a matlab-specific launchd
  # plist file, in /Library/LaunchDaemons, and it seemed to work.  
  # Uncomment if it fails after reboot.
  # launchctl setenv MATLAB_JAVA "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
else if ( $CONFIG == mist ) then
  setenv MATLABROOT /tps/matlab
else
  setenv MATLABROOT $CONFIG
endif
#
set path=( . $MATLABROOT/bin ~/unix/bin/sh ~/unix/bin/$OSTYPE $path )
# startool and other solar stuff
if ( -e /proj/solar/bin/setup.csh ) then
   source /proj/solar/bin/setup.csh
endif
# java classes
if ( -e $HOME/.java_env ) then
   source $HOME/.java_env
endif
# 
#  ENVIRONMENT
# 
# if ( $?LD_LIBRARY_PATH ) then
#   setenv LD_LIBRARY_PATH "$HOME/unix/lib:${LD_LIBRARY_PATH}"
# else
#   setenv LD_LIBRARY_PATH "$HOME/unix/lib"
# endif
# if ( $?MANPATH ) then
#   setenv MANPATH "$HOME/unix/man:${MANPATH}"
# else
#   setenv MANPATH "$HOME/unix/man"
# endif
setenv LC_ALL C  # see locale(1) or environ(5); overrides any DT default
setenv EXINIT 'set ignorecase report=1 shiftwidth=2 wa wrapscan terse wm=4 opt redraw | map  k| map  j'
setenv MORE -sc
setenv LESS "-ceiqRP(%lb/%L) ?f%f:<stdin>. ?e?x[next\: %x]:[END].:?p%pb\%..%t "
setenv LESSOPEN "|lesspipe.sh %s"
setenv HOST `hostname`
setenv HOSTTYPE `arch`  # but suspect this var is also set by a system config
# setenv PRINTER franklin
# setenv LPDEST $PRINTER
#setenv VISUAL gnuclient
#setenv EDITOR vi
setenv PAGER less
setenv CVS_RSH ssh
setenv REPLYTO turmon@jpl.nasa.gov   # correct return for cmd-line mail
# setenv ENV $HOME/.shrc # sh, ksh per-invocation init file -- why customize?
setenv MEXEXT `mexext` # in $MATLABROOT/bin or ~/unix/bin/sh
if ( ${?DISPLAY} == 0 ) then
  setenv DISPLAY :0.0
endif
# Enable FreeBSD environment vars
if ("$OSTYPE" == "darwin" || "$OSTYPE" == "FreeBSD") then
  setenv CLICOLOR # colors in ls (need color TERM)
  setenv BLOCKSIZE 1024
  if ( ${?TERM} ) then
    if ("$TERM" == xterm) then
      setenv TERM xterm-color
    endif
  endif
endif
# 
#  TERMINAL SETUP
# 
#biff n                  # mail should be gotten by the Mac
set ignoreeof           # for the login shell only
# if ($TERM == dialup) setenv TERM vt200
# set noglob
# if ($?TERM) then
#    eval `tset -s -Q -r -I`
# else
#    eval `tset -s -Q -I -m:\?vt200`
# endif
# unset noglob
# 
# for the new Sun keyboard
#stty erase 
# 
#  HELLO WORLD
# 
echo ""
uptime
echo ""
