#!/usr/bin/python3
import sys
import seaborn as sns
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick

def plot(metadata, linestyle, shadowcolor):
    filename = metadata['filename']
    data = pd.read_csv(filename)
    data['timestamp'] -= data['timestamp'][0]
    plt.plot(data['timestamp'], data['avg'], linestyle, linewidth=2, color='black')
    plt.fill_between(data['timestamp'], data['min'], data['max'], color=shadowcolor)

# name convention
# virtfuzz-ehci.csv virtfuzz-m-ehci.csv
ntools = len(sys.argv) - 1
if ntools == 0:
    printf('[-] there is no data available')
    exit(1)
metadata = []
for filename in sys.argv[1:]:
    tool = '-'.join(filename.strip('.csv').split('-')[:-1])
    target = filename.strip('.csv').split('-')[-1]
    metadata.append({'filename': filename, 'tool': tool, 'target': target})

fig, ax = plt.subplots()
ax.set_xscale('log')
ax.set_xlabel('Time (log)')
ax.set_ylabel('Branch Coverage')
plt.xticks([10, 60, 600, 3600, 36000, 86400], ['10s', '1m', '10m', '1h', '10h', '24h'])
ax.set_ylim(0, 1)
ax.yaxis.set_major_formatter(mtick.PercentFormatter(1))
ax.set_aspect(4.5, adjustable='box')

linestyle = ['-', '--', '-.', ':']
shadowcolor = ['0.6', '0.7', '0.8', '0.9']
for i, md in enumerate(metadata):
    plot(md, linestyle[i], shadowcolor[i])

plt.savefig('{}.pdf'.format('@'.join(sys.argv[1:])))
