#!/bin/zsh

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Noto.zip
rm $HOME/.local/share/fonts
mkdir -p $HOME/.local/share/fonts
mv Noto.zip $HOME/.local/share/fonts
cd $HOME/.local/share/fonts
unzip Noto.zip 
rm Noto.zip
cd -

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
cd ~/.oh-my-zsh
chmod +x oh-my-zsh.sh
zsh ./oh-my-zsh.sh
cd -
