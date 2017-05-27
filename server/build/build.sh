#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# build bamReadDepther
rm -rf $DIR/bamReadDepther
git clone https://github.com/chmille4/bamReadDepther.git $DIR/bamReadDepther;
git --git-dir $DIR/bamReadDepther/.git checkout f3c070dd9f229177289263177dd94f3b151a1f09
g++ $DIR/bamReadDepther/bamReadDepther.cpp -o $DIR/bamReadDepther/bamReadDepther
ln -sf $DIR/bamReadDepther/bamReadDepther $DIR/../scripts/bamReadDepther

# build samtools
rm -rf $DIR/samtools-1.4.1
pushd .
cd $DIR/
curl -L "https://github.com/samtools/samtools/releases/download/1.4.1/samtools-1.4.1.tar.bz2" | tar -xj
cd $DIR/samtools-1.4.1    # Within the unpacked release directory
./configure  --enable-libcurl --disable-lzma
make
popd
ln -sf $DIR/samtools-1.4.1/samtools $DIR/../scripts/samtools

# build bamtools
rm -rf $DIR/bamtools
git clone git://github.com/pezmaster31/bamtools.git $DIR/bamtools;
mkdir -p $DIR/bamtools/build; cd $DIR/bamtools/build
cmake ..
make
cd -
ln -sf $DIR/bamtools/bin/bamtools $DIR/../scripts/bamtools

# build bamstatsalive
rm -rf $DIR/bamstatsalive
git clone https://github.com/yiq/bamstatsAlive.git $DIR/bamstatsalive
export BAMTOOLS=$DIR/bamtools/
make -C $DIR/bamstatsalive
ln -sf $DIR/bamstatsalive/bamstatsalive $DIR/../scripts/bamstatsalive