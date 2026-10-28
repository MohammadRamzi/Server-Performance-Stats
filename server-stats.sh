#!/bin/bash

echo " ======================================="
echo "         SERVER PERFORMANCE STATS"
echo " ======================================="

# --------------------
# CPU Usage
# --------------------

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

echo
echo " CPU Usage: ${cpu_usage}%"

# --------------------
# Memory Usage
# --------------------

memory_info=$(free -m)

total_memory=$(echo "$memory_info" | awk '/Mem:/ {print $2}')
used_memory=$(echo "$memory_info" | awk '/Mem:/ {print $3}')
free_memory=$(echo "$memory_info" | awk '/Mem:/ {print $4}')

memory_percentage=$(awk "BEGIN {printf \"%.2f\", ($used_memory/$total_memory)*100}")

echo
echo " Memory Usage:"
echo "   Total : ${total_memory} MB"
echo "   Used  : ${used_memory} MB"
echo "   Free  : ${free_memory} MB"
echo "   Usage : ${memory_percentage}%"

# --------------------
# Disk Usage
# --------------------

disk_info=$(df -h / | awk 'NR==2')

disk_total=$(echo "$disk_info" | awk '{print $2}')
disk_used=$(echo "$disk_info" | awk '{print $3}')
disk_free=$(echo "$disk_info" | awk '{print $4}')
disk_percentage=$(echo "$disk_info" | awk '{print $5}')

echo
echo " Disk Usage:"
echo "   Total : ${disk_total}"
echo "   Used  : ${disk_used}"
echo "   Free  : ${disk_free}"
echo "   Usage : ${disk_percentage}"

# --------------------
# Top 5 CPU Processes
# --------------------

echo
echo " Top 5 Processes by CPU Usage:"
echo " --------------------------------------"

ps aux --sort=-%cpu | head -n 6

# --------------------
# Top 5 Memory Processes
# --------------------

echo
echo " Top 5 Processes by Memory Usage:"
echo " --------------------------------------"

ps aux --sort=-%mem | head -n 6

echo
echo " ======================================="
