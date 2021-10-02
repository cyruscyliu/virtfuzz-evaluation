#!/usr/bin/python3
import sys

# load results
table = {}
columns = set([])
for line in sys.stdin:
    items = line.strip().split()
    if len(items) < 3:
        continue
    # timestamp,run,cov
    timestamp, run, cov = items
    if timestamp not in table:
        table[timestamp] = {}
    table[timestamp][run] = cov
    columns.add(run)

# fill in gaps
last_cov = {}
for timestamp, covs in table.items():
    for column in columns:
        if column in covs:
            last_cov[column] = covs[column]
        else:
            table[timestamp][column] = last_cov[column]

# generate table
header = ['timestamp']
header += list(columns)
header += ['max', 'min', 'avg']
outputs = [header]
for timestamp, covs in table.items():
    output = []
    output.append(timestamp)
    data = [covs[i] for i in columns]
    dataf = [float(i.strip('%')) for i in data]
    output += data
    output.append('{}%'.format(max(dataf)))
    output.append('{}%'.format(min(dataf)))
    output.append('{}%'.format(round(sum(dataf) / len(columns), 2)))
    outputs.append(output)

# output table
for row in outputs:
    print(','.join(row))
