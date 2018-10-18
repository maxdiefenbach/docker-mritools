#!/bin/bash

bart_dir="bart/"
repo='mrirecon/bart'
version=$(curl --silent "https://api.github.com/repos/$repo/releases/latest" | \
              grep "tag_name" | \
              egrep -o '[0-9.]+' | \
              tr -d '\n')
tarball="v$version.tar.gz"

mkdir "$bart_dir"
tar -xvzf "$tarball" --strip-components=1 -C "$bart_dir"

cd "$bart_dir"

mkdir "build"
cd "build"
cmake ..
make
# sudo make install

echo "\nbart v$version sucessfully compiled!"
echo "you can now cd to $(pwd) and run"
echo "$ sudo make install"
echo "to finally install the bart commandline tool"
