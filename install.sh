#!/bin/bash

wget https://astrometry.net/downloads/astrometry.net-latest.tar.gz
tar xvfz astrometry.net-latest.tar.gz 
cd astrometry.net-0.85/
make -j
# make extra # crashes?
make install
