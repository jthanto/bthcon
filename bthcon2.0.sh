#!/bin/bash

##########################################
# Bluetooth headset connector a2dp link. #
##########################################
#   only one bluetooth device connected  #
##########################################

#echo 'Finding ONE paired device'

#MACADDR=(`bluez-test-device list | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'`)
#echo ${MACADDR[@]}

#if [ -z $MACADDR ]; then
#	echo ERR: Found no paired 
#else
#	echo SUC: Found $MACADDR
#	echo SUC: Unpairing device $MACADDR
#	RESULT=`bt-device -r "$MACADDR"`
#fi

echo 'searching for devices'
NEWDEV=(`hcitool scan | grep -o -E -m 1 '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}\s.*'`)
#MYBT = `hciconfig | grep -o -E -m 1 '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}\s.*'`

if [ ${#NEWDEV[@]} -eq 0 ]; then
	echo "Found no devices :("
else
	echo "Found devices:"
	echo ${NEWDEV[@]}
	
	read -p "Pick a device: " SELECTED
	SELDEV=${NEWDEV[SELECTED]}
	
	printf "\n $SELDEV picked"
	
	echo SUC: Pairing with device $SELDEV
	RESULT=`bluez-simple-agent hci0 $SELDEV`
	
	echo TRY: Connectiong to $SELDEV
	RESULT=`bt-audio -c $SELDEV`
	
	echo Changing to A2DP sound
	RESULT=`pactl set-card-profile bluez_card.$NEWDEV a2dp`
fi
