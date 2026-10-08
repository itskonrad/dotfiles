# dotfiles

fish + [starship](https://starship.rs) + tmux setup for WSL/Ubuntu.

```sh
git clone git@github.com:itskonrad/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

Installs fish, starship, tmux, fisher, and [tpm](https://github.com/tmux-plugins/tpm) if they're missing, symlinks the configs into place (backing up existing files as `*.bak`), and makes fish the login shell.
On WSL it also copies the Alacritty config to `%APPDATA%` and installs JetBrains Mono for the Windows user.
