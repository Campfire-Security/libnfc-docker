# libnfc-docker
Docker implementation of libnfc which can interact with your USB bus.

## Usage
You can use the container by either running bash or singular comamnds ex nfc-list etc.  
The workdirectory of the container is /root/dumps, so you can bind whatever volume on your hosts and you will have any dumps you create available in that volume.  
It is also important that you mount your usb bus.  
Please see the following examples  

**bash**  
`docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v ./dumps:/root/dumps ghcr.io/campfire-security/libnfc-docker /bin/bash`  
You should now be in a bash session inside the docker container where you can use nfc-list etc. as you desire

**Singular commands**  
`docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v ./dumps:/root/dumps ghcr.io/campfire-security/libnfc-docker r a u dump.mfd keyfile.mfd`

## Third-Party Licenses

This project uses libnfc (LGPL-3.0): https://github.com/nfc-tools/libnfc
This project uses mfoc (GPL-2.0): https://github.com/nfc-tools/mfoc
