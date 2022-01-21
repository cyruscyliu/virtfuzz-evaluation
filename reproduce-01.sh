#!/bin/bash -x

ARCH=$1
TARGET=$2
QEMU_BIN=$PWD/../qemu/build-san-5/qemu-fuzz-${ARCH}
mkdir $TARGET-logs
for ROUND in $(seq 0 9); do
    mkdir -p /qiliu/videzzo-corpus/$TARGET-$ROUND
    cpulimit -l 100 -- $QEMU_BIN --fuzz-target=videzzo-fuzz-$TARGET -max_total_time=86400 -detect_leaks=0 /qiliu/videzzo-corpus/$TARGET-$ROUND > ./$TARGET-logs/virtfuzz-$TARGET-$ROUND.log 2>&1 &
    sleep 1
done
