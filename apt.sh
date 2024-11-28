#!/bin/bash

ROOT=$(git rev-parse --show-toplevel)
sudo rm /etc/apt/sources.list
sudo ln -sf $ROOT/sources.list /etc/apt/sources.list

sudo apt update
sudo apt upgrade -y

sudo apt install zsh fzf ripgrep fd-find alacritty can-utils clangd clang cmake curl firefox htop neovim python3-pip tmux plasma-workspace kde-plasma-desktop plasma-desktop -y
chsh -s $(which zsh)
ln -sf $ROOT/.zshrc $HOME

