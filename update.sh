#!/bin/bash

# night x day
#composite -dissolve 50x50 -gravity South n.jpg d.jpg -alpha on new

# mode: real-edge
# get sunrise
# get sunset
# from curl
# 2 hours either side of this time period do the transition

# mode: triangle wave
# linear up linear down

# mode: fake-edge
# real-edge without internet

h=`/usr/bin/date +%H`
m=`/usr/bin/date +%m`

t=`expr $h \* 60 + $m`

dir="/home/scott/.tw"

if [ "$t" -lt 720 ]; then
    # do morning

    n=`/usr/bin/python2 -c "print (720 - $t) / 7.2"`
    d=`/usr/bin/python2 -c "print $t / 7.2"`

    /usr/bin/composite -dissolve ${n}x${d} -gravity South ${dir}/n.jpg ${dir}/d.jpg -alpha on ${dir}/result.jpg

    echo "morning: $n and $d"

else
    # do evening

    f=`expr $t - 720`

    d=`/usr/bin/python2 -c "print (720 - $f) / 7.2"`
    n=`/usr/bin/python2 -c "print $f / 7.2"`

    /usr/bin/composite -dissolve ${n}x${d} -gravity South ${dir}/n.jpg ${dir}/d.jpg -alpha on ${dir}/result.jpg

    echo "night: $n and $d"
fi

export DISPLAY=:0.0
/usr/bin/nitrogen --restore
exit

