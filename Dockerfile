FROM    ubuntu:18.04 as build

LABEL   maintainer="mark.irozuru@primelab.io"

ENV     DEBIAN_FRONTEND=noninteractive \
        TZ=Etx/UTC

RUN     apt-get update -qq && apt-get install -y \
        git \
        cmake \
        g++ \
        pkg-config \
        libssl-dev \
        curl \
        llvm \
        clang \
        binutils-dev \
        libcurl4-openssl-dev \
        zlib1g-dev \
        libdw-dev  \
        libiberty-dev  \
        gcc  \
        python \
        docker.io  \
        protobuf-compiler  \
        cargo \
        awscli \
        && rm -rf /var/lib/apt/lists/*

ENV     RUSTUP_HOME=/usr/local/rustup \
        CARGO_HOME=/usr/local/cargo \
        PATH=/usr/local/cargo/bin:$PATH

RUN     curl https://sh.rustup.rs -sSf | \
        sh -s -- -y --no-modify-path --default-toolchain none

VOLUME  [ /near ]

WORKDIR /near

RUN     git clone https://github.com/near/nearcore && cd nearcore;git fetch origin --tags && git checkout tags/${NEAR_VERSION} -b mynode && make release; cp ./target/release/neard /tmp/



# Actual image
FROM    ubuntu:18.04

EXPOSE  3030 24567

RUN     apt-get update -qq && apt-get install -y \
        libssl-dev ca-certificates \
        wget \
        && rm -rf /var/lib/apt/lists/*

COPY    --from=build /tmp/neard /usr/local/bin/

RUN     neard --home ~/.near init --chain-id mainnet --download-genesis --download-config

RUN     rm ~/.near/config.json && wget https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/mainnet/config.json -P ~/.near/

ENTRYPOINT [ "neard", "--home", "/root/.near", "run" ]