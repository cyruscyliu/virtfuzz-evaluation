FILE=$1
PATTERN=$2
grep $FILE $PATTERN* | sort -t- -k6 | xargs -i echo {} | tr -s ' ' | awk -F":|-| " '{print $6,$4$5,$20}' | python3 covtablegen.py
