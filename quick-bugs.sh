#!/bin/bash

target=$1
# stage 1
pushd ../qemu/build-san-5
make CONFIG_FUZZ=y CFLAGS="-fsanitize=fuzzer -g" -j$(nproc) \
    i386-softmmu/fuzz arm-softmmu/fuzz aarch64-softmmu/fuzz
cp i386-softmmu/qemu-fuzz-i386 .
cp arm-softmmu/qemu-fuzz-arm .
cp aarch64-softmmu/qemu-fuzz-aarch64 .
# stage 2
./qemu-fuzz-i386 --fuzz-target=videzzo-fuzz-${target} -max_total_time=600 -detect_leaks=0
# stage 3
popd
