#!/bin/bash

REPO='mrirecon/bart'
BARTDIR='bart'

# # dependencies
# sudo apt-get update
#     && apt-get install -y build-essential \
#                cmake \
#                libboost-all-dev \
#                fftw-dev \
#                libhdf5-serial-dev \
#                hdf5-tools \
#                libxml2-dev \
#                libxslt1-dev \
#                unzip
# brew install fftw gcc libpng openblas

# clone source code
git clone "https://github.com/$REPO" "$BARTDIR"

# checkout latest release
cd "$BARTDIR"
git fetch --tags
version=$(git tag -l | tail -n 1)
git checkout "$version"

# build
mkdir "build"
cd "build"
cmake ..
make

# run  tests
make utest
make test

# install
sudo make install

# rm artefacts
# cd ..
# rm -rf "build"

# info
echo "bart $version sucessfully compiled!"
