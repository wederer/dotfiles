# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# if WSL then set following
result=$( uname -r | grep "Microsoft" )
if [ -n "$result" ]; then
	export DOCKER_HOST=tcp://localhost:2375
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
	export PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
	export PATH="$HOME/.local/bin:$PATH"
fi

# Go
export GOPATH=~/projects/go
export PATH=~/projects/go/bin:$PATH
export PATH=/usr/local/go/bin:$PATH

# only run if xmodmap is installed (not on wsl)
if hash xmodmap 2>/dev/null; then
	xmodmap ~/.Xmodmap
fi

# only run if setxkbmap is installed (not on wsl)
if hash setxkbmap 2>/dev/null; then
	setxkbmap -option caps:swapescape
fi
