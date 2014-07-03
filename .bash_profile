################################################################################
#
# Stefan's .bash_profile . Please share & borrow anything in here.
#
# ~/.bash_profile: Read when Bash is invoked as an interactive login shell,
# after reading /etc/profile. This file typically calls ~/.bashrc . 
#
# $Id: .bash_profile 311 2014-06-23 18:13:16Z stefanl $ 
#
################################################################################

# Print some information as we log in
# -s: OS Name -n: Node name -r: OS Release
uname -snr
uptime

### Not all distros source ~/.bashrc by default, so we force it
# See http://www.gnu.org/software/bash/manual/bashref.html#Bash-Startup-Files
if [ -e "${HOME}/.bashrc" ] ; then source "${HOME}/.bashrc"; fi

### All SSH authentication run under the ssh-agent umbrella
#if [ -f ~/.ssh/ssh-agent ]; then . ~/.ssh/ssh-agent; fi
