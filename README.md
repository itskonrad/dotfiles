# dotfiles

fish + [starship](https://starship.rs) + tmux setup for Linux and macOS, plus a Ghostty config.

```sh
git clone git@github.com:itskonrad/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

Requires fish, starship, tmux, git and curl to already be installed; the script exits if any are missing.
It symlinks the configs into place (backing up existing files as `*.bak`) and installs fisher and [tpm](https://github.com/tmux-plugins/tpm) plus their plugins. If fish isn't your login shell, it prints the commands to make it one.

Machine-specific fish settings (extra PATH entries, aliases) go in `~/.config/fish/conf.d/local.fish`, which fish loads automatically and the repo doesn't track.
