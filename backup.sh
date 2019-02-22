#!/bin/sh

# IMPORTANT: put a trailing slash if backup item is a directory, otherwise target will be nested inside

for f in \
.bash_profile \
.bashrc* \
.zshrc \
.zprofile \
.zpreztorc \
.zprezto/ \
.vimrc \
.config/nvim/init.vim \
.tmux.conf \
.tmux/gojek \
Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings; do

    has_dir=${f%\/*}
    actual_file="$HOME/$has_dir"
    [ -f "$actual_file" ] && [ -d "$f" ] && eval "rm -rf '$f'"
    [ -d "$actual_file" ] && eval "rm -rf '$has_dir' && mkdir -p '$has_dir'"
    eval "cp -fa '$HOME/$f' '$f'"
done

find . -name .git -type d -depth 2 |xargs rm -rf
