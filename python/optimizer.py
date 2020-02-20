import json
import random
from pprint import pprint
from functools import lru_cache
from copy import deepcopy
import pickle

import numpy as np
from deap import creator, base, tools, algorithms
# from scoop import futures

from pyscs import pyscs


defaultInp = {
    "friends": [
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "スモールグール", "lv": 20},
        {"name": "ホイミスライム", "lv": 20},
        {"name": "ホイミスライム", "lv": 20},
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

def opt1():
    result = {}
    def scs(weakenAtks):
        nonlocal result
        key = "".join(map(str, weakenAtks))
        if key in result:
            return result[key]
        inp = deepcopy(defaultInp)
        for i in range(7):
            inp["friends"][i]["weakenAtk"] = weakenAtks[i]
        value = pyscs(json.dumps(inp))
        result[key] = value
        print(key, value)
        return value
    return scs

def createInp(gene):
    friends = [
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "キラーマシン", "lv": 13},
        {"name": "スモールグール", "lv": 20},
        {"name": "ホイミスライム", "lv": 20},
        {"name": "ホイミスライム", "lv": 20},
    ]

    MAPSIZE = 8
    geneNow = 0
    def getGene(step):
        nonlocal geneNow
        geneNow += step
        return int("".join(map(str, gene[geneNow-step:geneNow])), 2)
    ##
    ## [FIELD]
    ##
    friend_positions = []
    for friend in range(10):
        row = getGene(3)
        col = getGene(3)
        if [row, col] in friend_positions:
            # print("same friend position: [%d, %d]" % (row, col))
            return 0
        else:
            # print("friend %d => [%d, %d]" % (friend, row, col))
            friend_positions.append([row, col])

    data = [1] * (MAPSIZE+2)
    for row in range(MAPSIZE):
        data.append(1)
        for col in range(MAPSIZE):
            if [row, col] in friend_positions:
                data.append(friend_positions.index([row, col])+10)
            else:
                g = getGene(1)
                if g == 0:
                    data.append(9)
                else:
                    data.append(1)
        data.append(1)
    data += [1] * (MAPSIZE+2)
    assert len(data) == (MAPSIZE+2)**2, len(data)

    ##
    ## [ORDER]
    ##
    # TODO

    ##
    ## [weakenAtk]
    ##
    for friend in friends:
        if friend["name"] == "キラーマシン":
            w = getGene(3)
            # print("weakenAtk: ", w)
            friend["weakenAtk"] = w
    # print(friends)

    # print("gene length: ", len(gene))
    # print("geneNow:     ", geneNow)

    return {
        "friends": friends,
        "field": {
            "col": 10,
            "row": 10,
            "data": data
        },
        "config": {
            "turn": 1500,
            "trial": 100,
        }
    }

def opt2():
    result = {}
    def scs(gene):
        nonlocal result
        key = "".join(map(str, gene))
        if key in result:
            return result[key]

        inp = createInp(gene)
        if inp == 0:
            return 0

        value = pyscs(json.dumps(inp))/ inp["config"]["trial"]
        if value > 0:
            result[key] = value
            if len(result) % 100 == 0 and len(result) > 0:
                with open("result%03d.pickle" % (len(result)/100), "wb") as f:
                    pickle.dump(result, f)
        return value
    return scs

if __name__ == "__main__":
    creator.create("FitnessMax", base.Fitness, weights=(1.0,))
    creator.create("Individual", list, fitness=creator.FitnessMax)

    toolbox = base.Toolbox()
    # toolbox.register("map", futures.map)

    toolbox.register("attr_bool", random.randint, 0, 1)
    toolbox.register("individual", tools.initRepeat, creator.Individual, toolbox.attr_bool, n=135)
    toolbox.register("population", tools.initRepeat, list, toolbox.individual)

    f = opt2()
    def evalOneMax(individual):
        return f(individual),

    toolbox.register("evaluate", evalOneMax)
    toolbox.register("mate", tools.cxTwoPoint)
    toolbox.register("mutate", tools.mutFlipBit, indpb=0.05)
    # toolbox.register("select", tools.selTournament, tournsize=3)
    toolbox.register("select", tools.selRoulette)

    population = toolbox.population(n=4000)

    NGEN = 300
    for gen in range(NGEN):
        print("%d-th generation" % gen)
        print("="*50)
        offspring = algorithms.varAnd(population, toolbox, cxpb=0.5, mutpb=0.1)
        fits = toolbox.map(toolbox.evaluate, offspring)
        for fit, ind in zip(fits, offspring):
            ind.fitness.values = fit
        population = toolbox.select(offspring, k=len(population))

        genes = tools.selBest(population, k=10)

        result = []
        for gene in genes:
            print(evalOneMax(gene))
            result.append([createInp(gene), evalOneMax(gene)[0]])
        with open("optimize_%03d.pickle" % gen, "wb") as pickleFile:
            pickle.dump(result, pickleFile)
