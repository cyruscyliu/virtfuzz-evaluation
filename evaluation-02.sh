#!/bin/bash -x

VMM=$1 # qemu|vbox
TARGET=$2 # uhci|ohci|ehci|xhci
export UBSAN_OPTIONS=symbolize=1:halt_on_error=0:print_stacktrace=1
if [ ${VMM} == 'qemu' ]; then
    BIN=$PWD/../qemu/out-cov/qemu-fuzz-i386
elif [ ${VMM} == 'vbox' ]; then
    BIN=$PWD/../vbox/out-cov/VBoxViDeZZo
else
    echo 'Usage $0 qemu|vbox uhci|ohci|ehci|xhci'
    exit 1
fi

for ROUND in $(seq 0 9); do
    VIDEZZO_DISABLE_INTRA_MESSAGE_ANNOTATION=1 \
    LLVM_PROFILE_FILE=profile-virtfuzz-$VMM-$TARGET-$ROUND cpulimit -l 100 -- $BIN --fuzz-target=videzzo-fuzz-$TARGET -max_total_time=86400 >virtfuzz-$VMM-$TARGET-$ROUND.log 2>&1 &
    sleep 1
done
