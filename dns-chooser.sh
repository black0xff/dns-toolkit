#!/bin/bash

dns_servers='1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4 9.9.9.9 149.112.112.112 208.67.222.222  208.67.220.220 8.26.56.26 8.20.247.20 192.71.245.208 192.71.245.208 84.200.69.80 84.200.70.40 77.88.8.88 77.88.8.2 91.239.100.100 89.233.43.71 45.33.97.5 37.235.1.177 38.132.106.139 194.187.251.67 156.154.70.5 156.154.71.5 156.154.70.2 156.154.71.2 156.154.70.3 156.154.71.3 94.140.14.140 94.140.14.141 94.140.14.14 94.140.15.15 216.146.35.35 216.146.36.36 95.85.95.85 2.56.220.2 4.2.2.1 4.2.2.2'

red="\e[31m"
green="\e[32m"
# Check if bc is installed
if ! command -v bc &> /dev/null; then
  # Install bc using apt
  sudo apt install bc
fi
# Initialize variables for tracking lowest response time and server
lowest_time=999999  # Set a high initial value to ensure first server is considered
lowest_server=""

for dns in $dns_servers; do
  start_time=$(date +%s%3N)
  nslookup google.com $dns >/dev/null 2>&1  # Perform silent check
  end_time=$(date +%s%3N)
  elapsed_time=$(echo "scale=3; $end_time - $start_time" | bc)

  # Print results with color-coding for readability (optional)
  echo -e "$dns: took $elapsed_time ms to respond"

  # Update lowest time and server if current response is faster
  if [[ $(bc <<< "$elapsed_time < $lowest_time") -eq 1 ]]; then
    lowest_time=$elapsed_time
    lowest_server=$dns
  fi
done

# Announce the fastest server with clear formatting
echo -e "\n\nThe fastest server is: ${green}$lowest_server${reset}"
echo -e "It took ${green}$lowest_time ms${reset} to respond."
