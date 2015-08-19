#!/bin/bash
HOSTNAME=`hostname`

echologin() { echo "$@" >> ~/.new_logininfo; }
string=`printf "%s - Login on host %s \t%s\n (openbox)" "\`date\`" "$HOSTNAME" "${SESSIONID}"`
echologin "$string"

echoerr() { echo "$@" >> ~/.new_logininfo; }


echoerr "`date` - Login on host $HOSTNAME"
# start conky + tint2
if [ "$HOSTNAME" = "calcit" ]; then
    echoerr "${SESSIONID}: rotated setup"
    (sleep 1 && /homes/nkoester/bin/xrandr_dual_r_left_normal.sh) &
else
    echoerr "${SESSIONID}: normal setup"
    (sleep 1 && /homes/nkoester/bin/xrandr_single_normal.sh) &
fi

# Set background (script above does this now!)
#(sleep 1 && nitrogen --restore) &

#num_screens=`xrandr -q | grep -e " connected" | wc -l`
#(sleep 1 && conky -c /homes/nkoester/.config/openbox/.conkyrc -x 4; test $num_screens -gt 1 && conky -c /homes/nkoester/.config/openbox/.conkyrc -x 1924) ; (sleep 1 && tint2 -c /homes/nkoester/.config/openbox/tint2.conf) &

# Set monitor
#(sleep 1 && conky -c /homes/nkoester/.config/openbox/.conkyrc) &
# Set monitor 2
#(sleep 1 && conky -c /homes/nkoester/.config/openbox/.conkyrc -x 1920) &

# Set nice panel
#(sleep 1 && tint2 -c /homes/nkoester/.config/openbox/tint2.conf) &

# Start orage once for the icon
(sleep 1 && orage) &

#start volume iconic
(sleep 1 && /usr/bin/volumeicon) &

# Start terminal
#urxvtd -q -f -o &

# Some special X settings
(sleep 1 && xrdb /homes/nkoester/.config/openbox/.Xresources) &

# Start some helper applications
(sleep 1 && /usr/bin/xscreensaver -no-splash) &

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

# looki lokki
#(sleep 1 && xcompmgr -CcfF -I-.015 -O-.01 -D1 -t-5 -l-5 -r4.2 -o.75) &

# screen leyout setup &
(sleep 1 && /homes/nkoester/bin/setlayout 0 3 3 0) &

# Start kufer
#(sleep 1 && kupfer --no-splash ; sleep 4 && notify-send "Kupfer startet" -t 4000 -u low -i /usr/share/icons/gnome/48x48/status/dialog-information.png) &

# active corners
#(sleep 1 && /homes/nkoester/bin/opensnap -d) &

#open 4 terminals
#(sleep 1 && /homes/nkoester/bin/start_gnome_terminal_init.sh) &

