#
# Stefan's aliases
#
# My philosophy: Stick with the defaults. Don't overwrite an existing command because that encourages bad habits.
# One exception: Maybe `rm` should be `rm -i` but that is heavily debatable.
# 
################################################################################

# Quickly re-source my environment
alias srcsh='source ~/.bash_profile && source ~/.bashrc'

# List long, with color or special characters, depending on OS
alias  ll='ls -l'
# Long, with metacharacters, show dotfiles, don't show . and ..
alias lll='ls -lA'
# Long, with metacharacters, show dotfiles, show . and ..
alias lla='ls -la'
# List just the dotfiles
alias  l.='ls -l -Ad .????*'
# List the full path to a file/directory
# Only works on Linux? Not FreeBSD or MacOSX?
alias lsfull='readlink -f'

# Useful greps
#alias hgrep='history |grep ${*} |grep -v $$'
alias greph='history |grep ${*}'
alias grepp='ps -ef |grep ${*}'

# List file and directory sizes, list big files last
alias findbig="du -ks * |sort -n > .du && tail .du"
 
# I want a nice environment when I 'su'
alias suroot='su - root -c "bash --rcfile /.bash_profile_stefan"'

# Become root, but still keep my environment.
alias sudob='sudo bash --rcfile ~/.bash_profile'

# For safety!
alias rmm='rm -i'

# Delete previous item in history
# See http://thoughtsbyclayg.blogspot.com/2008/02/how-to-delete-last-command-from-bash.html
alias histdel2='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'
# This might be better, and it's simpler!
# See http://www.commandlinefu.com/commands/view/5974/delete-the-previous-entry-in-your-history
alias histdel='history -d $((HISTCMD-1))'
# Then, add 'histdel' the the list of commands that are ignored by the history
# This could be expanded to include other commands
export HISTIGNORE=$HISTIGNORE:hd

# "use vi-like and less-like key bindings."
alias info="info --vi-keys $*"

################################################################################
# Functions

# Redo previous command with 'sudo'
#function sudoh() {
#	set -x
#	command=$(fc -ln -1 -1);
#	command=`echo $command | sed 's/^[ ]*//'`
#	echo "#### $command"
#	sudo $command
#	set +x
#}
alias sudoh="sudo !!"

# Workaround for Ubuntu bug with backspace
# See http://ubuntuforums.org/showthread.php?t=90910
# 20101115, disabled
#alias screen='TERM=screen screen'

# Connect to a host in a new screen tab, with device name as tab title
# See http://serverfault.com/questions/15365/favorite-unix-command-line-aliases/15496#15496
function screenssh()
{
    screen -t "$@" /usr/bin/ssh "$@"
}


### Subversion
# Use vimdiff for svndiffs
# Also see ~/bin/vimdiff-svn-wrapper
alias svnvimdiff="svn diff --diff-cmd ~/bin/vimdiff-svn-wrapper"
# Runs a find, but excludes directories named .svn . Accepts argument $1, defaults to '.' (cwd).
#alias findsvn="find $* -not \( -name .svn -prune \)" # No: the -not must be first
#alias findsvn="find $1 -not \( -name .svn -prune \)"
# findsvn - Find files in directory (defaults to .), skip the .svn directories
findsvn () { find "${1:-.}" -not \( -name .svn -prune \) ; }

### Set a nice title in the Xterm/PuTTY window & icon
# Won't work if Bash's PROMPT_COMMAND is used.
setTitle () {
	[[ -n "$1" ]] || ( echo "Usage: setTitle Words to put in Xterm Title"; )
	echo -ne '\033];"$@"\007'
}

### Highlight some text.
# Usage: command | highlight "desired text"
# From http://unix.stackexchange.com/questions/366/convince-grep-to-output-all-lines-not-just-those-with-matches/367#367
# Requires GNU Grep, which is installed on Linux, FreeBSD & MacOSX
#       -E, --extended-regexp
#              Interpret PATTERN as an extended regular expression
highlight () { grep --color --extended-regexp "$1|$" ; }

# From http://serverfault.com/questions/180749 and http://unix.stackexchange.com/a/17308/4
# Useful when GNU Grep doesn't exist, but Perl does exist.
highlight2 () { perl -pe "s/$1/\e[1;31;43m$&\e[0m/g"; }

# From http://superuser.com/questions/199088/highlight-console-output/199106#199106
highlight3 () { sed "s/\($1\)/$(tput smso)\1$(tput rmso)/g" ; }
