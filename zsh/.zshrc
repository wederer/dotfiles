# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# load bash aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# load bash aliases for work
if [[ -f ~/.bash_aliases_work_int && -f ~/.work ]]; then
  . ~/.bash_aliases_work_int
fi

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# in WSL $SHELL is not being set correctly
if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
	export SHELL=/usr/bin/zsh
fi

# load nvm/node/npm/npx only when needed for the first time => speeds up zsh startup
lazynvm() {
  unset -f nvm node npm npx
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
  if [ -f "$NVM_DIR/bash_completion" ]; then
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  fi
}
nvm() {
  lazynvm
  nvm $@
}
node() {
  lazynvm
  node $@
}
npm() {
  lazynvm
  npm $@
}
npx() {
  lazynvm
  npx $@
}
