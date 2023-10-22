#!/bin/bash

# Replace these variables with your VPN server information
VPN_SERVER="42.116.30.242"
VPN_USERNAME="quyet.doan"
VPN_PASSWORD="l4X+y53BP6VC"

# Check if strongSwan is installed
if ! type ipsec &>/dev/null; then
    echo "StrongSwan is not installed. Please install it using 'sudo apt-get install strongswan' and try again."
    exit 1
fi

# Check if the VPN connection is already established
if ipsec statusall | grep -q "ESTABLISHED"; then
    echo "VPN is already connected."
    exit 0
fi

# Start the VPN connection
echo "Starting VPN connection to $VPN_SERVER..."
ipsec up myvpn

# Wait for the connection to be established
sleep 5

# Check if the VPN connection is now established
if ipsec statusall | grep -q "ESTABLISHED"; then
    echo "VPN connection to $VPN_SERVER established."
else
    echo "Failed to establish the VPN connection. Check your VPN server, username, and password."
fi

exit 0
