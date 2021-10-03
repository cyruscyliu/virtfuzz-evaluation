#!/usr/bin/python3
import sys
import numpy as np

overall = []
for filename in sys.argv[1:]:
    print('[+] handling {}'.format(filename))
    speed = []
    with open(filename) as f:
        for line in f:
            if line.find('exec/s') == -1:
                continue
            items = line.strip().split()
            if items[1] == 'INITED':
                continue
            if items[10] == 'exec/s:':
                speed.append(int(items[11]))
            else:
                print(line.strip())
    overall.append([np.median(speed), np.average(speed), np.std(speed)])

median = np.average([speed[0] for speed in overall])
average = np.average([speed[1] for speed in overall])
std = np.average([speed[2] for speed in overall])
print('[+] median: {}, average: {}, std: {}'.format(median, average, std))
