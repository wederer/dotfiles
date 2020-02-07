#!/bin/sh

i3status | while :
do
        read line
        brightness=$(xbacklight -get)
        echo "brightness:$brightness | $line" || exit 1
done
