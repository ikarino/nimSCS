# mathFunctions.nim
import math, json, sequtils, sugar

proc mean*[T] (s: openArray[T]): float =
  return s.sum().float/s.len.float

proc std*[T] (s: openArray[T]): float =
  let m = s.mean()
  var variance: float = 0
  for x in s:
    variance += pow(x.float-m, 2)
  return sqrt(variance/s.len.float)

proc getMeanAndStdFromArray* (arrs: seq[seq[int]]): JsonNode =
  var
    arrayM: seq[float]
    arrayS: seq[float]
  for index in 0..len(arrs[0])-1:
    arrayM.add(mean(arrs.map(arr => arr[index])));
    arrayS.add(std(arrs.map(arr => arr[index])));
  %* {
    "mean": arrayM,
    "std": arrayS
  }


