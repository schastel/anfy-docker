FROM ubuntu:20.04
MAINTAINER schastel

ARG SCRIPTNAME=install.sh

RUN mkdir -p /INSTALL
WORKDIR "/INSTALL"
COPY ./install.sh ./
RUN chmod +x ./${SCRIPTNAME} && ./${SCRIPTNAME}
