# Pull image from docker.io (no account needed)

`
docker pull docker.io/schastel/anfy:latest
`

# Use a (local) docker volume to store the index files

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

Now let's create a docker volume named `anfy-index-files`:

`
docker volume create --driver local --opt type=ext4 --opt o=bind --opt device=/tmp/anfy/index-files --name=anfy-index-files
`

We will use it when running the container

# Use a (local) docker volume for your work directory

Similarly, for your own work (I will use the file https://github.com/dstndstn/astrometry.net/blob/main/demo/apod2.jpg for testing):

`
mkdir -p /tmp/anfy/my-work
cd /tmp/anfy/my-work
wget https://raw.githubusercontent.com/dstndstn/astrometry.net/main/demo/apod4.jpg
`

To create a docker volume
`
docker volume create --driver local --opt type=ext4 --opt o=bind --opt device=/tmp/anfy/my-work --name=anfy-my-work
`

# Run a container using the two volumes

`
docker run --rm -ti -v anfy-index-files:/usr/local/astrometry/data -v anfy-my-work:/my-work docker.io/schastel/anfy:latest /bin/bash
`

Notes: 

* `--rm`: Delete the container when exiting, `-ti`: Interactive (equivalent to `-t -i`) , `-v`: Identify the volumes... Better: `docker help run` for all details

* When exiting the container, the history is lost (`history > /my-work/history-20210621` to save the history in the history-20210621 file).

# Testing

(Note that this test is the first example of the Solving section at: https://astrometry.net/doc/readme.html

`
cd /my-work
/usr/local/astrometry/bin/solve-field --scale-low 10 apod4.jpg
`

which gives something like:
`
Reading input file 1 of 1: "demo/apod4.jpg"...
[...]
The star 13Boo
The star κVir
`
