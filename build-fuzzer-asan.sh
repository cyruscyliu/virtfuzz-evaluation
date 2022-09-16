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
            --target-list="i386-softmmu x86_64-softmmu arm-softmmu aarch64-softmmu"
        make CONFIG_FUZZ=y CFLAGS="-DVIDEZZO_LESS_CRASHES -fsanitize=fuzzer" -j$(nproc) \
            i386-softmmu/videzzo x86_64-softmmu/videzzo arm-softmmu/videzzo aarch64-softmmu/videzzo
        cp i386-softmmu/qemu-videzzo-i386 .
        cp x86_64-softmmu/qemu-videzzo-x86_64 .
        cp arm-softmmu/qemu-videzzo-arm .
        cp aarch64-softmmu/qemu-videzzo-aarch64 .
        popd
    else
        echo "Usage: $0 FUZZER VMM"
    fi
elif [ $FUZZER == 'qemufuzzer' ]; then
    mkdir -p ../qemu-qemufuzzer/out-san
    pushd ../qemu-qemufuzzer/out-san
    CC=clang CXX=clang++ ../configure \
        --disable-werror --enable-fuzzing --enable-sanitizers --enable-debug \
        --target-list="i386-softmmu arm-softmmu"
    make CONFIG_FUZZ=y CFLAGS="-DVIDEZZO_LESS_CRASHES -fsanitize=fuzzer" -j$(nproc) \
        i386-softmmu/fuzz arm-softmmu/fuzz
    cp i386-softmmu/qemu-fuzz-i386 .
    cp arm-softmmu/qemu-fuzz-arm .
    popd
else
    echo "[-] Usage: $0 FUZZER VMM"
fi
