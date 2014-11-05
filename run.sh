#!/bin/bash

HOST_DATADIR=/foo
BTSYNC_IMAGE=btsync

docker kill ${BTSYNC_IMAGE}
docker rm ${BTSYNC_IMAGE}

mkdir -p ${HOST_DATADIR}

docker run --name="${BTSYNC_IMAGE}" \
	-v ${HOST_DATADIR}:/web \
	-p 8888:8888 \
	-p 55556:55555 \
	-d -t kartoza/${BTSYNC_IMAGE}


