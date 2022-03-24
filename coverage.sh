#!/bin/bash -x
VERSION=$1 # usually 5 or 6
VIDEZZO=$2
cd ../qemu/build-coverage-$VERSION
if [ $VERSION == '6' ]; then
    CLANG_COV_DUMP=1 CC=clang CXX=clang++ ../configure --enable-fuzzing \
        --disable-werror --disable-sanitizers \
        --extra-cflags="-DCLANG_COV_DUMP -DVIRTFUZZ_LESS_CRASHES -fprofile-instr-generate -fcoverage-mapping" \
        --target-list="i386-softmmu arm-softmmu aarch64-softmmu"
    ninja qemu-fuzz-i386 qemu-fuzz-arm qemu-fuzz-aarch64
    cd $OLDPWD
elif [ $VERSION == '5' ]; then
    if [ $VIDEZZO == '1' ]; then
        CLANG_COV_DUMP=1 CC=clang CXX=clang++ ../configure \
            --disable-werror --enable-videzzo --disable-sanitizers \
            --target-list="i386-softmmu arm-softmmu aarch64-softmmu"
    else
        CLANG_COV_DUMP=1 CC=clang-10 CXX=clang++-10 ../configure \
            --disable-werror --disable-sanitizers \
            --target-list="i386-softmmu arm-softmmu aarch64-softmmu"
    fi
    make CONFIG_FUZZ=y CFLAGS="-DCLANG_COV_DUMP -DVIRTFUZZ_LESS_CRASHES -fsanitize=fuzzer \
        -fprofile-instr-generate -fcoverage-mapping" -j$(nproc) \
        i386-softmmu/fuzz arm-softmmu/fuzz aarch64-softmmu/fuzz
    cp i386-softmmu/qemu-fuzz-i386 .
    cp arm-softmmu/qemu-fuzz-arm .
    cp aarch64-softmmu/qemu-fuzz-aarch64 .
    cd $OLDPWD
fi
