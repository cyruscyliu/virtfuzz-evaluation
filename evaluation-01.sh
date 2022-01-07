#!/bin/bash -x

TARGET=$1
export UBSAN_OPTIONS=symbolize=1:halt_on_error=0:print_stacktrace=1
QEMU_BIN=$PWD/../qemu/build-coverage-5/qemu-fuzz-i386
for ROUND in $(seq 0 9); do
    LLVM_PROFILE_FILE=profile-virtfuzz-$TARGET-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-$TARGET -max_total_time=86400 >virtfuzz-$TARGET-$ROUND.log 2>&1 &
    sleep 1
done
