#!/bin/bash
echo 'deb http://deb.debian.org/debian bookworm-backports main' > /etc/apt/sources.list.d/backports.list
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git
git clone --depth 1 --branch debian-5.4.2 https://github.com/p12tic/podman-compose-test-podman.git podman-5.4.2
cd podman-5.4.2
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential debhelper dh-golang golang-1.22 golang-go \
    libapparmor-dev libbtrfs-dev libdevmapper-dev libglib2.0-dev \
    libgpgme-dev libseccomp-dev libsubid-dev libsystemd-dev \
    pkg-config devscripts bash-completion conmon go-md2man golang-dbus-dev
DEBIAN_FRONTEND=noninteractive apt-get install -y golang-1.22/bookworm-backports
rm /usr/bin/go
ln -s /usr/lib/go-1.22/bin/go /usr/bin/go
DEBIAN_FRONTEND=noninteractive apt remove -y golang-1.19
go mod tidy
git archive --worktree-attributes --prefix=podman-5.4.2+composetest/ HEAD --format=tar.gz -o \
    ../podman_5.4.2+composetest.orig.tar.gz
go install -trimpath -v -p 8 -tags "apparmor seccomp selinux systemd libsubid" -ldflags \
    "-X github.com/containers/podman/libpod/define.buildInfo=1753462038 \
    -X github.com/containers/podman/libpod/define.buildOrigin=Debian" ./cmd/podman
apt --fix-broken install -y
export DEB_BUILD_OPTIONS=nocheck
debuild -us -uc -b
