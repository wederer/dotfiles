# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TERMINAL="gnome-terminal"
export EDITOR="nvim"
export VISUAL="nvim"
export MYVIMRC="~/.config/nvim/init.vim"
export QT_AUTO_SCREEN_SCALE_FACTOR=0.8

# load nvm if exists
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
