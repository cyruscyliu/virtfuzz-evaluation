#/bin/bash -x

BINARY=$1
DIR=$2
REPORTS=$3

rm /tmp/clangcovreport-*.sh
rm /tmp/*.profdata
profiles=$(find $2 -name profile\* -type f)
mkdir -p $REPORTS
cp $BINARY $REPORTS
for profraw in $profiles; do
    FUZZER=$(basename $profraw | cut -d"-" -f2)
    VMM=$(basename $profraw | cut -d"-" -f3)
    TARGET=$(basename $profraw | cut -d"-" -f4)
    VARIANT=$(basename $profraw | cut -d"-" -f5)
    RUN=$(basename $profraw | cut -d"-" -f6)
    profdata=/tmp/$(basename $profraw).profdata
    echo "llvm-profdata merge -output=$profdata $profraw" >> /tmp/clangcovreport-merge.sh
    output=$REPORTS/cov-$(basename $profraw)
    echo "llvm-cov report $BINARY -instr-profile=$profdata -format=text -summary-only > $output" >> /tmp/clangcovreport-report.sh
done

parallel -j$(nproc) --bar < /tmp/clangcovreport-merge.sh
parallel -j$(nproc) --bar < /tmp/clangcovreport-report.sh
