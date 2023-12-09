#!/bin/bash

while true; do
    # Get date in dd/mm/yyyy format
    date_str=$(date +"%d/%m/%Y")

    # Get current time
    time_str=$(date +"%H:%M:%S")

    # Get battery percentage
    battery_percentage=$(acpi | awk '{print $4}' | tr -d '%,')
    
    # Get CPU usage percentage
    cpu_percentage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')

    # Print the formatted bar
    echo "%{c}Date: $date_str | Time: $time_str | Battery: $battery_percentage% | CPU: $cpu_percentage%"

    # Sleep for a short duration (adjust as needed)
    sleep 1
done

