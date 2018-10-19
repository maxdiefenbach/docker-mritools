#!/bin/bash

BART_GIT_REPO="mrirecon/bart"
BART_VERSION=$(curl --silent \
                    "https://api.github.com/repos/$BART_GIT_REPO/releases/latest" | \
                   grep "tag_name" | \
                   egrep -o '[0-9.]+' | \
                   tr -d '\n')
BART_DIR="bart-v$BART_VERSION"

# Clean up
rm -rf "$BART_DIR"

# Install dependencies
apt-get update
apt-get install -y \
        gcc make cmake \
        libopenblas-dev \
        libfftw3-dev \
        liblapacke-dev \
        libpng-dev \
        libgomp1

# Clone source code
git clone "https://github.com/$BART_GIT_REPO" "$BART_DIR"

# Checkout latest release
cd "$BART_DIR"
git fetch --tags
version=$(git tag -l | tail -n 1)
git checkout "$BART_VERSION"

# # Download and extract source
# BART_TARBALL="v$BART_VERSION.tar.gz"
# wget "https://github.com/$BART_GIT_REPO/archive/$BART_TARBALL"
# mkdir "$BART_DIR" && tar -xzvf "$BART_TARBALL" --strip=1 -C "$BART_DIR"

# Build
cd "$BART_DIR"
make
make install
make ismrmrd

# Run tests
make utest
