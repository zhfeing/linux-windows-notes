# Setup GCC

"""
./contrib/download_prerequisites
mkdir build && cd build
../configure  --enable-checking=release --enable-languages=c,c++ --disable-multilib --prefix=/path/you/want/to/install
make -j8
make install
"""