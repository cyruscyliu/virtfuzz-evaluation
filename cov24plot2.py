#!/usr/bin/python3
import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
plt.rcParams.update({'font.size': 24})

def plot(metadata, linestyle, marker, color, shadowcolor, ignore_variant=True):
    filename = metadata['filename']
    data = pd.read_csv(filename)
    data['timestamp'] -= data['timestamp'][0]
    label = metadata['fuzzer'].replace('videzzo', 'ViDeZZo').replace(
        'qemufuzzer', 'QEMUFuzzer').replace('vshuttle', 'V-Shuttle-S').replace(
        '-intel', '').replace('-cirrus', '').replace('nyx', 'NYX').replace('qtest', 'QEMUFuzzer')
    if not ignore_variant and metadata['variant'] != 'none':
        label += '-'
        label += metadata['variant'].upper()
    if metadata['target'] == 'ati':
        label += ' (ati)'
    elif metadata['target'] == 'ati2d':
        label += ' (ati_2d)'
    if metadata['target'] == 'e1000e':
        label += ' (e1000e)'
    elif metadata['target'] == 'e1000e_core':
        label += ' (e1000e_core)'
    if metadata['target']  ==  'legacy_xhci':
        label += ' (Legacy)'
    elif  metadata['target']  == 'qemu_xhci':
        label += ' (Spec)'

    plt.plot(data['timestamp'], data['avg'],
             linestyle, linewidth=0.5, color=color, label=label,
             marker=marker, markersize=5, markevery=30)
    l = len(data['timestamp'])
    idx = [i for i in range(0, 10)]
    idx.extend([i for i in range(10, l, 20)])
    t = [data['timestamp'][i] for i in idx]
    mi = [data['min'][i] for i in idx]
    ma = [data['max'][i] for i in idx]
    plt.fill_between(t, mi, ma, color=shadowcolor, alpha=0.6)
    # plt.fill_between(data['timestamp'], data['min'], data['max'], color=shadowcolor, alpha=0.6)
    plt.legend(loc='upper left', fontsize=12, ncol=1)

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
ax.set_ylabel('Count')
# ax.set_ylim(0, 1)
ax.set_xlim(0.9, 86400)
# ax.yaxis.set_major_formatter(mtick.PercentFormatter(1))
# ax.set_aspect(4.9, adjustable='box')

videzzo_markers = ['o', 'v', '1', '8']
videzzopp_markers = ['1', '8']
qemufuzzer_markers = ['p']
vshuttle_markers = ['s']
nyx_markder = ['x', '|']

indicators = sys.argv[-1]
shadowcolor = []
markers = []
colors = []
linestyles = []

ignore_variant = True
for idx, indicator in enumerate(indicators):
    if indicator == 'V':
        # colors.append('#9CCB86')
        colors.append('#0f0f0f')
        shadowcolor.append('#9CCB86')
        if '-' in linestyles:
            ignore_variant = False
            markers.append(videzzo_markers[idx % len(videzzo_markers)])
        else:
            markers.append(None)
        linestyles.append('-')
    elif indicator == 'P':
        # colors.append('#9CCB86')
        colors.append('#0f0f0f')
        shadowcolor.append('#E9E29C')
        if '--' in linestyles:
            ignore_variant = False
            markers.append(videzzopp_markers[idx % len(videzzopp_markers)])
        else:
            markers.append(None)
        linestyles.append('--')
    elif indicator == 'N':
        # colors.append('#E88472')
        colors.append('#0f0f0f')
        shadowcolor.append('#E88472')
        if ':' in linestyles:
            markers.append(nyx_markder[idx % len(nyx_markder)])
        else:
            markers.append(None)
        linestyles.append(':')
if len(shadowcolor) == 0:
    raise "unknow colorset {}".format(colorset)
for i, md in enumerate(metadata):
    plot(md, linestyles[i], markers[i], colors[i], shadowcolor[i], ignore_variant=ignore_variant)

plt.xticks([10, 60, 600, 3600, 86400], ['10s', '1m', '10m', '1h', '24h'])
plt.axvline(x=10, color='purple', linestyle='dotted')
plt.axvline(x=3600, color='purple', linestyle='dotted')
plt.axvline(x=43200, color='purple', linestyle='dotted')
plt.savefig('{}.pdf'.format('@'.join(sys.argv[1:-1])), bbox_inches='tight')
