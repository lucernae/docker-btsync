BitTorrent Sync Dockerfile
==========================

This will build a [docker](http://www.docker/) image that runs [BitTorrent
Sync](http://labs.bittorrent.com/experiments/sync.html).

## Getting the image

There are various ways to get the image onto your system:


The preferred way (but using most bandwidth for the initial image) is to
get our docker trusted build like this:


```
docker pull kartoza/btsync
```

To build the image yourself without apt-cacher (also consumes more bandwidth
since deb packages need to be refetched each time you build) do:

```
docker build -t kartoza/btsync git://github.com/kartoza/docker-btsync
```

To build with apt-cache (and minimised download requirements) do you need to
clone this repo locally first and modify the contents of 71-apt-cacher-ng to
match your cacher host. Then build using a local url instead of directly from
github.

```
git clone git://github.com/kartoza/docker-btsync
```

Now edit ``71-apt-cacher-ng`` then do:

```
docker build -t kartoza/btsync .
```

## Run


To create a running container do:

```
docker run --name "myname.kartoza.com" \
	--restart=always \
	--hostname="myname.kartoza.com" \
	-e SECRET=123456 \
	-e DEVICE=somedevice.kartoza.com \
	-v /home/blah/yourshare:/web \
	-d -t kartoza/btsync
```

You should use the following environment variables to pass a 
user DEVICE name (it will show up as this in your docker sync lists) and SECRET
(use a read only secret normally). 

* -e SECRET=<secret> 
* -e DEVICE=<device name>

We recommend that you share your storage directory as a volume mounted
as /web into the container - this will allow you to destroy and
recreate the container without losing you synced data.

# Tutorial

More details are available in [this tutorial](http://blog.bittorrent.com/2013/10/22/sync-hacks-deploy-bittorrent-sync-with-docker/).
