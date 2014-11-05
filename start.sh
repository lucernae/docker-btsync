#!/bin/bash

# Put any tasks you would like to have carried
# out when the container is first created here

# We expect the container is started with the
# the users ~ directory mounted as /home/$USER

# Make the user matching the user from the mounted home
# We assume there will only be one user dir in home
# hence tail -1
USER_ID=`ls -lahn /web | tail -1 | awk {'print $3'}`
GROUP_ID=`ls -lahn /web | tail -1 | awk {'print $4'}`
USER_NAME=`ls -lah /web | tail -1 | awk '{print $3}'`

groupadd -g $GROUP_ID qgis
useradd --shell /bin/bash --uid $USER_ID --gid $GROUP_ID $USER_NAME
#cp /tmp/btsync.conf /${USER_NAME}/btsync.conf
#chown ${USER_NAME}.${USER_NAME} /${USER_NAME}/btsync.conf

if [ -z "${SECRET}" ]; then
    echo "Please set a btsync secret using docker -e SECRET=12321321"
    exit 1
fi

echo "Setting secret to ${SECRET}"
rpl "SECRET" "${SECRET}" /tmp/btsync.conf
rpl "DEVICE" "${DEVICE}" /tmp/btsync.conf
mkdir -p /btsync/.sync
chown ${USER_NAME}.${USER_NAME} /btsync/.sync
su $USER_NAME -c "btsync --config /tmp/btsync.conf --nodaemon"
