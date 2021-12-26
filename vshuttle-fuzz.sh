TARGET=$1
if [ $TARGET == 'ohci' ]; then
    AFL_Fuzzing=1 \
    LLVM_PROFILE_FILE=profile-vshuttle-$TARGET-0 cpulimit -l 100 -- \
    afl-fuzz -t 5000 -i $TARGET-in -o $TARGET-out -m none -f $TARGET-seed -- \
    ../qemu-5.1.0/build-coverage-vshuttle-5/qemu-system-i386-vshuttle-$TARGET \
    -device pci-ohci,id=ohci -device usb-tablet,bus=ohci.0,port=1,id=usbdev1 \
    -display none
elif [ $TARGET == 'ehci' ]; then
    AFL_Fuzzing=1 \
    LLVM_PROFILE_FILE=profile-vshuttle2-$TARGET-0 cpulimit -l 100 -- \
    afl-fuzz -t 5000 -i $TARGET-in2 -o $TARGET-out -m none -f $TARGET-seed -- \
    ../qemu-5.1.0/build-coverage-vshuttle-5/qemu-system-i386-vshuttle-$TARGET \
    -display none -m 512M -machine q35 -nodefaults \
    -device ich9-usb-ehci1,bus=pcie.0,addr=1d.7,multifunction=on,id=ich9-ehci-1 \
    -device ich9-usb-uhci1,bus=pcie.0,addr=1d.0,multifunction=on,masterbus=ich9-ehci-1.0,firstport=0 \
    -device ich9-usb-uhci2,bus=pcie.0,addr=1d.1,multifunction=on,masterbus=ich9-ehci-1.0,firstport=2 \
    -device ich9-usb-uhci3,bus=pcie.0,addr=1d.2,multifunction=on,masterbus=ich9-ehci-1.0,firstport=4 \
    -drive if=none,id=usbcdrom,media=cdrom -device usb-tablet,bus=ich9-ehci-1.0,port=1,usb_version=1 \
    -device usb-storage,bus=ich9-ehci-1.0,port=2,drive=usbcdrom
fi
