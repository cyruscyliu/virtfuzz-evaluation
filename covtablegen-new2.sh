FILE=$1
PATTERN=$2
MODE=$3

if [ -z $MODE ]; then
    echo "Please set MODEL"
    exit
fi

rm -f /tmp/xxxVirtFuzzxxx.$FILE
for ROUND in $(seq 0 9); do
    if [ $MODE == 1 ]; then
        grep -e $FILE $PATTERN$ROUND* | sort -t- -k12 | tr -s ' ' | awk -F":|-| " '{print $12,$9$11,$NF}' | python3 rebase-timestamp.py >> /tmp/xxxVirtFuzzxxx.$FILE
    elif [ $MODE == 2 ]; then
        grep -e $FILE $PATTERN$ROUND* | sort -t- -k12 | tr -s ' ' | awk -F":|-| " '{print $14,$10$11$13,$NF}' | python3 rebase-timestamp.py >> /tmp/xxxVirtFuzzxxx.$FILE
    elif [ $MODE == 3 ]; then
        grep -e $FILE $PATTERN$ROUND* | sort -t- -k12 | tr -s ' ' | awk -F":|-| " '{print $16,$11$12$13$15,$NF}' | python3 rebase-timestamp.py >> /tmp/xxxVirtFuzzxxx.$FILE
    fi
done
cat /tmp/xxxVirtFuzzxxx.$FILE | python3 covtablegen.py
