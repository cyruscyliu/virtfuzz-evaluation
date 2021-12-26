#!/bin/bash
TARGET=$1
NUMBER=$2
rm -rf $1-in $1-out $1-seed
mkdir $1-in $1-out $1-seed
for (( id=0; id<=$NUMBER; id++ )); do
    mkdir $1-in/$id
    dd if=/dev/zero of=$1-in/$id/seed bs=1 count=4086
done
