#
# vanilla sh profile
#
HOST=`hostname`
export HOST
HOSTTYPE=`arch`
export HOSTTYPE
PATH=.:$HOME/unix/bin/$HOSTTYPE:\
$HOME/unix/bin/sh:\
/usr/local/bin:/usr/local:\
/usr/ucb:/bin:/usr/bin:\
/usr/local/teTeX/bin/powerpc-apple-darwin-current
export PATH

