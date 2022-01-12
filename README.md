# VirtFuzz Evaluation

## General settings

### Build Docker for Evaluation
```
git clone git@github.com:cyruscyliu/virtfuzz-evaluation.git evaluation
pushd evaluation
sudo docker build -t qemu-spa:latest .
popd
```

### Install VirtFuzz for QEMU 5.1.0
```
# git clone -b v5.1.0-virtfuzz git@github.com:cyruscyliu/virtfuzz-qemu.git qemu --depth=1 # for qtest and legacy videzzo
git clone -b v5.1.0-group-mutators git@github.com:cyruscyliu/virtfuzz-qemu.git qemu --depth=1 # for videzzo
pushd qemu && mkdir build-coverage-5 && popd
git clone git@github.com:cyruscyliu/virtfuzz-llvm-project.git llvm-project --depth=1
cp evaluation/run.sh .
sudo bash run.sh # Enter the container
pushd llvm-project && mkdir build-custom && pushd build-custom
cmake -G Ninja -DLLVM_USE_LINKER=gold -DLLVM_ENABLE_PROJECTS="clang;compiler-rt" -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_OPTIMIZED_TABLEGEN=ON ../llvm/
ninja clang compiler-rt llvm-symbolizer llvm-profdata llvm-cov llvm-config
popd && popd
pushd evaluation && ./coverage.sh 5 && popd
```

## Evaluation 1: virtfuzz EHCI/OHCI/UHCI/CS4231a/E1000/RTL8139/ATI-VGA/Megasas
>bash -x ./evaluation-01.sh ehci/ohci/uhci/cs4231a/e1000/rtl8139/ati/megasas

## Evaluation 2: virtfuzz-m EHCI/OHCI/UHCI
>bash -x ./evaluation-02.sh ehci/ohci/uhci

## Evaluation 3: qtest EHCI/OHCI/UHCI/CS4231a/E1000/RTL8139/Megasas
>bash -x ./evaluation-03.sh ehci/ohic/uhci/cs4231a/e1000/rtl8139/megasas

## Evaluation 4: virtfuzz everything else
>parallel --bar -j 10 < evaluation-04-xxx.sh

## Evaluation 5: virtfuzz-mf EHIC/OHCI/UHCI
>bash -x ./evaluation-05.sh ehci/ohci/uhci

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
bash -x clangcovreport.sh ../qemu/build-coverage-5/qemu-fuzz-i386 virtfuzz-ehci-profiles/ virtfuzz-ehci-reports/
bash -x covtablegen-new.sh ehci.c reports/cov-profile-virtfuzz-ehci- [0|1] > virtfuzz-ehci.csv
```

### Plot branch cov over time
```
# please look at replot.sh
python3 -m pip install numpy pandas matplotlib
python3 cov24plot.py virtfuzz-ehci.csv
```

### Calculate overhead
```
python3 overhead24cal.py virtfuzz-ehci-*.log > virtfuzz-ehci.overhead
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
