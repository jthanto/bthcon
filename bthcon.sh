#!/bin/bash

##########################################
# Bluetooth headset connector a2dp link. #
##########################################
#   only one bluetooth device connected  #
##########################################

echo 'Finding ONE paired device'

MACADDR=`bluez-test-device list | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'`

if [ -z $MACADDR ]; then
	echo ERR: Found no paired 
else
	echo SUC: Found $MACADDR
	echo SUC: Unpairing device $MACADDR
	RESULT=`bt-device -r "$MACADDR"`
fi

echo 'searching for new device'

NEWDEV=`hcitool scan | grep -o -E -m 1 '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'`
MYBT = `hciconfig | grep -o -E -m 1 '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'`

if [ -z $NEWDEV ]; then
	echo ERR: Found no paired device
	exit
else
	echo SUC: Found $MYBT
	echo SUC: Found $NEWDEV
	
	echo SUC: Pairing device $NEWDEV with $MYBT
	RESULT=`bluez-simple-agent hci0 $NEWDEV`

	echo TRY: Connecting to $NEWDEV
	RESULT=`bt-audio -c $NEWDEV`
	
	echo Changing to A2DP sound
	RESULT`pactl set-card-profile bluez_card.$NEWDEV a2dp`
	
fi




