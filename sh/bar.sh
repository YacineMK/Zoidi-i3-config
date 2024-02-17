#!/bin/bash

while true; do
    # Get date in dd/mm/yyyy format
    date_str=$(date +"%d/%m/%Y")

    # Get current time
    time_str=$(date +"%H:%M")

    # Get battery percentage
    battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage:")
    battery_percentage=$(echo "$battery_info" | grep -oP '\d+' | head -n1)

    # Get battery status
    battery_status=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state:" | awk '{print $2}')

    # Convert battery status to an icon
    if [ "$battery_status" == "charging" ]; then
        battery_icon=" "
    elif [ "$battery_status" == "discharging" ]; then
        battery_icon=" "
    fi

    # Get CPU usage percentage
    cpu_percentage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')

    # Get temperature (assuming it's available in the thermal_zone0)
    temperature=$(cat /sys/class/thermal/thermal_zone0/temp)
    temperature_celsius=$((temperature/1000))

    # Set the color based on battery percentage
    if [ "$battery_percentage" -lt 25 ]; then
        battery_color="%{F#FFA500}"  # Orange color
    else
        battery_color="%{F-}"  # Default color
    fi

    # Set the color based on temperature threshold
    if [ "$temperature_celsius" -ge 80 ]; then
        temp_color="%{F#FF0000}"  # Red color
    else
        temp_color="%{F-}"  # Default color
    fi

    # Print the formatted bar with numeric battery percentage, color, and temperature
    echo "$date_str |  $time_str |   $battery_icon $battery_percentage% Battery |  $cpu_percentage% CPU |  $temperature_celsius°C  "

    # Sleep for a short duration (adjust as needed)
    sleep 1
done

