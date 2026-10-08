#!/usr/bin/env bash
# Bootstrap fish + starship + tmux on a fresh Ubuntu/WSL box and symlink configs.
set -euo pipefail
DOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

command -v fish >/dev/null || { sudo apt-get update && sudo apt-get install -y fish; }
command -v tmux >/dev/null || { sudo apt-get update && sudo apt-get install -y tmux; }
command -v starship >/dev/null || {
    mkdir -p ~/.local/bin
    curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin
}

link() {  # link <src> <dest>, backing up any existing real file
    mkdir -p "$(dirname "$2")"
    [ -e "$2" ] && [ ! -L "$2" ] && mv "$2" "$2.bak"
    ln -sfn "$1" "$2"
    echo "linked $2 -> $1"
}
link "$DOT/fish/config.fish"         ~/.config/fish/config.fish
link "$DOT/fish/fish_plugins"        ~/.config/fish/fish_plugins
link "$DOT/starship/starship.toml"   ~/.config/starship.toml
link "$DOT/tmux/tmux.conf"           ~/.tmux.conf

[ -d ~/.tmux/plugins/tpm ] || git clone -q https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins >/dev/null

# fisher + plugins from fish_plugins
fish -c 'type -q fisher || curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update'

FISH="$(command -v fish)"
grep -qx "$FISH" /etc/shells || echo "$FISH" | sudo tee -a /etc/shells >/dev/null
[ "$(getent passwd "$USER" | cut -d: -f7)" = "$FISH" ] || sudo chsh -s "$FISH" "$USER"
echo "Done. Open a new terminal (or 'wsl --terminate <distro>') to start in fish."
