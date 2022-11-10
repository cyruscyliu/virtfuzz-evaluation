#!/bin/bash -x

FUZZER=$1 # videzzo|qemufuzzer
VMM=$2    # qemu

if [ -z $FUZZER ] | [ -z $VMM ]; then
    echo "Usage: $0 FUZZER VMM"
    exit 1
fi

if [ $FUZZER == 'videzzo' ]; then
    if [ $VMM == 'qemu' ]; then
        mkdir -p ../qemu-videzzo/out-san
        pushd ../qemu-videzzo/out-san
        CC=clang CXX=clang++ ../configure \
            --disable-werror --enable-videzzo --enable-sanitizers --enable-debug \
            --target-list="i386-softmmu"
        make CONFIG_FUZZ=y CFLAGS="-fsanitize=fuzzer" -j$(nproc) \
            i386-softmmu/videzzo
        cp i386-softmmu/qemu-videzzo-i386 .
        popd
    else
        echo "Usage: $0 FUZZER VMM"
    fi
elif [ $FUZZER == 'qemufuzzer' ]; then
    mkdir -p ../qemu-qemufuzzer/out-san
    pushd ../qemu-qemufuzzer/out-san
    CC=clang CXX=clang++ ../configure \
        --disable-werror --enable-fuzzing --enable-sanitizers --enable-debug \
        --target-list="i386-softmmu"
    make CONFIG_FUZZ=y CFLAGS="-fsanitize=fuzzer" -j$(nproc) \
        i386-softmmu/fuzz
    cp i386-softmmu/qemu-fuzz-i386 .
    popd
else
    echo "[-] Usage: $0 FUZZER VMM"
fi
