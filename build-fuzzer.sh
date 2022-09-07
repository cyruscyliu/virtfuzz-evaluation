#!/bin/bash -x

# we don't care about qemu 5 or 6 any more
# in evaluation, we only care videzzo(qemu/vbox), qemufuzzer, vshuttle, nyx
FUZZER=$1 # videzzo|qemufuzzer|vshuttle|nyx
VMM=$2    # qemu|vbox

if [ -z $FUZZER ] | [ -z $VMM ]; then
    echo "Usage: $0 FUZZER VMM"
    exit 1
fi

function build_vshuttle_qemu() {
    target=$1 # ohci/ehci/uhci

    # compile afl-seedpool
    pushd afl-seedpool
    make
    make install
    popd

    # prepare QEMU
    QEMU_DIR=qemu-5.1.0-$target
    if [ ! -d $QEMU_DIR ]; then
        # assume we are in v-shuttle/V-Shuttle-S
        cp -r ../../qemu-vshuttle $QEMU_DIR

        # copy files
        cp ./fuzz-seedpool.h $QEMU_DIR/include
        cp ./hook-write.h $QEMU_DIR/include
        cp ./03-clangcovdump.h $QEMU_DIR/include/clangcovdump.h
        patch $QEMU_DIR/softmmu/memory.c ./QEMU-patch/memory.patch

        # patch QEMU
        if [ $target == 'uhci'  ]; then
            patch $QEMU_DIR/hw/usb/hcd-uhci.c ./QEMU-patch/hcd-uhci.patch
        elif [ $target == 'ohci'  ]; then
            patch $QEMU_DIR/hw/usb/hcd-ohci.c ./QEMU-patch/hcd-ohci.patch
        elif [ $target == 'ehci'  ]; then
            patch $QEMU_DIR/hw/usb/hcd-ehci.c ./QEMU-patch/hcd-ehci.patch
        fi
    fi

    # compile QEMU
    pushd $QEMU_DIR
    CC=afl-clang CXX=afl-clang++ ./configure --disable-werror --disable-sanitizers --target-list="x86_64-softmmu"
    make CFLAGS="-DCLANG_COV_DUMP -DVIDEZZO_LESS_CRASHES -fprofile-instr-generate -fcoverage-mapping" -j$(nproc) x86_64-softmmu/all
}

if [ $FUZZER == 'videzzo' ]; then
    if [ $VMM == 'qemu' ]; then
        mkdir -p ../qemu-videzzo/out-cov
        pushd ../qemu-videzzo/out-cov
        CC=clang CXX=clang++ ../configure \
            --disable-werror --enable-videzzo --disable-sanitizers \
            --target-list="i386-softmmu x86_64-softmmu arm-softmmu aarch64-softmmu"
        make CONFIG_FUZZ=y CFLAGS="-DCLANG_COV_DUMP -DVIDEZZO_LESS_CRASHES -fsanitize=fuzzer \
            -fprofile-instr-generate -fcoverage-mapping" -j$(nproc) \
            i386-softmmu/videzzo x86_64-softmmu/videzzo arm-softmmu/videzzo aarch64-softmmu/videzzo
        cp i386-softmmu/qemu-videzzo-i386 .
        cp x86_64-softmmu/qemu-videzzo-x86_64 .
        cp arm-softmmu/qemu-videzzo-arm .
        cp aarch64-softmmu/qemu-videzzo-aarch64 .
        popd
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
        echo "Usage: $0 FUZZER VMM"
    fi
elif [ $FUZZER == 'qemufuzzer' ]; then
    mkdir -p ../qemu-qemufuzzer/out-cov
    pushd ../qemu-qemufuzzer/out-cov
    CC=clang CXX=clang++ ../configure \
        --disable-werror --enable-fuzzing --disable-sanitizers \
        --target-list="i386-softmmu arm-softmmu"
    make CONFIG_FUZZ=y CFLAGS="-DCLANG_COV_DUMP -DVIDEZZO_LESS_CRASHES -fsanitize=fuzzer \
        -fprofile-instr-generate -fcoverage-mapping" -j$(nproc) \
        i386-softmmu/fuzz arm-softmmu/fuzz
    cp i386-softmmu/qemu-fuzz-i386 .
    cp arm-softmmu/qemu-fuzz-arm .
    popd
elif [ $FUZZER == 'nyx' ]; then
     mkdir -p ../qemu-nyx/out-cov
    pushd ../qemu-nyx/out-cov
    CC=clang CXX=clang++ ../configure \
        --disable-werror --disable-sanitizers \
        --target-list="x86_64-softmmu"
    make CFLAGS="-DVIDEZZO_LESS_CRASHES \
        -fprofile-instr-generate -fcoverage-mapping" -j$(nproc) \
        x86_64-softmmu/all
    cp x86_64-softmmu/qemu-system-x86_64 .
    popd
elif [ $FUZZER == 'vshuttle' ]; then
    pushd ../v-shuttle/V-Shuttle-S
    build_vshuttle_qemu ohci
    popd
else
    echo "[-] Usage: $0 FUZZER VMM"
fi
