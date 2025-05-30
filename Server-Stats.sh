#!/bin/bash

echo "======================"
echo "📊 SERVER STATISTICS"
echo "======================"
echo ""

# CPU Usage
echo "🧠 CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
awk '{print "Used: " 100 - $8 "%"}'
echo ""

# Memory Usage
echo "💾 Memory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB / %sMB (%.2f%%)\n", $3, $2, $3*100/$2 }'
echo ""

# Disk Usage
echo "🗄️  Disk Usage:"
df -h --total | grep total | \
awk '{print "Used: " $3 " / " $2 " (" $5 ")"}'
echo ""

# Top 5 Processes by CPU Usage
echo "🔥 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

# Top 5 Processes by Memory Usage
echo "💡 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""

# OS Version
echo "🖥️  OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2
echo ""

# Uptime
echo "⏱️  Uptime:"
uptime -p
echo ""

# Load Average
echo "📈 Load Average:"
uptime | awk -F'load average:' '{ print $2 }'
echo ""

# Logged-in Users
echo "👥 Logged-in Users:"
who | wc -l
echo ""

# Failed Login Attempts (for systems using journalctl)
echo "🚫 Failed Login Attempts:"
if command -v journalctl &> /dev/null; then
    journalctl _COMM=sshd | grep "Failed password" | wc -l
else
    echo "journalctl not available - skipping."
fi
echo ""

echo "======================"
echo "✅ END OF REPORT"
echo "======================"
