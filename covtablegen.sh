FILE=$1
PATTERN=$2

if [ $3 == 1 ]; then
    grep $FILE $PATTERN* | sort -t- -k7 | tr -s ' ' | awk -F":|-| " '{print $7,$5$6,$21}' | python3 covtablegen.py
else
    grep $FILE $PATTERN* | sort -t- -k6 | tr -s ' ' | awk -F":|-| " '{print $6,$4$5,$19}' | python3 covtablegen.py
fi
