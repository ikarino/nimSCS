# unit.nim

import json, math, random
import custom_types, status

type SCSUnit* = ref object of RootObj
  name*: string
  lv: int
  mhp*: int
  chp*: float
  atk, def: int
  recovery: int
  exp: int
  maximumLv: int
  hpDope, atkDope: int
  weakenAtk, weakenDef: int
  isSealed*: bool
  place*: Place
  pConf: ProbabilityConfig

type Friend* = ref object of SCSUnit
  order*: int
  doubleSpeed*: bool
  killCount: int
  divisionLossCount*: int
  actionLossCount*: int
  isSticked*: bool

type Enemy* = ref object of SCSUnit
  num*: int

proc setStatus(f: SCSUnit) =
  let bms = getBasicMonsterStatus(f.name, f.lv)
  # exp/recovery/maximumLv
  f.exp = bms.exp
  f.recovery = bms.recovery
  f.maximumLv = bms.maximumLv

  # hp
  f.mhp = bms.mhp0 + f.hpDope

  # atk
  var atk: float = bms.atk0.float + f.atkDope.float
  if f.weakenAtk == 9:
    atk = 0
  elif f.weakenAtk > 0:
    atk *= pow(0.5, f.weakenAtk.float)
  f.atk = math.ceil(atk).int

  # def
  var def: float = bms.def0.float
  case f.weakenDef:
    of 0:
      def *= 1
    of 1:
      def *= 0.8
    of 2:
      def *= 0.7
    of 3:
      def *= 0.5
    of 4:
      def *= 0.4
    of 5:
      def *= 0.2
    of 6:
      def *= 0.001
    else:
      raise newException(SCSError, "NotImplemeted: weakenDef over 7")
  f.def = floor(def).int

proc attack*(u1: SCSUnit, u2: SCSUnit, fixedDamage: int = 0): bool =
  if u1.atk == 0:
    return false

  if rand(1.0) < u1.pConf.attack:
    var damage: float = 0
    if fixedDamage == 0:
      damage = round(u1.atk.float * 1.3 * pow(35.0/36.0, u2.def.float) * (rand(1.0)/4 + 7.0/8))
    else:
      damage = fixedDamage.float
    if damage < 1.0:
      u2.chp -= 1.0
    else:
      u2.chp -= damage
    return true
  else:
    return false

proc getExp*(f: Friend) =
  f.killCount += 1
  f.exp += 22

  while getBasicMonsterStatus(f.name, f.lv+1).exp < f.exp:
    let
      status0 = getBasicMonsterStatus(f.name, f.lv)
      status1 = getBasicMonsterStatus(f.name, f.lv+1)

    f.lv += 1
    f.setStatus()
    f.chp += status1.mhp0.float - status0.mhp0.float

proc naturalRecovery* (f: Friend) =
  f.chp += f.mhp.float / f.recovery.float
  if f.chp > f.mhp.float:
    f.chp = f.mhp.float

proc newFriend*(inp: JsonNode, order: int, place: Place, pConf: ProbabilityConfig): Friend =
  result = Friend(
    name: inp["name"].getStr(),
    lv: inp["lv"].getInt(),
    weakenAtk: getOrDefault(inp, "weakenAtk").getInt(0),
    weakenDef: getOrDefault(inp, "weakenDef").getInt(0),
    hpDope: getOrDefault(inp, "hpDope").getint(0),
    atkDope: getOrDefault(inp, "atkDope").getint(0),
    isSealed: getOrDefault(inp, "isSealed").getBool(false),
    isSticked: getOrDefault(inp, "isSticked").getBool(true) and inp["name"].getStr() == "ホイミスライム",
    doubleSpeed: getOrDefault(inp, "doubleSpeed").getBool(false),
    order: order,
    place: place,
    pConf: pConf,
    killCount: 0,
    divisionLossCount: 0,
    actionLossCount: 0,
  )
  result.setStatus()
  result.chp = result.mhp.float

proc newEnemy* (num: int, place: Place, pConf: ProbabilityConfig): Enemy =
  result = Enemy(
    name: "スモールグール",
    lv: 1,
    hpDope: 0,
    atkDope: 0,
    weakenAtk: 0,
    weakenDef: 0,
    isSealed: false,
    place: place,
    pConf: pConf,
    num: num
  )
  result.setStatus()
  result.chp = result.mhp.float
