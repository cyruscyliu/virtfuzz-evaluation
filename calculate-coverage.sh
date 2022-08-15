#!/bin/bash -x

FUZZER=$1 # videzzo|qemufuzzer
VMM=$2 # qemu|vbox
TARGET=$3 # uhci|ohci|ehci|xhci
VARIANT=$4 # arp, ar, rp, ap, a, r, p

usage='Usage: $0 videzzo|qemufuzzer qemu|vbox uhci|ohci|ehci|xhci arp|ar|rp|ap|a|r|p'

if [ -z $FUZZER ] || [ -z $VMM ] || [ -z $TARGET ] || [ -z $VARIANT ]; then
    echo ${usage}
    exit 1
fi

SIG=$FUZZER-$VMM-$TARGET-$VARIANT

# step 1: copy all files into a directory
PROFILE_DIR=$SIG-profiles
mkdir $PROFILE_DIR
mv profile-$SIG-* $PROFILE_DIR

# step 2: generate coverage reports
if [ $FUZZER == 'videzzo' ]; then
    BIN=../qemu-videzzo/out-cov/qemu-videzzo-i386
else
    echo ${usage}
    exit 1
fi

if [ $VMM == 'qemu' ] && [ $TARGET == 'ehci' ]; then
    FILENAME='hcd-ehci.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'ohci' ]; then
    FILENAME='hcd-ohci.c'
else
    echo ${usage}
    exit 1
fi

bash -x clangcovreport.sh $BIN $SIG-profiles/ $SIG-reports/
bash -x covtablegen-new.sh $FILENAME $SIG-reports/cov-profile-$SIG- > $SIG.csv
