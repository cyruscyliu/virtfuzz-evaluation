#!/bin/bash

TARGET_DIR=$1
TARGET_LIST="i386-softmmu arm-softmmu aarch64-softmmu"
for arch in $(echo $TARGET_LIST | sed "s/-softmmu//g"); do
    targets=$($TARGET_DIR/$arch-softmmu/qemu-fuzz-$arch | awk '$1 ~ /\*/  {print $2}')
    base_copy="$TARGET_DIR/qemu-fuzz-$arch-target-$(echo "$targets" | head -n 1)"

    cp "$TARGET_DIR/$arch-softmmu/qemu-fuzz-$arch" "$base_copy"

    # Run the fuzzer with no arguments, to print the help-string and get the list
    # of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
    # to each available fuzz target (See 05509c8e6d fuzz: select fuzz target using
    # executable name)
    for target in $(echo "$targets" | tail -n +2); do
        # Ignore the generic-fuzz target, as it requires some environment variables
        # to be configured. We have some generic-fuzz-{pc-q35, floppy, ...} targets
        # that are thin wrappers around this target that set the required
        # environment variables according to predefined configs.
        if [ "$target" != "generic-fuzz"  ] && [ "$target" != "stateful-fuzz" ]; then
            ln -f $base_copy \
                "$TARGET_DIR/qemu-fuzz-$arch-target-$target"
        fi
    done
done
