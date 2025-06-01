#!/bin/zsh

# Run this from ZSH

ROOT=$(git rev-parse --show-toplevel)

ln -sf $ROOT/.zshrc $HOME
ln -sf $ROOT/.tmux.conf $HOME
ln -sf $ROOT/alacritty $HOME/.config/
ln -sf $ROOT/nvim $HOME/.config/nvim
ln -sf $ROOT/tmux-addons $HOME/.local/

ln -sf $ROOT/clangd $HOME/.config/clangd
ln -sf $ROOT/hypr $HOME/.config/hypr
ln -sf $ROOT/waybar $HOME/.config/waybar
ln -sf $ROOT/.vimrc $HOME/.vimrc

