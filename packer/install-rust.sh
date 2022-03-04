#!/bin/bash -x

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. $HOME/.cargo/env
rustup target add wasm32-unknown-unknown
rustup --version
echo export PATH='$HOME/.cargo/bin:$PATH' >> ~/.bashrc

