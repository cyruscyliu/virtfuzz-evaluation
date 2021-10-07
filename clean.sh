#!/bin/bash -x
VERSION=$1 # usually 5 or 6
cd ../qemu/build-clean-$VERSION
if [ $VERSION == '6' ]; then
    CC=clang CXX=clang++ ../configure --enable-fuzzing --enable-debug \
        --disable-werror \
        --target-list="i386-softmmu arm-softmmu aarch64-softmmu"
    ninja qemu-fuzz-i386 qemu-fuzz-arm qemu-fuzz-aarch64
    cd $OLDPWD
elif [ $VERSION == '5' ]; then
    CC=clang CXX=clang++ ../configure --enable-debug \
        --disable-werror \
        --target-list="i386-softmmu arm-softmmu aarch64-softmmu"
    make CONFIG_FUZZ=y CFLAGS="-fsanitize=fuzzer -g" -j$(nproc) \
        i386-softmmu/fuzz arm-softmmu/fuzz aarch64-softmmu/fuzz
    cp i386-softmmu/qemu-fuzz-i386 .
    cp arm-softmmu/qemu-fuzz-arm .
    cp aarch64-softmmu/qemu-fuzz-aarch64 .
    cd $OLDPWD
fi
