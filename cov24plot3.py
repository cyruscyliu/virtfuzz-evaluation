#!/usr/bin/python3
import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
plt.rcParams.update({'font.size': 24})

def plot(metadata, linestyle, marker, dashes, color, shadowcolor, ignore_variant=True):
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
             marker=marker, markersize=5, markevery=20, dashes=dashes)
    plt.fill_between(data['timestamp'], data['min'], data['max'], color=shadowcolor, alpha=0.6)
    plt.legend(loc='lower right', fontsize=12, ncol=1)

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

videzzo_markers = ['o', 'v', 's', 'D']
qemufuzzer_markers = ['p']
vshuttle_markers = ['s']
nyx_markder = ['x', '|']

indicators = sys.argv[-1]
shadowcolor = []
markers = []
colors = []
linestyles = []
dashes = []

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
        dashes.append((2, 0))
    elif indicator == 'Q':
        # colors.append('#E9E29C')
        colors.append('#0f0f0f')
        shadowcolor.append('#E9E29C')
        # markers.append(qemufuzzer_markers[idx % len(qemufuzzer_markers)])
        markers.append(None)
        linestyles.append('-')
        dashes.append((2, 1))
    elif indicator == 'N':
        # colors.append('#E88472')
        colors.append('#0f0f0f')
        shadowcolor.append('#E88472')
        if ':' in linestyles:
            markers.append(nyx_markder[idx % len(nyx_markder)])
        else:
            markers.append(None)
        linestyles.append('-')
        dashes.append((2, 4))
    elif indicator == 'S':
        # colors.append('#EEB479')
        colors.append('#0f0f0f')
        shadowcolor.append('#EEB479')
        # markers.append(vshuttle_markers[idx % len(vshuttle_markers)])
        markers.append(None)
        linestyles.append('-')
        dashes.append((2, 10))
if len(shadowcolor) == 0:
    raise "unknow colorset {}".format(colorset)
for i, md in enumerate(metadata):
    plot(md, linestyles[i], markers[i], dashes[i], colors[i], shadowcolor[i], ignore_variant=ignore_variant)

plt.xticks([10, 60, 600, 3600, 86400], ['10s', '1m', '10m', '1h', '24h'])
plt.axvline(x=10, color='purple', linestyle='dotted')
plt.axvline(x=3600, color='purple', linestyle='dotted')
plt.axvline(x=43200, color='purple', linestyle='dotted')
plt.savefig('{}.pdf'.format('@'.join(sys.argv[1:-1])), bbox_inches='tight')
