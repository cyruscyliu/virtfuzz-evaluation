#!/bin/bash

echo $0 profraw binary source tag

profraw=$1
binary=$2
src=$3
tag=$4

llvm-profdata merge -output=clangcovdump.profraw $profraw
llvm-cov show $binary -instr-profile=clangcovdump.profraw -format=html -output-dir=/root/reports/$tag $src
echo "please check /root/reports/$tag"
