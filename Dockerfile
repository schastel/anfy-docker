FROM ubuntu:20.04
MAINTAINER schastel

ARG SCRIPTNAME=install.sh

RUN mkdir -p /INSTALL
WORKDIR "/INSTALL"
COPY ./${SCRIPTNAME} ./

RUN apt-get update && apt-get upgrade -y && DEBIAN_FRONTEND="noninteractive" TZ="Pacific/Honolulu" apt-get install -y wget make gcc build-essential curl git file pkg-config swig libcairo2-dev libnetpbm10-dev netpbm libpng-dev libjpeg-dev zlib1g-dev libbz2-dev libcfitsio-dev wcslib-dev python3 python3-pip python3-distutils python3-dev python3-numpy python3-scipy python3-pil astropy-utils

RUN chmod +x ./${SCRIPTNAME} && ./${SCRIPTNAME}
