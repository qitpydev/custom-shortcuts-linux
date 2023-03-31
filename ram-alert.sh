#!/bin/bash
total=$(free | awk '/^Mem:/{print $2}')
used=$(free | awk '/^Mem:/{print $3}')
free=$(free | awk '/^Mem:/{print $4}')
available=$(free | awk '/^Mem:/{print $7}')
threshold=$(echo "scale=2; $total * 0.85" | bc | awk '{print int($1+0.5)}')
if [ $used -gt $threshold ]; then
    notify-send "RAM Usage Alert" "RAM usage is above 85% ($used / $total)"
fi

# ----------------------------------------------------------------
# >>>>     Usage    <<<<
# ----------------------------------------------------------------
# crontab --->
# ----------------------------------------------------------------
# ----------- */10 * * * * /path/to/ram-alert.sh -----------------
# ----------------------------------------------------------------
