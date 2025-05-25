#!/bin/bash

xrandr --output DP-4 --mode 2560x1080 --rate 120.0

/usr/bin/setxkbmap -option "caps:swapescape"

picom -b

slack &
brave-browser &
ghostty &
