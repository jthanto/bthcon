bthcon
======

#Why
Because of issues when connecting bluetooth headset to Ubuntu 14.04, 
there was made a script for unpairing existing device, scanning for new device, 
pairing it again, then connecting with the bt-auido module and setting the
card profile to a2dp.

#Disclaimer
This script is by no means waterproof, and will fail if your device 
is not the first revaled in scan.

Only tested ONCE in Ubuntu 14.04.

#How
- Set your headset in pairing mode
- Run bthcon.sh

