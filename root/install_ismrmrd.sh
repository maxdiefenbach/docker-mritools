#!/bin/bash

ISMRMRD_GIT_REPO="ismrmrd/ismrmrd"
ISMRMRD_VERSION=$(curl --silent \
                       "https://api.github.com/repos/$ISMRMRD_GIT_REPO/releases/latest" | \
                      grep "tag_name" | \
                      egrep -o '[0-9.]+' | \
                      tr -d '\n')
ISMRMRD_DIR="ismrmrd-v$ISMRMRD_VERSION"

# Clean up
rm -rf "$ISMRMRD_DIR"

# Install dependencies
apt-get update
apt-get install -y build-essential \
        gcc make cmake \
        libboost-all-dev \
        fftw3-dev \
        h5utils \
        hdf5-tools \
        libhdf5-serial-dev \
        libxml2-dev \
        libxslt1-dev

# Clone source code
git clone "https://github.com/$ISMRMRD_GIT_REPO" "$ISMRMRD_DIR"

# Checkout latest release
cd "$ISMRMRD_DIR"
git fetch --tags
version=$(git tag -l | tail -n 1)
git checkout "$ISMRMRD_VERSION"

# # Download and extract source
# ISMRMRD_TARBALL="v$ISMRMRD_VERSION.tar.gz"
# wget "https://github.com/$ISMRMRD_GIT_REPO/archive/$ISMRMRD_TARBALL"
# mkdir "$ISMRMRD_DIR" && tar -xzvf "$ISMRMRD_TARBALL" --strip=1 -C "$ISMRMRD_DIR"

# Build
cd "$ISMRMRD_DIR"
mkdir "build"
cd "build"
cmake ../
make
make install

# Clean up
cd ..
rm -rf "build"
cd ~
