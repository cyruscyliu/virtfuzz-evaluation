FILE=$1
PATTERN=$2

rm -f /tmp/xxxVirtFuzzxxx
for ROUND in $(seq 0 9); do
    # 19 func, 21 line
    grep -e $FILE $PATTERN$ROUND* | sort -t- -k12 | tr -s ' ' | awk -F":|-| " '{print $12,$9$11,$NF}' | python3 rebase-timestamp.py >> /tmp/xxxVirtFuzzxxx
done
cat /tmp/xxxVirtFuzzxxx | python3 covtablegen.py
