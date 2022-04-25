#!/usr/bin/python
# coding=UTF-8
#
# Simple helper script to build SLS files from raw-package-list.txt
#

import os

with open('raw-package-list.txt') as f:
    lines = [line.rstrip('\n ') for line in f]
    #print(lines)

with open('init.sls', 'w') as f:
    f.write('include:\n')
    for line in lines:
        f.write('  - .' + line.replace('.','-dot-') + '\n')

for line in lines:
    with open(line.replace('.','-dot-') + '.sls', 'w') as f:
        f.write(line + ':\n')
        f.write('  pkg.installed')
