#!/bin/bash
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git build-essential pkg-config libsystemd-dev libprotobuf-c-dev \
    libcap-dev libseccomp-dev libyajl-dev devscripts debhelper dpkg-dev go-md2man \
    golang-github-opencontainers-image-spec-dev gperf autoconf automake libtool
git clone --branch debian-1.21 --single-branch https://github.com/p12tic/podman-compose-test-crun.git
cd podman-compose-test-crun
# debuild does not work without these commands
./autogen.sh
./configure
make
DEB_BUILD_OPTIONS=nocheck debuild -us -uc -b

