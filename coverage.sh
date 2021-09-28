#!/bin/bash -x
VERSION=$1 # usually 5 or 6
cd ../qemu/build-coverage-$VERSION
if [ $VERSION == '6' ]; then
    CLANG_COV_DUMP=1 CC=clang CXX=clang++ ../configure --enable-fuzzing \
        --disable-werror \
        --extra-cflags="-DCLANG_COV_DUMP -fprofile-instr-generate -fcoverage-mapping" \
        --target-list="i386-softmmu arm-softmmu aarch64-softmmu"
    ninja qemu-fuzz-i386 qemu-fuzz-arm qemu-fuzz-aarch64
    cd $OLDPWD
elif [ $VERSION == '5' ]; then
    CLANG_COV_DUMP=1 CC=clang CXX=clang++ ../configure \
        --disable-werror \
        --target-list="i386-softmmu arm-softmmu aarch64-softmmu"
    make CONFIG_FUZZ=y CFLAGS="-DCLANG_COV_DUMP -fsanitize=fuzzer \
        -fprofile-instr-generate -fcoverage-mapping" -j$(nproc) \
        i386-softmmu/fuzz arm-softmmu/fuzz aarch64-softmmu/fuzz
    cp i386-softmmu/qemu-fuzz-i386 .
    cp arm-softmmu/qemu-fuzz-arm .
    cp aarch64-softmmu/qemu-fuzz-aarch64 .
    cd $OLDPWD
fi
