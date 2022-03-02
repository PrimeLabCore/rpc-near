#!/bin/bash

# Install Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 


# Add wasm target to toolchain
#rustup target add wasm32-unknown-unknown