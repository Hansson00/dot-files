#!/bin/zsh

# Run this from ZSH

ROOT=$(git rev-parse --show-toplevel)

ln -sf $ROOT/.tmux.conf $HOME
ln -sf $ROOT/alacritty $HOME/.config/
ln -sf $ROOT/nvim $HOME/.config/nvim
ln -sf $ROOT/tmux-addons $HOME/.local/

