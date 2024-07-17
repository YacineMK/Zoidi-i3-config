#!/bin/bash

while true; do

    date_str=$(date +"%d/%m/%Y")
    time_str=$(date +"%H:%M")

    battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage:")
    battery_percentage=$(echo "$battery_info" | grep -oP '\d+' | head -n1)
    battery_status=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state:" | awk '{print $2}')

    if [ "$battery_status" == "charging" ]; then
        battery_icon=" "
    elif [ "$battery_status" == "discharging" ]; then
        battery_icon=" "
    fi
    cpu_percentage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')
    temperature=$(cat /sys/class/thermal/thermal_zone0/temp)
    temperature_celsius=$((temperature/1000))
    if [ "$battery_percentage" -lt 25 ]; then
        battery_color="%{F#FFA500}"  
    else
        battery_color="%{F-}"  
    fi

    if [ "$temperature_celsius" -ge 80 ]; then
        temp_color="%{F#FF0000}" 
    else
        temp_color="%{F-}"  
    fi

    echo "$date_str |  $time_str |   $battery_icon $battery_percentage% Battery |  $cpu_percentage% CPU |  $temperature_celsius°C  "

    sleep 1
done

