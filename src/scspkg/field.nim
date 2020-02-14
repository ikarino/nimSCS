# field.nim
import json, sequtils, sugar

import custom_types

type SCSField* = ref object of RootObj
  row*: int
  col*: int
  data*: seq[seq[int]]

proc newField*(inp: JsonNode): SCSField =
  let row = inp["row"].getInt()
  let col = inp["col"].getInt()
  let inpData = inp["data"].getElems().map(jo => jo.getInt())

  if row*col != inpData.len:
    raise newException(SCSError, "invalid field data length")

  var data: seq[seq[int]]
  for irow in 0..row-1:
    data.add(inpData[irow*col..(irow+1)*col-1])

  return SCSField(row: row, col: col, data: data)


proc setField*(f: SCSField, p: Place, num: int) =
  f.data[p.row][p.col] = num

proc getField*(f: SCSField, p: Place): int =
  return f.data[p.row][p.col]

proc show* (f: SCSField): string =
  result = ""
  for row in countup(0, f.row-1):
    for col in countup(0, f.col-1):
      let d = f.data[row][col]
      let unit = if d >= 20: "*" else: $(d mod 10)
      case d:
        of 0: result.add(" ")
        of 1: result.add("#")
        of 9: result.add("*")
        else: result.add(unit)
    result.add("\n")

proc findFriend*(f: SCSField, num: int): Place =
  for row in countup(0, f.row-1):
    for col in countup(0, f.col-1):
      if f.data[row][col] == num:
        return Place(row: row, col: col)
  raise newException(SCSError, "friend not found")

proc findEnemys*(f: SCSField): seq[Place] =
  for row in countup(0, f.row-1):
    for col in countup(0, f.col-1):
      if f.data[row][col] == 9:
        result.add(Place(row: row, col: col))

proc findTargets*(f: SCSField, place: Place, includeCorner: bool=false): seq[int] =
  let myNumber = f.getField(place)
  let rowMe = place.row
  let colMe = place.col

  proc isTarget(num: int): bool =
    if myNumber >= 20:
      return toSeq(10..19).any(x => x == num)
    else:
      return num >= 20

  for drow in -1..1:
    for dcol in -1..1:
      let tPlace = Place(row: rowMe+drow, col: colMe+dcol)
      let tNumber = f.getField(tPlace)
      if not isTarget(tNumber):
        continue
      if drow == 0 and dcol == 0:
        continue

      if dcol*drow == 0:
        result.add(tNumber)
        continue

      let numberUD = f.data[rowMe+drow][colMe]
      let numberLR = f.data[rowMe][colMe+dcol]
      let isCorner = (numberUD == 1) or (numberLR == 1)

      if not isCorner or includeCorner:
        result.add(tNumber)

proc findVacants*(f: SCSField, place: Place, includeCorner: bool=false): seq[Place] =
  let rowMe = place.row
  let colMe = place.col

  proc isTarget(num: int): bool = num == 0

  for drow in -1..1:
    for dcol in -1..1:
      let tPlace = Place(row: rowMe+drow, col: colMe+dcol)
      let tNumber = f.getField(tPlace)
      if not isTarget(tNumber):
        continue
      if drow == 0 and dcol == 0:
        continue

      if dcol*drow == 0:
        result.add(tPlace)
        continue

      let numberUD = f.data[rowMe+drow][colMe]
      let numberLR = f.data[rowMe][colMe+dcol]
      let isCorner = (numberUD == 1) or (numberLR == 1)

      if not isCorner or includeCorner:
        result.add(tPlace)
