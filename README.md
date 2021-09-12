# Pull image from docker.io (no account needed)

`
docker pull docker.io/schastel/anfy:latest
`

# Use a docker volume in the host to store the index files

The idea is to download the index files from
http://broiler.astrometry.net/~dstn/4200/ to your host in some
directory (let's say /tmp/anfy/index-files to fix ideas) and
use them in the docker container.

```
mkdir -p /tmp/anfy/index-files
cd /tmp/anfy/index-files
# For instance
wget http://broiler.astrometry.net/~dstn/4200/index-4212.fits
```

You will later use that directory as a volume in docker when running the container.

# Use a docker volume in the host for your work directory

Similarly, for your own work (I will use the file https://github.com/dstndstn/astrometry.net/blob/main/demo/apod2.jpg for testing):

```
mkdir -p /tmp/anfy/my-work
cd /tmp/anfy/my-work
wget https://raw.githubusercontent.com/dstndstn/astrometry.net/main/demo/apod4.jpg
```

# Run a container using the two directory/volumes

```
docker run --rm -ti -v /tmp/anfy/index-files:/usr/local/astrometry/data -v /tmp/anfy/my-work:/my-work docker.io/schastel/anfy:latest /bin/bash
```

Note that in Windows that would translate to something like:
```
docker run --rm -ti -v C:\users\index-files:/usr/local/astrometry/data -v C:\users\my-work:/my-work docker.io/schastel/anfy:latest /bin/bash
```

In MacOs, there should not be any difference with Linux.

Notes: 

* `--rm`: Delete the container when exiting, `-ti`: Interactive (equivalent to `-t -i`) , `-v`: Identify the volumes... Better: `docker help run` for all details

* When exiting the container, the history of your commands will be lost (Run `history > /my-work/history-20210621` to save the history in the history-20210621 file before exiting).

# Testing (in the container)

(Note that this test is the first example of the Solving section at: https://astrometry.net/doc/readme.html

```
cd /my-work
/usr/local/astrometry/bin/solve-field --scale-low 10 apod4.jpg
```

which gives something like:
```
Reading input file 1 of 1: "demo/apod4.jpg"...
[...]
The star 13Boo
The star κVir
```

