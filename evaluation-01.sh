#!/bin/bash -x

export UBSAN_OPTIONS=symbolize=1:halt_on_error=0:print_stacktrace=1
QEMU_BIN=$PWD/../qemu/build-coverage-5/qemu-fuzz-i386
ROUND=0
LLVM_PROFILE_FILE=profile-virtfuzz-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-ehci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-ohci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-uhci-$ROUND.log 2>&1 &
ROUND=1
LLVM_PROFILE_FILE=profile-virtfuzz-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-ehci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-ohci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-uhci-$ROUND.log 2>&1 &
ROUND=2
LLVM_PROFILE_FILE=profile-virtfuzz-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-ehci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-ohci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-uhci-$ROUND.log 2>&1 &
ROUND=3
LLVM_PROFILE_FILE=profile-virtfuzz-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-ehci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-ohci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-uhci-$ROUND.log 2>&1 &
ROUND=4
LLVM_PROFILE_FILE=profile-virtfuzz-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-ehci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-ohci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-uhci-$ROUND.log 2>&1 &
ROUND=5
LLVM_PROFILE_FILE=profile-virtfuzz-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-ehci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-ohci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-uhci-$ROUND.log 2>&1 &
ROUND=6
LLVM_PROFILE_FILE=profile-virtfuzz-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-ehci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-ohci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-uhci-$ROUND.log 2>&1 &
ROUND=7
LLVM_PROFILE_FILE=profile-virtfuzz-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-ehci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-ohci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-uhci-$ROUND.log 2>&1 &
ROUND=8
LLVM_PROFILE_FILE=profile-virtfuzz-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-ehci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-ohci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-uhci-$ROUND.log 2>&1 &
ROUND=9
LLVM_PROFILE_FILE=profile-virtfuzz-ehci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ehci -max_total_time=86400 >virtfuzz-ehci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-ohci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-ohci -max_total_time=86400 >virtfuzz-ohci-$ROUND.log 2>&1 &
LLVM_PROFILE_FILE=profile-virtfuzz-uhci-$ROUND cpulimit -l 100 -- $QEMU_BIN --fuzz-target=stateful-fuzz-uhci -max_total_time=86400 >virtfuzz-uhci-$ROUND.log 2>&1 &
