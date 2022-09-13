import os
import sys

target_dir = sys.argv[1]

profiles = sorted(os.listdir(target_dir))

sampled_seeds = [i for i in range(0, len(profiles), 10)]
sampled_seeds.append(len(profiles) - 1)

sampled_profiles = []

for index, profile in enumerate(profiles):
    if index in sampled_seeds:
        continue
    print('rm {}/{}'.format(target_dir, profile))
    os.system('rm {}/{}'.format(target_dir, profile))
