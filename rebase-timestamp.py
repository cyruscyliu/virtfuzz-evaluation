#!/usr/bin/python3
import sys

# timestamp,column,coverage
base = None
for line in sys.stdin:
    items = line.strip().split()
    if len(items) < 3:
        continue
    timestamp, target, cov = items
    if timestamp.find("qemu") != -1:
        continue
    if base is None:
        base = int(timestamp)
    timestamp = str(int(timestamp) - base)
    print(timestamp, target, cov)
