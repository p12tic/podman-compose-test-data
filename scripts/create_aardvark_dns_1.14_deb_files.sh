#!/bin/bash
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y devscripts build-essential
git clone --branch debian-1.14 --single-branch https://github.com/p12tic/podman-compose-test-aardvark-dns.git
cd podman-compose-test-aardvark-dns
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | RUSTUP_INIT_SKIP_PROMPT=1 sh -s -- -y
. "$HOME/.cargo/env"
DEBIAN_FRONTEND=noninteractive mk-build-deps --install --remove --tool 'apt-get --no-install-recommends -y'
debuild -us -uc -b
