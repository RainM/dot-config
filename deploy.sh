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


echo "Done!"
