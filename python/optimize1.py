import json
import random
from functools import lru_cache
from copy import deepcopy
import pickle

from deap import creator, base, tools, algorithms
from pyscs import pyscs


defaultInp = {
    "friends": [
        {"name": "キラーマシン", "lv": 30, "doubleSpeed": True},
        {"name": "キラーマシン", "lv": 30, "doubleSpeed": True},
        {"name": "キラーマシン", "lv": 30, "doubleSpeed": True},
        {"name": "キラーマシン", "lv": 30, "doubleSpeed": True},
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


def func():
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

def main():
    creator.create("FitnessMax", base.Fitness, weights=(1.0,))
    creator.create("Individual", list, fitness=creator.FitnessMax)

    toolbox = base.Toolbox()

    toolbox.register("attr_bool", random.randint, 0, 6)
    toolbox.register("individual", tools.initRepeat, creator.Individual, toolbox.attr_bool, n=7)
    toolbox.register("population", tools.initRepeat, list, toolbox.individual)

    f = func()
    def evalOneMax(individual):
        return f(individual),

    toolbox.register("evaluate", evalOneMax)
    toolbox.register("mate", tools.cxTwoPoint)
    toolbox.register("mutate", tools.mutFlipBit, indpb=0.05)
    toolbox.register("select", tools.selTournament, tournsize=3)

    population = toolbox.population(n=300)

    NGEN=40
    for gen in range(NGEN):
        print(gen)
        offspring = algorithms.varAnd(population, toolbox, cxpb=0.5, mutpb=0.1)
        fits = toolbox.map(toolbox.evaluate, offspring)
        for fit, ind in zip(fits, offspring):
            ind.fitness.values = fit
        population = toolbox.select(offspring, k=len(population))
        top10 = tools.selBest(population, k=10)
        for x in top10:
            print(x, evalOneMax(x))
if __name__ == "__main__":
    main()
    # a = [6,6,6,6,0,4,0]
    # f = func()
    # print(f(a))
    # print(f(a))
