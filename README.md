# VirtFuzz Evaluation

## General settings

### Build Docker for Evaluation
```
git clone git@github.com:cyruscyliu/virtfuzz-evaluation.git evaluation
pushd evaluation
sudo docker build -t virtfuzz:latest .
popd
```

### Test VirtFuzz for QEMU 5.1.0
```
git clone -b v5.1.0-videzzo git@github.com:cyruscyliu/virtfuzz-qemu.git qemu-videzzo --depth=1
# git clone -b v5.1.0-qemufuzzer git@github.com:cyruscyliu/virtfuzz-qemu.git qemu-qemufuzzer --depth=1
pushd qemu && mkdir build-coverage-5 && popd
git clone git@github.com:cyruscyliu/virtfuzz-llvm-project.git llvm-project --depth=1
cp evaluation/run.sh .
sudo bash run.sh # Enter the container
pushd llvm-project && mkdir build-custom && pushd build-custom
cmake -G Ninja -DLLVM_ENABLE_PROJECTS="clang;compiler-rt;lld" -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_OPTIMIZED_TABLEGEN=ON ../llvm/
ninja clang compiler-rt llvm-symbolizer llvm-profdata llvm-cov llvm-config lld
popd && popd
pushd evaluation && ./coverage.sh 5 1 && popd # videzzo
# pushd evaluation && ./coverage.sh 5 0 && popd # qemufuzzer
```

### Run QEMUFuzzer
```
bash -x evaluation-03.sh TARGET
```

### Run ViDeZZo
```
bash -x evaluation-01.sh TARGET
bash -x evaluation-01.sh TARGET # disable intra-message annotation
bash -x evaluation-01.sh TARGET # disable intra-message annotation but enable fork server
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
