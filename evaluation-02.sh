#!/bin/bash -x

export UBSAN_OPTIONS=symbolize=1:halt_on_error=1:print_stacktrace=1
QEMU_BIN=$PWD/../qemu/build-coverage-5/qemu-fuzz-i386
ROUND=0
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-m-ehci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-m-ohci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-m-uhci-$ROUND.log 2>&1 &
ROUND=1
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-m-ehci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-m-ohci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-m-uhci-$ROUND.log 2>&1 &
ROUND=2
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-m-ehci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-m-ohci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-m-uhci-$ROUND.log 2>&1 &
ROUND=3
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-m-ehci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-m-ohci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-m-uhci-$ROUND.log 2>&1 &
ROUND=4
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-m-ehci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-m-ohci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-m-uhci-$ROUND.log 2>&1 &
ROUND=5
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-m-ehci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-m-ohci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-m-uhci-$ROUND.log 2>&1 &
ROUND=6
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-m-ehci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-m-ohci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-m-uhci-$ROUND.log 2>&1 &
ROUND=7
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-m-ehci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-m-ohci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-m-uhci-$ROUND.log 2>&1 &
ROUND=8
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-m-ehci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-m-ohci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-m-uhci-$ROUND.log 2>&1 &
ROUND=9
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-m-ehci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-m-ohci-$ROUND.log 2>&1 &
DISABLE_STRUCTURAL_BUFFER=1 LLVM_PROFILE_FILE=profile-virtfuzz-m-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-m-uhci-$ROUND.log 2>&1 &
