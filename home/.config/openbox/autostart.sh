#!/bin/bash
HOSTNAME=`hostname`

echologin() { echo "$@" >> ~/.new_logininfo; }
string=`printf "%s - Login on host %s \t%s\n (openbox)" "\`date\`" "$HOSTNAME" "${SESSIONID}"`
echologin "$string"

echoerr() { echo "$@" >> ~/.new_logininfo; }

echoerr "`date` - Login on host $HOSTNAME"
if [ "$HOSTNAME" = "calcit" ]; then
    echoerr "${SESSIONID}: rotated setup"
    (sleep 1 && $HOME/bin/xrandr_dual_r_left_normal.sh) &
else
    echoerr "${SESSIONID}: normal setup"
    (sleep 1 && $HOME/bin/xrandr_single_normal.sh) &
fi

# start conky + tint2
(sleep 1 && exec $HOME/.config/openbox/start_conky_and_tint2.sh) &

# Start orage once for the icon
(sleep 1 && orage) &

#start volume iconic
(sleep 1 && /usr/bin/volumeicon) &

# Some special X settings
(sleep 1 && xrdb $HOME/.config/openbox/.Xresources) &

# Start some helper applications
(sleep 1 && /usr/bin/xscreensaver -no-splash) &

(sleep 1 && nitrogen --restore) &

# openbox related - REVERS IF RUNNING GNOME!
# Disable Nautilus desktop.
gconftool-2 -s -t bool /apps/nautilus/preferences/show_desktop false &
# Do not let Nautilus set the background image.
gconftool-2 -s -t bool /desktop/gnome/background/draw_background false &

# candy
# Make Nautilus use spatial mode, should start-up quicker.
gconftool-2 -s -t bool /apps/nautilus/preferences/always_use_browser false &
# Make Nautilus show the advanced permissions dialog 
gconftool-2 -s -t bool /apps/nautilus/preferences/show_advanced_permissions true &

# screen leyout setup &
(sleep 1 && $HOME/bin/setlayout 0 3 3 0) &

# active corners
#(sleep 1 && $HOME/bin/opensnap -d) &

