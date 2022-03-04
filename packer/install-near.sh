#!/bin/bash -x

sudo apt-get update
sudo apt-get install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python docker.io protobuf-compiler libssl-dev pkg-config clang llvm cargo awscli libclang-dev llvm-dev
git clone  https://github.com/near/nearcore
cd nearcore
git fetch origin --tags
git checkout tags/1.24.0 -b mynode
make release
./target/release/neard --home ~/.near init --chain-id mainnet --download-genesis --download-config
rm ~/.near/config.json
wget https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/mainnet/config.json -P ~/.near/
aws s3 --no-sign-request cp s3://near-protocol-public/backups/mainnet/rpc/latest .
LATEST=$(cat latest)
aws s3 --no-sign-request cp --no-sign-request --recursive s3://near-protocol-public/backups/mainnet/rpc/$LATEST ~/.near/data
 