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
    label = metadata['fuzzer'].replace('videzzo', 'ViDeZZo').replace(
        'qemufuzzer', 'QEMUFuzzer').replace('vshuttle', 'V-Shuttle-S').replace(
        '-intel', '').replace('-cirrus', '').replace('nyx', 'NYX')
    label += '-'
    label += metadata['variant']
    if metadata['target'] == 'ati':
        label += ' (ati)'
    elif metadata['target'] == 'ati2d':
        label += ' (ati_2d)'
    if metadata['target'] == 'e1000e':
        label += ' (e1000e)'
    elif metadata['target'] == 'e1000e_core':
        label += ' (e1000e_core)'

    plt.plot(data['timestamp'], data['avg'], linestyle, linewidth=2, color='black', label=label)
    plt.fill_between(data['timestamp'], data['min'], data['max'], color=shadowcolor, alpha=0.8)
    plt.legend(loc='upper left', fontsize='x-small')

# name convention
# videzzo-qemu-ehci-arp.csv
ntools = len(sys.argv) - 2
if ntools == 0:
    printf('[-] there is no data available')
    exit(1)
metadata = []
for filename in sys.argv[1:-1]:
    fuzzer, vmm, target, variant = filename[:-4].split('-')
    metadata.append({'filename': filename, 'fuzzer': fuzzer, 'target': target, 'vmm': vmm, 'variant': variant})

fig, ax = plt.subplots()
ax.set_xscale('log')
ax.set_ylabel('Branch Coverage')
ax.set_ylim(0, 1)
ax.set_xlim(0.9, 86400)
ax.yaxis.set_major_formatter(mtick.PercentFormatter(1))
ax.set_aspect(4.9, adjustable='box')

# shadowcolor = ['0.55', '0.65', '0.75', '0.85', '0.95']
# shadowcolor = ['lightcoral', 'navajowhite', 'lightgreen', 'skyblue', 'plum']
colorset = sys.argv[-1]
shadowcolor = []
for indicator in colorset:
    if indicator == 'V':
        shadowcolor.append('pink')
    elif indicator == 'Q':
        shadowcolor.append('orange')
    elif indicator == 'N':
        shadowcolor.append('cyan')
if len(shadowcolor) == 0:
    raise "unknow colorset {}".format(colorset)
for i, md in enumerate(metadata):
    plot(md, '-', shadowcolor[i])

plt.xticks([10, 60, 600, 3600, 86400], ['10s', '1m', '10m', '1h', '24h'])
plt.axvline(x=10, color='purple', linestyle='dotted')
if len(metadata) > 4:
    plt.axvline(x=1800, color='purple', linestyle='dotted')
plt.axvline(x=3600, color='purple', linestyle='dotted')
plt.savefig('{}.pdf'.format('@'.join(sys.argv[1:-1])), bbox_inches='tight')
