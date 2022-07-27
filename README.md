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
# VShuttle QEMU 5.1.0 (to be merged)
# Nyx QEMU 5.1. (to be merged)

cp evaluation/run.sh .
sudo bash run.sh # Enter the container
cd evaluation
./build-fuzzer.sh videzzo    qemu
./build-fuzzer.sh videzzo    vbox
./build-fuzzer.sh qemufuzzer qemu
```

## Benchmark coverage over time

+ Step 1: run fuzzers

```
bash -x evaluation-01.sh VMM TARGET VARIANT
# Usage $0 qemu|vbox uhci|ohci|ehci|xhci arp|ar|rp|ap|a|r|p
```

+ Step 2: Generate cov table for each target

```
bash -x clangcovreport.sh ../qemu/out-cov/qemu-fuzz-i386 virtfuzz-qemu-ehci-profiles/ virtfuzz-qemu-ehci-reports/
bash -x covtablegen-new.sh ehci.c reports/cov-profile-virtfuzz-ehci- [0|1] > virtfuzz-ehci.csv

bash -x clangcovreport.sh ../vbox/out-cov/VBoxVideZZo    virtfuzz-vbox-ehci-profiles/ virtfuzz-vbox-ehci-reports/
bash -x covtablegen-new.sh ehci.c reports/cov-profile-virtfuzz-ehci- [0|1] > virtfuzz-ehci.csv
```

+ Step 3: Plot branch cov over time

Please look at [replot.sh](./results/replot.sh).

+ Step 4: Calculate overhead if necessary

```
python3 overhead24cal.py virtfuzz-qemu-uhci-logs/*.log > virtfuzz-qemu-uhci.overhead
python3 overhead24cal.py virtfuzz-qemu-ohci-logs/*.log > virtfuzz-qemu-ohci.overhead
python3 overhead24cal.py virtfuzz-qemu-ehci-logs/*.log > virtfuzz-qemu-ehci.overhead
python3 overhead24cal.py virtfuzz-qemu-xhci-logs/*.log > virtfuzz-qemu-xhci.overhead
python3 overhead24cal.py virtfuzz-vbox-ohci-logs/*.log > virtfuzz-vbox-ehci.overhead
```

### Calculate annotation stats

## Benchmark bugs over time
