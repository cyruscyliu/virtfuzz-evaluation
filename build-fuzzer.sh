#!/bin/bash

# we don't care about qemu 5 or 6 any more
# in evaluation, we only care videzzo(qemu/vbox), qemufuzzer, vshuttle, nyx
FUZZER=$1 # videzzo|qemufuzzer|vshuttle|nyx
VMM=$2    # qemu|vbox

if [ -z $FUZZER ] | [ -z $VMM ]; then
    echo "[-] Usage: $0 FUZZER VMM"
    exit 1
fi

if [ $FUZZER == 'videzzo' ]; then
    if [ $VMM == 'qemu' ]; then
        mkdir -p ../qemu-videzzo/out-cov
        pushd ../qemu-videzzo/out-cov
        CC=clang CXX=clang++ ../configure \
            --disable-werror --enable-videzzo --disable-sanitizers \
            --target-list="i386-softmmu x86_64-softmmu arm-softmmu aarch64-softmmu"
        make CONFIG_FUZZ=y CFLAGS="-DCLANG_COV_DUMP -DVIRTFUZZ_LESS_CRASHES -fsanitize=fuzzer \
            -fprofile-instr-generate -fcoverage-mapping" CLANG_COV_DUMP=1 -j$(nproc) \
            i386-softmmu/videzzo x86_64-softmmu/videzzo arm-softmmu/videzzo aarch64-softmmu/videzzo
        cp i386-softmmu/qemu-videzzo-i386 .
        cp x86_64-softmmu/qemu-videzzo-x86_64 .
        cp arm-softmmu/qemu-videzzo-arm .
        cp aarch64-softmmu/qemu-videzzo-aarch64 .
        pushd $OLDPWD
    elif [ $VMM == 'vbox' ]; then
	# modified from ../videzzo/videzzo_vbox/0005-compile-vbox-cov.sh
	pushd ../vbox
	mkdir -p out-cov
	./configure --disable-hardening --disable-docs \
	    --disable-java --disable-qt -d --out-path=out-cov
	pushd out-cov && source ./env.sh && popd
	COVERAGE="-fprofile-instr-generate -fcoverage-mapping"
	ANNOTATION="-videzzo-instrumentation=$PWD/videzzo_vbox_types.yaml -flegacy-pass-manager"
	EXPORT_SYMBOL_LIST="$PWD/export_symbol_list.txt"
	EXPORT_SYMBOL="-Wl,--export-dynamic -Wl,--export-dynamic-symbol-list=$EXPORT_SYMBOL_LIST"
	kmk VBOX_FUZZ=1 KBUILD_TYPE=debug VBOX_GCC_TOOL=CLANG \
	    PATH_OUT_BASE=$PWD/out-cov \
	    TOOL_CLANG_CFLAGS="-fsanitize=fuzzer-no-link -DCLANG_COV_DUMP -DRT_NO_STRICT ${COVERAGE} ${ANNOTATION} -fPIE" \
	    TOOL_CLANG_CXXFLAGS="-fsanitize=fuzzer-no-link -DCLANG_COV_DUMP -DRT_NO_STRICT ${COVERAGE} ${ANNOTATION} -fPIE" \
	    TOOL_CLANG_LDFLAGS="-fsanitize=fuzzer-no-link ${COVERAGE} ${EXPORT_SYMBOL}" \
	    VBOX_FUZZ_LDFLAGS="-fsanitize=fuzzer ${COVERAGE}"

	# 1. compile kernel drivers
	pushd out-cov/linux.amd64/debug/bin/
	pushd src
	sudo make && sudo make install
	# 2. install kernel drivers
	sudo rmmod vboxnetadp vboxnetflt vboxdrv
	sudo insmod vboxdrv.ko
	sudo insmod vboxnetflt.ko
	sudo insmod vboxnetadp.ko
	popd && popd && popd
    else
        echo "[-] Usage: $0 FUZZER VMM"
    fi
elif [ $FUZZER == 'qemufuzzer' ]; then
    CLANG_COV_DUMP=1 CC=clang-10 CXX=clang++-10 ../configure \
        --disable-werror --disable-sanitizers \
        --target-list="i386-softmmu arm-softmmu aarch64-softmmu"
elif [ $FUZZER == 'vshuttle' ]; then
    echo "[-] Not supported"
elif [ $FUZZER == 'nyx' ]; then
    echo "[-] Not supported"
else
    echo "[-] Usage: $0 FUZZER VMM"
fi
