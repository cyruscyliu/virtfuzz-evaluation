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
    timestamp = int(timestamp)
    if timestamp not in table:
        table[timestamp] = {}
    table[timestamp][run] = cov
    columns.add(run)

# sort by timestamp
table = {k : table[k] for k in sorted(table)}

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
    data = [str(round(float(covs[i].strip('%')) / 100, 4)) for i in columns]
    dataf = [float(i) for i in data]
    output += data
    output.append('{}'.format(max(dataf)))
    output.append('{}'.format(min(dataf)))
    output.append('{}'.format(round(sum(dataf) / len(columns), 4)))
    outputs.append(output)

# output table
for row in outputs:
    print(','.join([str(i) for i in row]))
