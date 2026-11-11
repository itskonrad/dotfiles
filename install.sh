#!/usr/bin/env bash
# Symlink configs and bootstrap tmux/fish plugins on Linux or macOS; the tools themselves must already be installed.
set -euo pipefail
DOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for t in fish tmux starship git curl; do
    command -v "$t" >/dev/null || { echo "$t not found; install it first" >&2; exit 1; }
done

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
link "$DOT/ghostty/config.ghostty"   ~/.config/ghostty/config.ghostty

[ -d ~/.tmux/plugins/tpm ] || git clone -q https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins >/dev/null

# fisher + plugins from fish_plugins
fish -c 'type -q fisher || curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update'

echo "Done."

# $SHELL is the login shell, unlike the shell running this script
if [ "$(basename "${SHELL:-}")" != fish ]; then
    FISH="$(command -v fish)"
    echo
    echo "Your login shell is ${SHELL:-unset}, not fish. To change it, run:"
    echo "  grep -qx $FISH /etc/shells || echo $FISH | sudo tee -a /etc/shells"
    echo "  chsh -s $FISH"
fi
