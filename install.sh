#!/bin/bash

apt-get update
apt-get upgrade -y
# DEBIAN_FRONTEND + TZ is just a way to prevent the install to be interrupt by
# questions about the location/timezone
DEBIAN_FRONTEND="noninteractive" TZ="Pacific/Honolulu" apt-get install -y wget make gcc build-essential curl git file pkg-config swig \
       libcairo2-dev libnetpbm10-dev netpbm libpng-dev libjpeg-dev \
       zlib1g-dev libbz2-dev libcfitsio-dev wcslib-dev \
       python3 python3-pip python3-distutils python3-dev \
       python3-numpy python3-scipy python3-pil astropy-utils

wget https://astrometry.net/downloads/astrometry.net-latest.tar.gz
tar xvfz astrometry.net-latest.tar.gz 
cd astrometry.net-0.85/
make -j
# make extra # crashes
make install

# Data
cd /usr/local/astrometry/data/

# Index files are at: http://broiler.astrometry.net/~dstn/4200/
INDEXFILES=index-4212.fits # Add the files you need

for indexfile in $INDEXFILES; do
    wget http://broiler.astrometry.net/~dstn/4200/$indexfile
done

## TESTING
## And now, testing with the first example in Solving section at:
## https://astrometry.net/doc/readme.html
# cd /INSTALL/astrometry.net-0.85
# /usr/local/astrometry/bin/solve-field --scale-low 10 demo/apod4.jpg
#
# ... gives something like:
# Reading input file 1 of 1: "demo/apod4.jpg"...
# [...]
#  The star 13Boo
#  The star κVir
#
