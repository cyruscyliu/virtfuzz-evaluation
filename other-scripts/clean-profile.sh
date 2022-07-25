#!/bin/bash
# this script deletes coverage raw data that is not used any more.

dir=$1
prefix=$2

mkdir /tmp/$dir
for ROUND in $(seq 0 9); do
    mv $(ls $prefix$ROUND-* | tail -n 1) /tmp/$dir
    rm $prefix$ROUND-*
done
mv /tmp/$dir/* $dir/
