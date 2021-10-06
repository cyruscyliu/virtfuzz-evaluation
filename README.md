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

## Evaluation 1: virtfuzz EHCI/OHCI/UHCI/CS4231a
```
pushd evaluation
bash -x ./evaluation-01.sh ehci
bash -x ./evaluation-01.sh ohci
bash -x ./evaluation-01.sh uhci
bash -x ./evaluation-01.sh cs4231a
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

## Evaluation 3: qtest EHCI/OHCI/UHCI/CS4231a
```
pushd evaluation
bash -x ./evaluation-03.sh ehci
bash -x ./evaluation-03.sh ohci
bash -x ./evaluation-03.sh uhci
bash -x ./evaluation-03.sh cs4231a
popd
```

## Figures and Tables

### LoC
```
git diff d0ed6a69d399ae193959225cdeaa9382746c91cc -- "***.c" "***.h" ":(exclude)tests/qtest/fuzz*/*" > v5.1.0.patch
git diff 3e13d8e34b53d8f9a3421a816ccfbdc5fa874e98 -- ":(exclude)tests/qtest/fuzz/stateful_fuzz_callbacks.h" > v6.0.50.patch
cat demo3.py demolib.py | wc
git diff 5f9489b754055da979876bcb5a357310251c6b87 > llvm-project.patch
```

### Generate cov table for each target
```
bash -x clangcovreport.sh ../qemu/build-coverage-5/qemu-fuzz-i386 virtfuzz-ehci-profiles/
bash -x clangcovreport.sh ../qemu/build-coverage-5/qemu-fuzz-i386 qtest-ehci-profiles/
bash -x covtablegen.sh ehci.c reports/cov-profile-virtfuzz-ehci- > virtfuzz-ehci.csv
bash -x covtablegen.sh ehci.c reports/cov-profile-virtfuzz-m-ehci- 1 > virtfuzz-m-ehci.csv
bash -x covtablegen.sh ehci.c reports/cov-profile-qtest-ehci- > qtest-ehci.csv
bash -x covtablegen.sh uhci.c reports/cov-profile-qtest-uhci- > qtest-uhci.csv
bash -x covtablegen.sh ohci.c reports/cov-profile-qtest-ohci- > qtest-ohci.csv
```

### Plot branch cov over time
```
python3 cov24plot.py virtfuzz-ehci.csv
```

## How to Reporduce and Report Bugs

### Crash QEMU with ASAN and UBSAN

### Delta debug and reproduce it

+ Recrash QEMU with corpus
+ Prepare crash-xxx, corpus, QEMU binary and do delta-debugging
+ Double check the results of delta-debugging to get the backtrace

### Write report and send emails

+ Backtrace
+ Reproduce
+ Summary
+ Fix
+ Report
