# dotfiles

fish + [starship](https://starship.rs) setup for WSL/Ubuntu.

```sh
git clone git@github.com:itskonrad/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

Installs fish, starship, and fisher if they're missing, symlinks the configs into `~/.config` (backing up existing files as `*.bak`), and makes fish the login shell.
