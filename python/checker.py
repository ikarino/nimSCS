#!/usr/bin/env python
import pickle
import glob
import json

from pyscs import pyscs

def printMap(d):
    if d == 9:
        return "|   "
    elif d == 1:
        return "|###"
    else:
        return "| %d " % (d-10)

for f in sorted(glob.glob("optimize*.pickle"))[-3:]:
    print(f)
    print("====================")
    with open(f, "rb") as f:
        results = pickle.load(f)
    result = results[0]
    inp, exp = result
    print(exp)
    for row in range(10):
        srow = inp["field"]["data"][row*10:(row+1)*10]
        print("".join(map(printMap, srow)) + "|")
    for iif in range(7):
        f = inp["friends"][iif]
        print("%s(%d): %d" % (f["name"], iif, f["weakenAtk"]))

    # exp_new = pyscs(json.dumps(inp))/ inp["config"]["trial"]
    # print(inp)
    # print(exp_new)
