docker run --rm \
    -e LC_CTYPE=C.UTF-8 \
    -v $PWD/evaluation:/root/evaluation \
    -v $PWD/qemu:/root/qemu \
    -v $PWD/llvm-project:/root/llvm-project \
    -e PATH=$PATH:/root/llvm-project/build-custom/bin \
    --privileged \
    -it qemu-spa:latest /bin/bash
