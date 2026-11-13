#!/usr/bin/env bash

if [ -f ~/.Xprofile ]; then
        . ~/.Xprofile
fi

# Another solution is to symlink ~/.Xdefaults to ~/.Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

feh --bg-scale ~/Pictures/wallpaper.png
xset r rate 200 60

#exec i3 -V >> ~/.i3/logfile 2>&1
exec bash "$HOME/.xsession"
