#!/bin/bash

# System Monitor
# Author: Jacob Samudio
# Github: jsamudioDev

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}================================${NC}"
echo -e "${GREEN}    SYSTEM MONITOR REPORT       ${NC}"
echo -e "${BLUE}================================${NC}"
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo ""

# CPU
echo -e "${BLUE}--- CPU ---${NC}"
echo "Governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
echo "Usage: $(top -bn1 | grep 'Cpu(s)' | awk '{print $2}')%"
echo ""

# RAM
echo -e "${BLUE}--- RAM ---${NC}"
free -h | awk 'NR==2 {print "Total: "$2"  Used: "$3"  Free: "$4}'
echo ""

# Disk
echo -e "${BLUE}--- DISK ---${NC}"
df -h | grep -E 'nvme|sd' | awk '{print "Mount: "$6"  Size: "$2"  Used: "$3"  Free: "$4"  Use: "$5}'
echo ""

# Active Users
echo -e "${BLUE}--- ACTIVE USERS ---${NC}"
who
echo ""

# Services
echo -e "${BLUE}--- RUNNING SERVICES ---${NC}"
systemctl list-units --type=service --state=running | grep running | awk '{print $1}' | head -10
echo ""

# Top Processes
echo -e "${BLUE}--- TOP 5 PROCESSES ---${NC}"
ps aux --sort=-%cpu | awk 'NR==1 || NR<=6 {printf "%-10s %-6s %-6s %s\n", $1, $2, $3, $11}' | head -6
echo ""

echo -e "${BLUE}================================${NC}"
echo -e "${GREEN}        END OF REPORT           ${NC}"
echo -e "${BLUE}================================${NC}"
