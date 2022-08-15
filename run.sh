docker run --rm \
    -e LC_CTYPE=C.UTF-8 \
    -v $PWD/evaluation:/root/evaluation \
    -v $PWD/virtfuzz-llvm-project:/root/llvm-project \
    -v $PWD/virtfuzz-qemu-videzzo:/root/qemu-videzzo \
    -v $PWD/virtfuzz-qemu-qemufuzzer:/root/qemu-qemufuzzer \
    -v $PWD/virtfuzz-qemu-vshuttle:/root/qemu-vshuttle\
    -v $PWD/virtfuzz-vbox:/root/vbox \
    -v $PWD/videzzo:/root/videzzo \
    -v $PWD/v-shuttle:/root/v-shuttle \
    -v /usr/src:/usr/src \
    -v /dev:/dev \
    -v /lib/modules:/lib/modules \
    -e PATH=$PATH:/root/llvm-project/build-custom/bin \
    --privileged \
    -it videzzo-evaluation:latest /bin/bash
