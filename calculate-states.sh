#!/bin/bash -x

FUZZER=$1 # videzzo|videzzo++|nyx
VMM=$2 # qemu
TARGET=$3 # xhci|qemu_xhci
VARIANT=$4 # arp|none

usage='Usage: $0 videzzo|videzzo++|nyx qemu xhci arp|none'

if [ -z $FUZZER ] || [ -z $VMM ] || [ -z $TARGET ] || [ -z $VARIANT ]; then
    echo ${usage}
    exit 1
fi

SIG=$FUZZER-$VMM-$TARGET-$VARIANT

# step 1: copy all files into a directory
DATA_DIR=$SIG-states
mkdir $DATA_DIR
mv sprofile-$SIG-* $DATA_DIR
OUTPUT_DIR=$DATA_DIR.output
mkdir $OUTPUT_DIR

# step 2: output dot file
gcc -g -o statecovcount statecovcount.c
parallel_scripts=/tmp/show-states.$SIG.sh
rm $parallel_scripts
for i in $(seq 0 9); do
    for file in `ls $DATA_DIR/sprofile-$SIG-$i-*`; do
        targetindex=`echo $(basename $file) | awk -F"-" '{print $4$6}'`
        timestamp=`echo $(basename $file) | awk -F"-" '{print $7}'`
        dst_file=$OUTPUT_DIR/$(basename $file)
        echo "./statecovcount ${file} ${targetindex} ${timestamp} 0 > ${dst_file}.states" >> $parallel_scripts
        echo "./statecovcount ${file} ${targetindex} ${timestamp} 1 > ${dst_file}.transitions " >> $parallel_scripts
    done
done

parallel --bar -j$(nproc) < $parallel_scripts

tmp10=/tmp/xxxVirtFuzzxxx.$SIG.states
tmp11=/tmp/xxxVirtFuzzxxx.$SIG.transitions
rm ${tmp10} ${tmp11}
for i in $(seq 0 9); do
    # videzzo-qemu-xhci-arp-states.output/sprofile-videzzo-qemu-xhci-arp-2-1663674226.transitions
    tmp00=/tmp/xxxVirtFuzzxxx.$SIG.$i.states
    tmp01=/tmp/xxxVirtFuzzxxx.$SIG.$i.transitions
    rm ${tmp00} ${tmp01}
    for file in `ls $OUTPUT_DIR/sprofile-$SIG-$i-*.states`; do
        cat $file >> ${tmp00}
    done
    for file in `ls $OUTPUT_DIR/sprofile-$SIG-$i-*.transitions`; do
        cat $file >> ${tmp01}
    done
    cat ${tmp00} | python3 rebase-timestamp.py >> ${tmp10}
    cat ${tmp01} | python3 rebase-timestamp.py >> ${tmp11}
done

cat ${tmp10} | python3 covtablegen2.py > ${SIG}.states
cat ${tmp11} | python3 covtablegen2.py > ${SIG}.transitions
