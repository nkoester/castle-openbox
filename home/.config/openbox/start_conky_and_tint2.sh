#/bin/bash

echo "Starting ..."

# just in case ...
killall conky tint2 orage volumeicon

screen_number=`xrandr -q | grep -e " connected" | wc -l`
screen_setup=`xrandr -q | grep -e " connected" | grep -e "[0-9]\+x[0-9]\++[0-9]\++[0-9]\+"`
screen_xy_positions=`echo "$screen_setup" |  grep -oE "[0-9]+[x][0-9]*[+][0-9]*[+][0-9]" | cut -d '+' -f 2-3 | sed -e 's/+/ /' | awk '{printf "%sx%s ", $1, $2}'`

echo "Starting conky2 ..."
echo "screen_xy_positions: $screen_xy_positions"

counter=0
for i in `echo $screen_xy_positions`
do
    counter=$counter+1
    x_val=`echo $i | cut -d 'x' -f 1`
    y_val=`echo $i | cut -d 'x' -f 2`
    echo "x_val/y_val: $x_val/$y_val"
    x_val_conky=$(($x_val+4))
    y_val_conky=$(($y_val+2))
    echo "Launching conky on screen id $counter of $screen_number at x/y: $x_val_conky/$y_val_conky"
    (conky -c $HOME/.config/openbox/.conkyrc -x $x_val_conky -y $y_val_conky) &
done

echo "Starting tint2 ..."
(sleep 1 && /usr/bin/tint2 -c $HOME/.config/openbox/tint2.conf) &

# Start orage once for the icon
(sleep 1 && orage) &

# Start volume iconic
(sleep 1 && /usr/bin/volumeicon) &

echo "All done"
