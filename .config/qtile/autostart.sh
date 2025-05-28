#!/bin/bash

# Screen resolution
xrandr --output DP-4 --mode 2560x1080 --rate 120.0

# Set display timeout:
# 600s (10m) standby
# 900s (15m) suspend
# 1200 (20m) off
xset dpms 600 900 1200

# Swap caps and escape
/usr/bin/setxkbmap -option "caps:swapescape"

# Mouse sensitivity
xinput set-prop "pointer:Logitech G305" "libinput Accel Speed" -0.4

# Compositor
picom -b

# Startup apps
slack &
brave-browser &
ghostty &
