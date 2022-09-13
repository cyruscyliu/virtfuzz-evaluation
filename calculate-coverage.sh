#!/bin/bash -x

FUZZER=$1 # videzzo|qemufuzzer|nyx
VMM=$2 # qemu|vbox
TARGET=$3 # uhci|ohci|ehci|xhci|qemu_xhci
VARIANT=$4 # arp, ar, rp, ap, a, r, p

usage='Usage: $0 videzzo|qemufuzzer|vshuttle|nyx qemu|vbox uhci|ohci|ehci|xhci|qemu_xhci arp|ar|rp|ap|a|r|p|none'

if [ -z $FUZZER ] || [ -z $VMM ] || [ -z $TARGET ] || [ -z $VARIANT ]; then
    echo ${usage}
    exit 1
fi

SIG=$FUZZER-$VMM-$TARGET-$VARIANT

# step 1: copy all files into a directory
PROFILE_DIR=$SIG-profiles
if [ $FUZZER != 'nyx' ]; then
    mkdir $PROFILE_DIR
    mv profile-$SIG-* $PROFILE_DIR
fi

# step 2: generate coverage reports
if [ $FUZZER == 'videzzo' ]; then
    BIN=../qemu-videzzo/out-cov/qemu-videzzo-i386
elif [ $FUZZER == 'qemufuzzer' ]; then
    BIN=../qemu-qemufuzzer/out-cov/qemu-fuzz-i386
elif [ $FUZZER == 'nyx' ]; then
    BIN=../Nyx/Targets/qemu/VM/qemu-nyx/out-cov/qemu-system-x86_64
elif [ $FUZZER == 'vshuttle' ]; then
    BIN=../v-shuttle/V-Shuttle-S/qemu-5.1.0-$TARGET/x86_64-softmmu/qemu-system-x86_64
else
    echo ${usage}
    exit 1
fi

if [ $VMM == 'qemu' ] && [ $TARGET == 'ehci' ]; then
    FILENAME='hcd-ehci.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'ohci' ]; then
    FILENAME='hcd-ohci.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'xhci' ]; then
    FILENAME='hcd-xhci.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'qemu_xhci' ]; then
    FILENAME='hcd-xhci.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_ac97' ]; then
    FILENAME='ac97.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_cs4231a' ]; then
    FILENAME='cs4231a.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_es1370' ]; then
    FILENAME='es1370.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_intelhda' ]; then
    FILENAME='intel-hda.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_sb16' ]; then
    FILENAME='sb16.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_floppy' ]; then
    FILENAME='fdc.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_sdhci' ]; then
    FILENAME='sdhci.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_e1000' ]; then
    FILENAME='e1000.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_ee100pro' ]; then
    FILENAME='eepro100.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_ne2000' ]; then
    FILENAME='ne2000.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_pcnet' ]; then
    FILENAME='pcnet.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_rtl8139' ]; then
    FILENAME='rtl8139.c'
elif [ $VMM == 'qemu' ] && [ $TARGET == 'legacy_xhci' ]; then
    FILENAME='hcd-xhci.c'
else
    echo ${usage}
    exit 1
fi

bash -x clangcovreport.sh $BIN $SIG-profiles/ $SIG-reports/
bash -x covtablegen-new.sh $FILENAME $SIG-reports/cov-profile-$SIG- > $SIG.csv
