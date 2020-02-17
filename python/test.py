#!/usr/bin/env python
import pyscs
import json

def filetest():
    with open("../inputs/4km.json") as f:
        print(pyscs.pyscs(f.read()))

inp = {
    "friends": [
        {"name": "キラーマシン", "lv": 30, "weakenAtk": 6, "doubleSpeed": True},
        {"name": "キラーマシン", "lv": 30, "weakenAtk": 6, "doubleSpeed": True},
        {"name": "キラーマシン", "lv": 30, "weakenAtk": 6, "doubleSpeed": True},
        {"name": "キラーマシン", "lv": 30, "weakenAtk": 6, "doubleSpeed": True},
        {"name": "キラーマシン", "lv": 30, "doubleSpeed": True},
        {"name": "キラーマシン", "lv": 30, "doubleSpeed": True},
        {"name": "キラーマシン", "lv": 30, "doubleSpeed": True},
        {"name": "スモールグール", "lv": 30, "doubleSpeed": True},
        {"name": "ホイミスライム", "lv": 30, "doubleSpeed": True},
        {"name": "ホイミスライム", "lv": 30, "doubleSpeed": True},
    ],
    "field": {
        "row": 10,
        "col": 10,
        "data": [
            1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
            1,  1,  0,  0,  0,  0,  0,  1,  1,  1,
            1,  1,  0, 19,  0,  0,  0,  1,  1,  1,
            1,  1, 10, 11, 12, 13, 18,  1,  1,  1,
            1,  1,  0,  0,  0,  9,  1,  1,  1,  1,
            1,  1,  0,  0,  0,  0,  1,  1,  1,  1,
            1,  1, 14, 15, 16, 17,  1,  1,  1,  1,
            1,  1,  0,  0,  0,  0,  1,  1,  1,  1,
            1,  1,  0,  0,  0,  0,  1,  1,  1,  1,
            1,  1,  1,  1,  1,  1,  1,  1,  1,  1
        ]
    },
    "config": {
        "trial": 100,
        "turn": 1500
    }
}

exp = pyscs.pyscs(json.dumps(inp))
print(exp)
