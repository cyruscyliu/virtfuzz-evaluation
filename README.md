# VirtFuzz Evaluation

## General settings

### Build Docker for Evaluation

```
git clone git@github.com:HexHive/virtfuzz-src.git videzzo
pushd videzzo
sudo docker build --target base -t videzzo:latest .
popd

git clone git@github.com:cyruscyliu/virtfuzz-evaluation.git evaluation
pushd evaluation
sudo docker build -t videzzo-evaluation:latest .
popd
```

### Build llvm-project

```
git clone \
    git@github.com:cyruscyliu/virtfuzz-llvm-project.git --depth=1
cp evaluation/run.sh .
sudo bash run.sh # Enter the container
pushd llvm-project && mkdir build-custom && pushd build-custom
cmake -G Ninja -DLLVM_ENABLE_PROJECTS="clang;compiler-rt;lld" \
    -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_OPTIMIZED_TABLEGEN=ON ../llvm/
ninja clang compiler-rt llvm-symbolizer llvm-profdata llvm-cov \
    llvm-config lld llvm-dis opt
popd && popd
```

### Build fuzzers

```
# ViDeZZo QEMU 5.1.0
git clone -b v5.1.0-videzzo    --recurse-submodules \
    git@github.com:cyruscyliu/virtfuzz-qemu.git virtfuzz-qemu-videzzo    --depth=1

# QEMUFuzzer QEMU 5.1.0
git clone -b v5.1.0-qemufuzzer --recurse-submodules \
    git@github.com:cyruscyliu/virtfuzz-qemu.git virtfuzz-qemu-qemufuzzer --depth=1

# ViDeZZo VirtualBox 6.1.14
git clone  \
    git@github.com:cyruscyliu/virtfuzz-vbox.git virtfuzz-vbox            --depth=1

# VShuttle QEMU 5.1.0
git clone -b v5.1.0-vshuttle   --recurse-submodules \
    git@github.com:cyruscyliu/virtfuzz-qemu.git virtfuzz-qemu-vshuttle   --depth=1
git clone \
    git@github.com:cyruscyliu/v-shuttle.git v-shuttle                    --depth=1

# Nyx QEMU 5.1.0
git clone -b v5.1.0-nyx        --recurse-submodules \
    git@github.com:cyruscyliu/virtfuzz-qemu.git virtfuzz-qemu-nyx        --depth=1
git clone \
    git@github.com:cyruscyliu/Nyx.git Nyx                                --depth=1

cp evaluation/run.sh .
sudo bash run.sh # Enter the container
cd evaluation
./build-fuzzer.sh videzzo    qemu
./build-fuzzer.sh videzzo    vbox
./build-fuzzer.sh qemufuzzer qemu
./build-fuzzer.sh vshuttle   qemu
./build-fuzzer.sh nyx        qemu # only for coverage profiling
```

## Benchmark coverage over time

+ Step 1: run fuzzers (for nyx, please check its README)

```
./launch-fuzzer.sh videzzo|qemufuzzer qemu|vbox uhci|ohci|ehci|xhci arp|ar|rp|ap|a|r|p|none [[RUNS] [TIMEOUT]]
./launch-fuzzer.sh vshuttle qemu ohci none [[RUNS] [TIMEOUT]]
```

+ Step 2: calculate coverage and performance

```
./calculate-coverage.sh    videzzo|qemufuzzer|vshuttle|nyx qemu|vbox uhci|ohci|ehci|xhci|qemu_xhci arp|ar|rp|ap|a|r|p|none
./calculate-performance.sh videzzo|qemufuzzer qemu|vbox uhci|ohci|ehci|xhci arp|ar|rp|ap|a|r|p|none
```

### Calculate annotation stats

## Benchmark bugs over time
