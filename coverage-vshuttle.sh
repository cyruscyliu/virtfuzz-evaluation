#!/bin/bash -x
VERSION=$1 # usually 5 or 6
TARGET=$2
cd ../qemu-5.1.0/build-coverage-vshuttle-$VERSION
if [ $VERSION == '6' ]; then
    CLANG_COV_DUMP=1 CC=clang CXX=clang++ ../configure --enable-fuzzing \
        --disable-werror --disable-sanitizers \
        --extra-cflags="-DCLANG_COV_DUMP -DVIRTFUZZ_LESS_CRASHES -fprofile-instr-generate -fcoverage-mapping" \
        --target-list="i386-softmmu arm-softmmu aarch64-softmmu"
    ninja qemu-fuzz-i386 qemu-fuzz-arm qemu-fuzz-aarch64
    cd $OLDPWD
elif [ $VERSION == '5' ]; then
    CLANG_COV_DUMP=1 CC=clang CXX=clang++ ../configure \
        --disable-werror --disable-sanitizers --cc=afl-clang \
        --target-list="i386-softmmu"
    make CFLAGS="-DCLANG_COV_DUMP -DVIRTFUZZ_LESS_CRASHES \
        -fprofile-instr-generate -fcoverage-mapping" -j$(nproc)
    cp i386-softmmu/qemu-system-i386 qemu-system-i386-vshuttle-$TARGET
    cd $OLDPWD
fi
