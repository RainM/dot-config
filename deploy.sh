#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"

echo "Copy .emacs"
cp $DIR.emacs ~/.emacs

echo "Copy .bash_profile"
cp $DIR.bash_profile ~/.bash_profile

echo "Copy .bashrc"
cp $DIR.bashrc ~/.bashrc

echo "Copy .minttypc"
cp $DIR.minttypc ~/.minttypc

echo "Copy .tmux.conf"
cp $DIR.tmux.conf ~/.tmux.conf

cp $DIR/.profile ~/.profile
cp $DIR/i3_config ~/.config/i3/config
cp $DIR/i3status_config ~/.config/i3status/config
cp $DIR/i3status2.sh ~/.local/bin/i3status.sh

echo "Done!"
