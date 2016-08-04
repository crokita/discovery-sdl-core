#!/bin/bash
# Replaces the IP address in smartDeviceLink.ini with the machine's IP address and then runs SmartDeviceLink Core.
# The IP is required to be replaced for the websocket connection with the HMI to function.

# Get the machine's IP address
DOCKER_IP="$(ip addr show ${CORE_NETWORK_INTERFACE} | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)"
echo "Changing smartDeviceLink.ini HMI ServerAddress to ${DOCKER_IP}"

# Replace the IP address in smartDeviceLink.ini with the machines IP address
perl -pi -e 's/127.0.0.1/'$DOCKER_IP'/g' /usr/sdl/src/appMain/smartDeviceLink.ini

#Start SDL Core
/usr/sdl/src/appMain/smartDeviceLinkCore