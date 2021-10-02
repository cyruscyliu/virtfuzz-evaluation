FILE=$1
PATTERN=$2

if [ $3 == 1 ]; then
    grep $FILE $PATTERN* | sort -t- -k7 | xargs -i echo {} | tr -s ' ' | awk -F":|-| " '{print $7,$5$6,$21}' | python3 covtablegen.py
else
    grep $FILE $PATTERN* | sort -t- -k6 | xargs -i echo {} | tr -s ' ' | awk -F":|-| " '{print $6,$4$5,$20}' | python3 covtablegen.py
fi
