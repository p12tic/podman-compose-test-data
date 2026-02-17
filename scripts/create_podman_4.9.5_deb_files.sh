#!/bin/bash
echo 'deb http://deb.debian.org/debian bookworm-backports main' > /etc/apt/sources.list.d/backports.list
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git
git clone --depth 1 --branch debian-4.9.5 https://github.com/p12tic/podman-compose-test-podman.git podman-4.9.5
cd podman-4.9.5/
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends devscripts bash-completion conmon \
    build-essential libsubid-dev dh-golang go-md2man golang-go libapparmor-dev libbtrfs-dev libdevmapper-dev \
    golang-1.22/bookworm-backports debhelper pkg-config libsystemd-dev libgpgme-dev libseccomp-dev libglib2.0-dev \
    golang-dbus-dev
rm /usr/bin/go
ln -s /usr/lib/go-1.22/bin/go /usr/bin/go
go mod tidy
DEB_BUILD_OPTIONS=nocheck debuild -us -uc -b