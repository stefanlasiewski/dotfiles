################################################################################
#
# Stefan's .bashrc . Please share & borrow anything in here.
#
# ~/.bashrc: "When an interactive shell that is not a login
# shell is started, Bash reads and executes commands from
# ~/.bashrc, if that file exists."
#
# This file is also called (sourced) from .bash_profile.
#
# My philosophy is to keep it simple.
# - The defaults on most systems are reasonable, but sometimes need
# to be enhanced. I tend to keep the defaults when possible and keep
# my changes local to this account and avoid any changes outside $HOME.
# - Most of these commands should run fine on GNU/Linux, FreeBSD, Solaris
# & MacOSX
# - Commands in here should not echo to the screen, otherwise some
# non-interactive commands may fail.
#
# $Id: .bashrc 279 2013-11-26 05:53:08Z stefanl $ 
#
#######################################################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

### Prompts and titlebars
# TODO: Set PS1 based on hostname, superuser ability, etc.
case "$TERM" in
	xterm*|rxvt*|screen)
		### Set the prompt like "username@hostname:~ $"
		# See: http://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
		# And: http://mywiki.wooledge.org/BashFAQ/037
		# 'tput bold' will work regardless of the foreground and background colors, unlike many fancy colored PS1 prompts.
		# Place the tput output into variables, so they are only execd once.
		bold=$(tput bold)
		reset=$(tput sgr0)
		export PS1='\u@\[$bold\]\h\[$reset\]:\w \$ '
	
		### Set title in terminal emulator to match PS1.
		# PROMPT_COMMAND is executed as a command prior to issuing each primary prompt.
		# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss4.3  
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'

		### Old style
		### Set PS1 and the xterm title at the same time. 
		# See http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html/Xterm-Title.html.gz#bash
		# But this doesn't update dynamically like 'PROMPT_COMMAND'
		#export PS1="\[\033\]0;\u@\h: \w\007\]bash\$ "
		#export PS1="\[\033\]0;\u@\[$(tput bold)\]\h\[$(tput sgr0)\]:\w \007\\$ "

		### Another old way
		# Set some colors
		#WHITE="\[\033[1;37m\]"
		#NO_COLOR="\[\033[0m\]"
		#PS1="\u@${WHITE}\h${NO_COLOR}:\w \$ "
		;;
	*)
		# For simpler terminals, use simpler features
		export PS1="\u@\h:\w \$ "
		;;
esac

# Set some options, based on the OS
OS=`uname -s`

case "$OS" in
	"SunOS" )

		# Solaris ls doesn't allow color, so use special characters
		LS_OPTS='-F'
		alias  ls='ls ${LS_OPTS}'

		;;
	"Linux" )

		# GNU ls supports colors!
		# See dircolors to customize colors
		export LS_OPTS='--color=auto'
		alias  ls='ls ${LS_OPTS}'

		# Get color support for 'less'
		export LESS="--RAW-CONTROL-CHARS"

		# Use colors for less, man, etc.
		[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

		# Color support for Grep
		# Use GREP_OPTIONS with caution. See 'GREP_OPTIONS considered harmful' and https://bugs.launchpad.net/ubuntu/+bug/67141
        # However, I have not had a problem with GREP_OPTIONS since setting them in 2009.
		export GREP_OPTIONS="--color=auto"

		;;
	"Darwin"|"FreeBSD")

		# Most FreeBSD & Apple Darwin supports colors
		export CLICOLOR=true

		# Get color support for 'less'
		export LESS="--RAW-CONTROL-CHARS"

		# Use colors for less, man, etc.
		# See http://unix.stackexchange.com/questions/119/colors-in-man-pages
		[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

		# Color support for Grep
		# Use GREP_OPTIONS with caution. See 'GREP_OPTIONS considered harmful' and https://bugs.launchpad.net/ubuntu/+bug/67141
        # However, I have not had a problem with GREP_OPTIONS since setting them in 2009.
		export GREP_OPTIONS="--color=auto"

		# Append MacPorts to PATH
		export PATH=$PATH:/opt/local/bin:/opt/local/sbin

		# Use svn & git from Macports instead of default
		[[ -f /opt/local/bin/svn ]] && alias svn=/opt/local/bin/svn
		[[ -f /opt/local/bin/git ]] && alias git=/opt/local/bin/git

		;;
	* )
		echo "Unknown OS [$OS]"
		;;
esac

### PATH & MANPATH
# Also see OS-specific options above
# PATH goes in .bashrc so it works with interactive non-login shells
# Add my own personal utilities in ~/bin
export PATH=$PATH::$HOME/bin

### Set the manpath based on the PATH, after man(1) parses man.conf
# - No need to modify man.conf or manually modify MANPATH_MAP
# - Works on Linux, FreeBSD & Darwin, unlike /etc/manpaths.d/
#
# Must unset MANPATH first. MANPATH is set on some systems
# automatically (Mac), which causes manpath to ignore the values
# of PATH like /opt/local/bin (MacPorts).
# See "SEARCH PATH FOR MANUAL PAGES" in man(1)
unset MANPATH
# Just set the man search path. Don't print output to screeen.
manpath >/dev/null

### Oracle options
# SQLPATH: Include $HOME/.oracle so that my $HOME/.oracle/login.sql is picked up
export SQLPATH=$SQLPATH:~/.oracle

# VI/VIM everywhere
export EDITOR=vim

### Other Bashisms
# Log out only after the third ^D
export IGNOREEOF=2

# For Bash tab completion, ignore .svn directories
export FIGNORE=.svn

### History
# Share my history amongst windows, in real-time
# http://stackoverflow.com/questions/103944/real-time-history-export-amongst-bash-terminal-windows/104056#104056
# avoid duplicates.
export HISTCONTROL=ignoredups:erasedups  
#export HISTSIZE=100000                   # big big history
#export HISTFILESIZE=100000               # big big history
# append history entries.
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

### Organize aliases in a seperate .aliases file
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

### .bashrc is used on multiple machines. Use .bashrc.local for local (host-specific) modifications.
[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
