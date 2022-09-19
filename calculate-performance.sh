#!/bin/bash -x

FUZZER=$1 # videzzo|qemufuzzer
VMM=$2 # qemu|vbox
TARGET=$3 # uhci|ohci|ehci|xhci
VARIANT=$4 # arp, ar, rp, ap, a, r, p

usage='Usage: $0 videzzo|videzzo++|qemufuzzer qemu|vbox uhci|ohci|ehci|xhci arp|ar|rp|ap|a|r|p|none'

if [ -z $FUZZER ] || [ -z $VMM ] || [ -z $TARGET ] || [ -z $VARIANT ]; then
    echo ${usage}
    exit 1
fi

SIG=$FUZZER-$VMM-$TARGET-$VARIANT

# step 1: copy all files into a directory
LOG_DIR=$SIG-logs
mkdir $LOG_DIR
mv $SIG-*.log $LOG_DIR

# step 2: calculate performance
python3 overhead24cal.py $LOG_DIR/*.log > $SIG.overhead
