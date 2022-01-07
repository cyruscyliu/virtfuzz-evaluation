FILE=$1
PATTERN=$2

rm -f /tmp/xxxVirtFuzzxxx.$FILE
for ROUND in $(seq 0 9); do
    if [ $3 == 1 ]; then
        grep -e $FILE $PATTERN$ROUND* | sort -t- -k6 | tr -s ' ' | awk -F":|-| " '{print $7,$5$6,$NF}' | python3 rebase-timestamp.py >> /tmp/xxxVirtFuzzxxx.$FILE
    else
        grep -e $FILE $PATTERN$ROUND* | sort -t- -k6 | tr -s ' ' | awk -F":|-| " '{print $6,$4$5,$NF}' | python3 rebase-timestamp.py >> /tmp/xxxVirtFuzzxxx.$FILE
    fi
done
cat /tmp/xxxVirtFuzzxxx.$FILE | python3 covtablegen.py
