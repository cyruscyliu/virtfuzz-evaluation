#!/bin/bash

arch=$1
target=$2
profile=$3
llvm-profdata merge -output=$profile.profraw $profile
llvm-cov show ../qemu/build-coverage-5/qemu-fuzz-${arch} -instr-profile=$profile.profraw -format=html -output-dir=/root/reports/${target} ../qemu
echo "please check /root/reports/${target}"
