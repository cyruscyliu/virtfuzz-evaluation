#!/bin/bash -x
TARGET_DIR=$1
bash -x ./genlist.sh $TARGET_DIR
for target in `ls $TARGET_DIR/qemu-fuzz-*-target-stateful-*`; do
    QEMU_BIN=$target
    TARGET=$(basename $target | sed "s/qemu-fuzz-//g" | sed "s/-target-stateful-fuzz//g")
    for ROUND in $(seq 0 9); do
        echo "UBSAN_OPTIONS=symbolize=1:halt_on_error=0:print_stacktrace=1 LLVM_PROFILE_FILE=profile-virtfuzz-$TARGET-$ROUND $QEMU_BIN -max_total_time=60 >virtfuzz-$TARGET-$ROUND.log 2>&1"
    done
done
