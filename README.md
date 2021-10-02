# VirtFuzz Evaluation

## General settings

### Build Docker for Evaluation 
```
git clone https://git.secos.mobi:9930/all_projects/userspacefuzzing/evaluation.git evaluation
pushd evaluation
sudo docker build -t qemu-spa:latest .
popd
```

### Install VirtFuzz for QEMU 5.1.0
```
git clone -b v5.1.0-virtfuzz https://git.secos.mobi:9930/all_projects/userspacefuzzing/qemu-local.git qemu --depth=1
pushd qemu && mkdir build-coverage-5 && popd
git clone https://git.secos.mobi:9930/all_projects/userspacefuzzing/llvm-project-local.git llvm-project --depth=1
cp evaluation/run.sh .
sudo bash run.sh # Enter the container
pushd llvm-project && mkdir build-custom && pushd build-custom
cmake -G Ninja -DLLVM_USE_LINKER=gold -DLLVM_ENABLE_PROJECTS="clang;compiler-rt" -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_OPTIMIZED_TABLEGEN=ON ../llvm/
ninja clang compiler-rt llvm-symbolizer llvm-profdata llvm-cov
popd && popd
pushd evaluation && ./coverage.sh 5 && popd
```

## Evaluation 1: virtfuzz EHCI/OHCI/UHCI, 3 * 10, Machine A
```
pushd evaluation
bash -x ./evaluation-01.sh ehci
bash -x ./evaluation-01.sh ohci
bash -x ./evaluation-01.sh uhci
popd
```

## Evaluation 2: virtfuzz-m EHCI/OHCI/UHCI, 3 * 10, Machine B
```
pushd evaluation
bash -x ./evaluation-02.sh ehci
bash -x ./evaluation-02.sh ohci
bash -x ./evaluation-02.sh uhci
popd
```

## Figures and Tables

### Generate cov table for each target
```
bash -x ./covgentable.sh ehci.c reports/cov-virtfuzz-ehci-*
```
