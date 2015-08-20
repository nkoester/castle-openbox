#/bin/bash

echo "Starting ..."

# just in case ...
#killall conky tint2 netwmpager
killall conky tint2


screen_number=`xrandr -q | grep -e " connected" | wc -l`
screen_setup=`xrandr -q | grep -e " connected" | grep -e "[0-9]\+x[0-9]\++[0-9]\++[0-9]\+"`

# TODO: check if field 4 is correct
screen_xy_positions=`echo "$screen_setup" |  cut -d ' ' -f 4 | cut -d '+' -f 2-3 | sed -e 's/+/ /' | awk '{printf "%sx%s ", $1, $2}'`

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

echo "Setting background..."

(sleep 1 && /usr/bin/tint2 -c $HOME/.config/openbox/tint2.conf) &

echo "All done"
