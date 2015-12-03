#!/bin/sh
#
# ./snic.sh -silent -responseFile /tmp/my_response_file.txt
# /mnt/ses_11_2_2_2_0_linux64/runInstaller
#
#
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
IMAGE="jhazelwo/siebel"

# Full path to unpacked Siebel install files
unpacked="/media/sf_vm-shared-rw/unpacked/"

V="-v ${unpacked}:/mnt/"
V="$V -v $XSOCK:$XSOCK"
V="$V -v $XAUTH:$XAUTH"
V="$V -v /tmp/.X11-unix:/tmp/.X11-unix"

# E="-e XAUTHORITY=$XAUTH"
# N="-h bofh --name=bofh"

#M="--shm-size=1g"

#  http://stackoverflow.com/a/25280523
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
docker run -t $V $E $N $M -i $IMAGE /bin/bash

