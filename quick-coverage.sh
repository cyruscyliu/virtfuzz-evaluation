#!/bin/bash

arch=$1
target=$2
# stage 1
pushd ../qemu/build-coverage-5
make CONFIG_FUZZ=y CFLAGS="-DCLANG_COV_DUMP -DVIRTFUZZ_LESS_CRASHES -fsanitize=fuzzer \
    -fprofile-instr-generate -fcoverage-mapping" -j$(nproc) \
    i386-softmmu/fuzz arm-softmmu/fuzz aarch64-softmmu/fuzz
cp i386-softmmu/qemu-fuzz-i386 .
cp arm-softmmu/qemu-fuzz-arm .
cp aarch64-softmmu/qemu-fuzz-aarch64 .
# stage 2
rm -rf clangcovdump.profraw
./qemu-fuzz-${arch} --fuzz-target=videzzo-fuzz-${target} -max_total_time=600
# stage 3
llvm-profdata merge -output=clangcovdump.profraw $(ls clangcovdump.profraw-* | tail -n 1)
llvm-cov show ./qemu-fuzz-${arch} -instr-profile=clangcovdump.profraw -format=html -output-dir=/root/reports/${target} ../
echo "please check /root/reports/${target}"
popd
