#!/bin/bash -x

FUZZER=$1 # videzzo|qemufuzzer
VMM=$2 # qemu|vbox
TARGET=$3 # uhci|ohci|ehci|xhci
VARIANT=$4 # arp, ar, rp, ap, a, r, p
RUNS=$5
TIMEOUT=$6

usage="Usage $0 videzzo|qemufuzzer|vshuttle qemu|vbox uhci|ohci|ehci|xhci arp|ar|rp|ap|a|r|p|none [[RUNS] [TIMEOUT]]"

if [ -z ${FUZZER} ] || [ -z ${VMM} ] || [ -z ${TARGET} ] || [ -z ${VARIANT} ]; then
    echo ${usage}
    exit 1
fi

if [ -z ${RUNS} ]; then
    RUNS=10
fi
RUNS=$((${RUNS} - 1))

if [ -z ${TIMEOUT} ]; then
    TIMEOUT=86400
fi

export UBSAN_OPTIONS=symbolize=1:halt_on_error=0:print_stacktrace=1

if [ ${FUZZER} == 'videzzo' ]; then
    if [ ${VMM} == 'qemu' ]; then
        BIN=$PWD/../qemu-videzzo/out-cov/qemu-videzzo-i386
    elif [ ${VMM} == 'vbox' ]; then
        BIN=$PWD/../vbox/out-cov/VBoxViDeZZo
    else
        echo ${usage}
        exit 1
    fi
elif [ ${FUZZER} == 'qemufuzzer' ]; then
    if [ ${VMM} == 'qemu' ]; then
        BIN=$PWD/../qemu-qemufuzzer/out-cov/qemu-fuzz-i386
    else
        echo ${usage}
        exit 1
    fi
elif [ ${FUZZER} == 'vshuttle' ]; then
    if [ ${VMM} == 'qemu' ]; then
        BIN=$PWD/02-fuzz-non-local.sh
    else
        echo ${usage}
        exit 1
    fi
fi

if [ ${VARIANT} == 'arp' ]; then
    FLAGS=
elif [ ${VARIANT} == 'ar' ]; then
    FLAGS="export VIDEZZO_FORK=1"
elif [ ${VARIANT} == 'rp' ]; then
    FLAGS="export VIDEZZO_DISABLE_INTRA_MESSAGE_ANNOTATION=1"
elif [ ${VARIANT} == 'ap' ]; then
    FLAGS="export VIDEZZO_DISABLE_INTER_MESSAGE_MUTATORS=1"
elif [ ${VARIANT} == 'a' ]; then
    FLAGS="export VIDEZZO_DISABLE_INTER_MESSAGE_MUTATORS=1 export VIDEZZO_FORK=1"
elif [ ${VARIANT} == 'r' ]; then
    FLAGS="export VIDEZZO_DISABLE_INTRA_MESSAGE_ANNOTATION=1 export VIDEZZO_FORK=1"
elif [ ${VARIANT} == 'p' ]; then
    FLAGS="export VIDEZZO_DISABLE_INTRA_MESSAGE_ANNOTATION=1 export VIDEZZO_DISABLE_INTER_MESSAGE_MUTATORS=1"
elif [ ${VARIANT} == 'none' ]; then
    FLAGS="export VIDEZZO_DISABLE_INTRA_MESSAGE_ANNOTATION=1 export VIDEZZO_DISABLE_INTER_MESSAGE_MUTATORS=1 export VIDEZZO_FORK=1"
else
    echo ${usage}
    exit 1
fi

SIG=$FUZZER-$VMM-$TARGET-$VARIANT

export UBSAN_OPTIONS=symbolize=1:halt_on_error=0:print_stacktrace=1

for ROUND in $(seq 0 ${RUNS}); do
    if [ ${FUZZER} == 'videzzo' ]; then
        ${FLAGS}; \
        LLVM_PROFILE_FILE=profile-$SIG-$ROUND \
        cpulimit -l 100 -- $BIN --fuzz-target=videzzo-fuzz-$TARGET -max_total_time=${TIMEOUT} >$SIG-$ROUND.log 2>&1
    elif [ ${FUZZER} == 'qemufuzzer' ]; then
        LLVM_PROFILE_FILE=profile-$SIG-$ROUND \
        cpulimit -l 100 -- $BIN --fuzz-target=generic-fuzz-$TARGET -max_total_time=${TIMEOUT} >$SIG-$ROUND.log 2>&1
    elif [ ${FUZZER} == 'vshuttle' ]; then
        echo core >/proc/sys/kernel/core_pattern
        cd /sys/devices/system/cpu && echo performance | tee cpu*/cpufreq/scaling_governor && cd -
        pushd ../v-shuttle/V-Shuttle-S/ && pushd afl-seedpool
        make
        make install
        popd && popd
        LLVM_PROFILE_FILE=profile-$SIG-$ROUND \
        timeout -s KILL $TIMEOUT cpulimit -l 100 -- bash -x $BIN $TARGET $ROUND               >$SIG-$ROUND.log 2>&1
    else
        echo ${usage}
        exit 1
    fi
    sleep 1
done
