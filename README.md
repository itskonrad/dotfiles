# dotfiles

fish + [starship](https://starship.rs) + tmux setup for Ubuntu and macOS, plus Ghostty and Alacritty configs.

```sh
git clone git@github.com:itskonrad/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

Installs fish, starship, tmux, fisher, and [tpm](https://github.com/tmux-plugins/tpm) if they're missing, symlinks the configs into place (backing up existing files as `*.bak`), and makes fish the login shell.
The Ghostty config is linked on both platforms; the Alacritty config (and its themes) only on Linux.

On macOS, fish, starship and tmux must already be installed. The script only installs fisher and tpm (plus their plugins), links the configs, and leaves the login shell alone.

Machine-specific fish settings (extra PATH entries, aliases) go in `~/.config/fish/conf.d/local.fish`, which fish loads automatically and the repo doesn't track.
