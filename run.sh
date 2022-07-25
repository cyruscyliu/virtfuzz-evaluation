docker run --rm \
    -e LC_CTYPE=C.UTF-8 \
    -v $PWD/evaluation:/root/evaluation \
    -v $PWD/llvm-project:/root/llvm-project \
    -e PATH=$PATH:/root/llvm-project/build-custom/bin \
    --privileged \
    -it virtfuzz-evaluation:latest /bin/bash
