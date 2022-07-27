#!/bin/bash -x

VMM=$1 # qemu|vbox
TARGET=$2 # uhci|ohci|ehci|xhci
VARIANT=$3 # arp, ar, rp, ap, a, r, p
RUNS=$4
TIMEOUT=$5

if [ -z ${VMM} ] || [ -z ${TARGET} ] || [ -z ${VARIANT} ]; then
    echo 'Usage $0 qemu|vbox uhci|ohci|ehci|xhci arp|ar|rp|ap|a|r|p'
    exit 1
fi

if [ -z ${RUNS} ]; then
    RUNS=10
fi
RUNS=$((${RUN} - 1))

if [ -z ${TIMEOUT} ]; then
    TIMEOUT=86400
fi

export UBSAN_OPTIONS=symbolize=1:halt_on_error=0:print_stacktrace=1

if [ ${VMM} == 'qemu' ]; then
    BIN=$PWD/../qemu/out-cov/qemu-fuzz-i386
elif [ ${VMM} == 'vbox' ]; then
    BIN=$PWD/../vbox/out-cov/VBoxViDeZZo
    echo "Current, this script does not support VBox"
    exit 1
else
    echo 'Usage $0 qemu|vbox uhci|ohci|ehci|xhci arp|ar|rp|ap|a|r|p'
    exit 1
fi

if [ ${VARIANT} == 'arp ']; then
    FLAGS=
elif [ ${VARIANT} == 'ar' ]; then
    FLAGS="VIDEZZO_FORK=1"
elif [ ${VARIANT} == 'rp' ]; then
    FLAGS="VIDEZZO_DISABLE_INTRA_MESSAGE_ANNOTATION=1"
elif [ ${VARIANT} == 'ap' ]; then
    FLAGS="VIDEZZO_DISABLE_INTER_MESSAGE_MUTATORS=1"
elif [ ${VARIANT} == 'a' ]; then
    FLAGS="VIDEZZO_DISABLE_INTER_MESSAGE_MUTATORS=1 VIDEZZO_FORK=1"
elif [ ${VARIANT} == 'r' ]; then
    FLAGS="VIDEZZO_DISABLE_INTRA_MESSAGE_ANNOTATION=1 VIDEZZO_FORK=1"
elif [ ${VARIANT} == 'p' ]; then
    FLAGS="VIDEZZO_DISABLE_INTRA_MESSAGE_ANNOTATION=1 VIDEZZO_DISABLE_INTER_MESSAGE_MUTATORS=1"
else
    echo 'Usage $0 qemu|vbox uhci|ohci|ehci|xhci arp|ar|rp|ap|a|r|p'
    exit 1
fi

for ROUND in $(seq 0 ${RUNS}); do
    ${FLAGS} \
    LLVM_PROFILE_FILE=profile-virtfuzz-$VMM-$TARGET-$ROUND \
    cpulimit -l 100 -- $BIN --fuzz-target=videzzo-fuzz-$TARGET -max_total_time=${TIMEOUT} >virtfuzz-$VMM-$TARGET-$ROUND.log 2>&1 &
    sleep 1
done
