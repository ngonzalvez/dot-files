#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    echo "Loading $sysresources"
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    echo "Loading $sysmodmap"
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    echo "Loading $userresources"
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    echo "Loading $usermodmap"
    xmodmap "$usermodmap"
fi


# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xrandr --auto
exec i3
# exec i3 -V > i3.log 2>&1
