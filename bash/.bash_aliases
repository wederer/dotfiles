###
# All aliases for bash and zsh that are not specific for user
###
alias aliases="vim ~/.bash_aliases"
alias aliasgrep="cat ~/.bash_aliases | grep "
alias srcreload="source ~/.zshrc"
alias resnet="sudo systemctl restart NetworkManager"
alias sudo='sudo '
alias c="clear"
alias l="ls --color=auto -h"
alias la="ls --color=auto -ah"
alias lla="ls --color=auto -lah"
cl()
{
    cd $@
    ls --color=auto
}
cll()
{
    cd $@
    ls -lh --color=auto
}
cla()
{
    cd $@
    ls -lah --color=auto
}
mkcdir () {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# shortcut to edit specific config files
alias vimrc="vim ~/.vimrc"
ideavimrc() {
	if [ -f /c/Users/W.Ederer/.ideavimrc ]; then
		vim /c/Users/W.Ederer/.ideavimrc
	elif [ -f /c/Users/Wolfgang.Ederer/.ideavimrc ]; then
		vim /c/Users/W.Ederer/.ideavimrc
	elif [ -f /c/Users/Wolfgang/.ideavimrc ]; then
		vim c/Users/W.Ederer/.ideavimrc
	else
		echo "No .ideavimrc found."
	fi
}
alias zshrc="vim ~/.zshrc"

# xrandr
randron(){
  #$1 Output
  xrandr --output ${1} --auto
}
randroff(){
  #$1 Output
  xrandr --output ${1} --off
}
multi(){
  #$1 left
  #$2 right
  xrandr --output ${1} --auto --output ${2} --auto --right-of ${1}
}

alias fixkeys="setxkbmap -option caps:swapescape && xmodmap ~/.Xmodmap"
alias multion="xrandr --output eDP1 --auto --output DP2-1 --auto --left-of eDP1 && fixkeys"
alias inton="xrandr --output eDP1 --auto"
alias intoff="xrandr --output eDP1 --off"
alias exton="xrandr --output DP2-1 --auto && fixkeys"
alias extoff="xrandr --output DP2-1 --off"

# diskspace / folder space
alias space="du -hs * | sort -hr"
alias spacehidden="du -hs .* | sort -hr"
alias diskspace="df -h"

alias q="exit"
alias ta="tmux attach"

# helper scripts
# todo => splitfile, but copy first line to every other file(but not first file)
splitcsv(){
  #${1} = filename with extension
  #${2} = number of lines
  setopt -s nullglob # enable regex matching
  filename_without_extension=$(cut -d'.' -f 1 <<< ${1})
  splitfile ${1} ${2} $filename_without_extension .csv
  array=( ${filename_without_extension}([a-z][b-z]|[b-z][a-z]).csv ) # get all files that were split, but not first file (...aa.csv)
  for file in $array
  do
    split_filename_without_extension=$(cut -d'.' -f 1 <<< ${file})
    head -n 1 ${1} > ${split_filename_without_extension}-temp.csv
    cat ${file} >> ${split_filename_without_extension}-temp.csv
    mv -f ${split_filename_without_extension}-temp.csv ${split_filename_without_extension}.csv
  done
}
#splitfile {filename} {number} {resultname(without extension)} {file-extension}
splitfile(){
  split -l ${2} --additional-suffix=${4} ${1} ${3}
}


# Converts image and resizes while keeping aspect ratio
# convert *.jpg -quality 75% -resize "1140x1140" -set filename:mysize '%t_%w' 'converted/%[filename:mysize].jpg'
# 	usage: convertImage "80%" "1140x1140" *.jpg
convertImage() {
  unset -v arr
  unset -v count
  arr=("$@")
  count=1
  defaultQuality=85%
  defaultDimensions=1500x1500
  if [[ ${arr[$count]} =~ ^[0-9]+%$ ]]; then
    quality=${arr[$count]}
    echo "found quality ${quality}"
    count=$((count+1))
  else
    unset -v quality
    echo "no quality found using default: $defaultQuality"
  fi
  if [[ ${arr[$count]} =~ ^[0-9]+x[0-9]+\!?$ ]] ; then
    dimensions=${arr[$count]}
    echo "found dimensions ${dimensions}"
    count=$((count+1))
  else
    unset -v dimensions
    echo "no Dimensions found using default: $defaultDimensions"
  fi

  for a in ${arr:$((count-1))}; do
      convert $a -quality ${quality:-$defaultQuality} -resize ${dimensions:-$defaultDimensions} -set filename:myname '%t' '%[filename:myname].jpg'
      jpegoptim --strip-all $a
  done
}

# trim noisy scans - http://www.imagemagick.org/Usage/crop/#trim_noisy
trim_noisy(){
	unset -v arr
	arr=("$@")
	for a in ${arr}; do
		convert $a -crop `convert $a -virtual-pixel edge -gravity North -shave 0x50 -shave 20x20 -blur 0x15 -fuzz 30% -trim -format '%wx%h%O' info:` \
			+repage -gravity NorthEast -shave 10x10 -gravity Center -shave 10x10 $a
		echo "trimmed $a"
	done
}

alias swapcaps="setxkbmap -option caps:swapescape"
alias swapesc=swapcaps

# docker
dkrclean() {
    docker system prune -a &&
    docker volume rm $(docker volume ls -f dangling=true -q)
}

# start new postgres container that auto restarts
# e.g. dkrpostgres 5435 newpostgres
dkrpostgres() {
	if [ -z "$1" ]
	then
		echo "No port provided as first parameter. Publishing with 5432..."
		1=5432
	else
		echo "Starting new postgres container on port $1..."
	fi

	if [ -z "$2" ]
	then
		echo "No name provided as second parameter. Publishing without name..."
		docker run -d --restart always -e POSTGRES_PASSWORD=postgres --env --interactive --publish $1:5432 postgres
	else
		echo "Starting new postgres container with name $2..."
		docker run -d --restart always -e POSTGRES_PASSWORD=postgres --env --interactive --publish $1:5432 //name $2 postgres
	fi

	# full command for reference
	# docker run -d --restart always -e POSTGRES_PASSWORD=postgres --env --interactive --publish 5432:5432 --name db-audience-postgres -v 'dbdata-audience-postgres:/var/lib/postgresql/data' postgres
}

# ssh agent
alias ssha="eval `ssh-agent -s`"
alias gadd="ssh-add ~/.ssh/github_rsa"
alias sshcreatekey="ssh-keygen -t rsa -b 4096 -C \"wolfgangederer@gmail.com\""

#
# Aliases from zprezto git module
#

# Git
alias g='git'
alias gremotes='git remote -v'
alias gprecommit="git diff --cached --diff-algorithm=minimal -w"
alias gpreadd="git diff --diff-algorithm=minimal -w" 
alias glogunpushed="git log @{u}.." 
alias gdiffunpushed="git diff @{u}.." 

# gprepush shows unpushed commits then changed files and then all changes
alias gprepush="gl origin/master..HEAD && git diff --name-status origin/master..HEAD && git diff origin/master..HEAD --diff-algorithm=minimal -w"
alias gamend="git commit --amend"
alias gbranches="git branch -a"
alias gtags="git tag"
alias gstashes="git stash list"
alias gapply-gitignore="git ls-files -ci --exclude-standard -z | xargs -0r git rm --cached"

# Commit (c)
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gcm='git commit --message'
alias gcam='git commit --all --message'
alias gco='git checkout'

# Fetch (f)
alias gf='git fetch'
alias gfm='git pull'
alias gfr='git pull --rebase'

# Index (i)
alias ga='git add'

# Log (l)
alias gl="git log --graph --branches --remotes --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev  --date=relative"
alias gln="git log --graph --branches --remotes --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev  --date=relative -n"
alias gll="git --no-pager log --graph --branches --remotes --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev  --date=relative"
alias glln="git --no-pager log --graph --branches --remotes --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev  --date=relative -n"

# Submodule (S)
alias gSf='git submodule foreach'
alias gSu='git submodule update'

# Working Copy (w)
alias gs='git status'
alias gd='git diff --no-ext-diff'
alias gD='git diff --no-ext-diff --word-diff'

