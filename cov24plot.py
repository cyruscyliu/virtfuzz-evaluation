#!/usr/bin/python3
import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
plt.rcParams.update({'font.size': 24})

def plot(metadata, linestyle, shadowcolor):
    filename = metadata['filename']
    data = pd.read_csv(filename)
    data['timestamp'] -= data['timestamp'][0]
    label = metadata['tool'].replace('virtfuzz', 'ViDeZZo').replace('-f', '-NP').replace('-m', '-NH').replace('qtest', 'QEMUFuzzer').replace('vshuttle', 'V-Shuttle-S').replace('-intel', '')
    if metadata['target'] == 'ati':
        label += ' (ati)'
    elif metadata['target'] == 'ati2d':
        label += ' (ati_2d)'
    if metadata['target'] == 'e1000e':
        label += ' (e1000e)'
    elif metadata['target'] == 'e1000e_core':
        label += ' (e1000e_core)'
    print(metadata['target'])
    plt.plot(data['timestamp'], data['avg'], linestyle, linewidth=2, color='black', label=label)
    plt.fill_between(data['timestamp'], data['min'], data['max'], color=shadowcolor, alpha=0.8)
    plt.legend(loc='upper left', fontsize='x-small')

# name convention
# virtfuzz-ehci.csv virtfuzz-m-ehci.csv
ntools = len(sys.argv) - 1
if ntools == 0:
    printf('[-] there is no data available')
    exit(1)
metadata = []
for filename in sys.argv[1:]:
    tool = '-'.join(filename[:-4].split('-')[:-1])
    target = filename[:-4].split('-')[-1]
    metadata.append({'filename': filename, 'tool': tool, 'target': target})

fig, ax = plt.subplots()
ax.set_xscale('log')
ax.set_ylabel('Branch Coverage')
ax.set_ylim(0, 1)
ax.set_xlim(0.9, 86400)
ax.yaxis.set_major_formatter(mtick.PercentFormatter(1))
ax.set_aspect(4.9, adjustable='box')

linestyle = ['-', '--', '-.', ':', '.']
# shadowcolor = ['0.55', '0.65', '0.75', '0.85', '0.95']
shadowcolor = ['lightcoral', 'navajowhite', 'lightgreen', 'skyblue', 'plum']
for i, md in enumerate(metadata):
    plot(md, linestyle[i], shadowcolor[i])

plt.xticks([10, 60, 600, 3600, 86400], ['10s', '1m', '10m', '1h', '24h'])
plt.axvline(x=10, color='purple', linestyle='dotted')
if len(metadata) > 4:
    plt.axvline(x=1800, color='purple', linestyle='dotted')
plt.axvline(x=3600, color='purple', linestyle='dotted')
plt.savefig('{}.pdf'.format('@'.join(sys.argv[1:])), bbox_inches='tight')
