#!/bin/bash
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git lintian go-md2man protobuf-compiler dh-cargo devscripts \
    build-essential debhelper dpkg-dev
git clone --branch debian-1.14 --single-branch https://github.com/p12tic/podman-compose-test-netavark.git
cd podman-compose-test-netavark
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | RUSTUP_INIT_SKIP_PROMPT=1 sh -s -- -y
. "$HOME/.cargo/env"
debuild -us -uc -b
