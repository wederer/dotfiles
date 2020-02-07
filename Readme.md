# Dotfiles Wolfgang Ederer

Steps to install dotfiles:
1. Clone this repo to ~/.dotfiles
2. cd into ~/.dotfiles
3. run stow <folder> to symlink dotfiles

References:
https://alexpearce.me/2016/02/managing-dotfiles-with-stow/
https://www.youtube.com/watch?v=zhdO46oqeRw

### ToDos

- [ ] check which files are no longer needed (especially not-stowable)
- [ ] put keyboard layout in extra repo with good readme (this is not stowable anyway)
- [ ] Check if all work related info + secrets (e.g. ssh config) are removed


### Git
`~/.gitconfig` includes `~/.gitconfig_local` to allow for differing email address + name.

Add this to `~/.gitconfig_local`:
```
[user]
	name = wederer
	email = wolfgangederer@gmail.com
```
