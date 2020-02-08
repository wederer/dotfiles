#!/bin/bash
# called in .i3/config on startup

# autostart programs
(sleep 1s && xbindkeys) &
(sleep 1s && seafile-applet) &
(sleep 1s && nm-applet) &
(sleep 3s && dropbox start) &

# set keyboad + mouse
(sleep 1s && setxkbmap -option caps:swapescape) &

# t450s specific settings
# slower mouse movement on trackpoint
(sleep 1s && xinput --set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" -0.8) &
# fix acel/decel issue on trackpoint
(sleep 1s && xinput --set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Profile Enabled" 0,0) &
# two finger natural scrolling
(sleep 1s && xinput --set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1) &
# tap to click on touchpad
(sleep 1s && xinput --set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1) &

