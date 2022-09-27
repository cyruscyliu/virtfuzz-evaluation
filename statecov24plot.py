#!/usr/bin/python3
import os
import sys

pathname = sys.argv[1]

with open(pathname, 'rb') as f:
    data = f.read()


