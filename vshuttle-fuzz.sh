TARGET=$1
echo core > /proc/sys/kernel/core_pattern
pushd /sys/devices/system/cpu && echo performance | tee cpu*/cpufreq/scaling_governor && popd
if [ $TARGET == 'ohci' ]; then
    bash -x vshuttle-setup.sh ohci 4
    AFL_Fuzzing=1 \
    afl-fuzz -t 5000 -i $TARGET-in -o $TARGET-out -m none -f $TARGET-seed -- \
    ../vshuttle-qemu/build-coverage-5/x86_64-softmmu/qemu-system-x86_64 \
    -device pci-ohci,id=ohci -device usb-tablet,bus=ohci.0,port=1,id=usbdev1 \
    -display none
elif [ $TARGET == 'ehci' ]; then
    bash -x vshuttle-setup.sh ehci 12
    AFL_Fuzzing=1 \
    afl-fuzz -t 5000 -i $TARGET-in2 -o $TARGET-out -m none -f $TARGET-seed -- \
    ../vshuttle-qemu/build-coverage-5/qemu-system-x86_64-$TARGET \
    -display none -m 512M -machine q35 -nodefaults \
    -device ich9-usb-ehci1,bus=pcie.0,addr=1d.7,multifunction=on,id=ich9-ehci-1 \
    -device ich9-usb-uhci1,bus=pcie.0,addr=1d.0,multifunction=on,masterbus=ich9-ehci-1.0,firstport=0 \
    -device ich9-usb-uhci2,bus=pcie.0,addr=1d.1,multifunction=on,masterbus=ich9-ehci-1.0,firstport=2 \
    -device ich9-usb-uhci3,bus=pcie.0,addr=1d.2,multifunction=on,masterbus=ich9-ehci-1.0,firstport=4 \
    -drive if=none,id=usbcdrom,media=cdrom -device usb-tablet,bus=ich9-ehci-1.0,port=1,usb_version=1 \
    -device usb-storage,bus=ich9-ehci-1.0,port=2,drive=usbcdrom
elif [ $TARGET == 'uhci' ]; then
    bash -x vshuttle-setup.sh uhci 6
    AFL_Fuzzing=1 \
    afl-fuzz -t 5000 -i $TARGET-in2 -o $TARGET-out -m none -f $TARGET-seed -- \
    ../vshuttle-qemu/build-coverage-5/qemu-system-x86_64-$TARGET \
    -display none -machine q35 -nodefaults \
    -device piix3-usb-uhci,id=uhci,addr=1d.0 \
    -drive id=drive0,if=none,file=null-co://,file.read-zeroes=on,format=raw \
    -device usb-tablet,bus=uhci.0,port=1
fi
