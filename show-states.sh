#!/bin/bash -x

FUZZER=$1 # videzzo|videzzo++|nyx
VMM=$2 # qemu
TARGET=$3 # xhci
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
gcc -g -o statecovshow statecovshow.c
parallel_scripts=/tmp/show-states.$SIG.sh
rm $parallel_scripts
for i in $(seq 0 9); do
    head_file=`ls $DATA_DIR/sprofile-$SIG-$i-* | head -1`
    head_file_base=$(basename $head_file)
    timestamp_base=`python3 get-timestamp.py $head_file_base`
    for file in `ls $DATA_DIR/sprofile-$SIG-$i-*`; do
        timestamp=`python3 get-timestamp.py $(basename $file)`
        time=$(expr $timestamp - $timestamp_base)
        dst_file=$OUTPUT_DIR/$(basename $file)
        echo "./statecovshow ${file} ${time} > ${dst_file}.dot && dot -Tpng -Gsize=23,23\! ${dst_file}.dot > ${dst_file}.png" >> $parallel_scripts
    done
done

parallel --bar -j$(nproc) < $parallel_scripts

# ffmpeg -y -framerate 5 -start_number 4036 -i videzzo-qemu-xhci-arp-states.output/sprofile-videzzo-qemu-xhci-arp-1-166367%04d.png -c:v libx264 -r 30 out.mp4
