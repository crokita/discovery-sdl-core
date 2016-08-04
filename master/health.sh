#script to check if core process is running
PROCESS="$(ps -C smartDeviceLink --no-headers)"

#if there is no output then smartDeviceLink isn't running
if [ "$PROCESS" = "" ]; then
	echo 2 #failed
else
	echo 0 #success
fi