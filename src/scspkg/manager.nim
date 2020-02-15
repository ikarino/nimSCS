# manager.nim
import json, random, sugar, sequtils
import custom_types, unit, field, mathFunctions

type
  Config = object
    turn: int
    trial*: int
    pConf: ProbabilityConfig
  Manager* = ref object
    j: JsonNode
    config*: Config
    friends: seq[Friend]
    enemys: seq[Enemy]
    field: SCSField
    killCount: int
    turnNow: int
    trialOutputs: seq[JsonNode]

## forward declarations
proc init(m: Manager)
proc trial*(m: Manager)
proc turn(m: Manager)
proc turnFriend(m: Manager)
proc turnEnemy(m: Manager)
proc actionFriend(m: Manager, f: Friend): bool
proc divide(m: Manager, sumo: SCSUnit): bool

## ----------------------------------------------------------------------------
## constructors
proc newManager* (jsonStr: string): Manager =
  let j = parseJson(jsonStr)

  for topKey in ["friends", "field", "config"]:
    if not j.hasKey(topKey):
      raise newException(SCSError, "key not specified")

  let pConf = defaultProbabilityConfig() # TODO marshalで実装。JsonObj => string => marshal
  let config = Config(
    turn: j["config"]["turn"].getInt(),
    trial: j["config"]["trial"].getInt(),
    pConf: pConf
  )
  result = Manager(
    config: config,
    j: j
  )

## ----------------------------------------------------------------------------
## outputs
proc saveOutput(m: Manager) =
  var finishState = "success"
  if m.turnNow < m.config.turn:
    if m.enemys.len == 0:
      finishState = "genocided"
    else:
      finishState = "killed"

  let output = %* {
    "result": {
      "finishState": finishState,
      "turnPassed": m.turnNow,
      "orderOfKilledFriends": m.friends.filter(f => f.chp <= 0).map(f => f.order)
    },
    "exp": {
      "total": m.killCount*22,
      "perTurn": m.killCount*22/m.turnNow,
      "perMonster": m.friends.map(f => f.killCount*22),
      "perMonsterPerTurn": m.friends.map(f => f.killCount*22/m.turnNow)
    },
    "loss": {
      "action": m.friends.map(f => f.actionLossCount),
      "division": m.friends.map(f => f.divisionLossCount)
    }
  }
  m.trialOutputs.add(output)

proc summarizeOutput* (m: Manager): JsonNode =
  var countOfKilledFriends = toSeq(1..m.friends.len).map(x => 0)
  for output in m.trialOutputs:
    for order in output["result"]["orderOfKilledFriends"].getElems().map(jo => jo.getInt()):
      countOfKilledFriends[order] += 1
  %* {
    "result": {
      "finishState": {
        "success": m.trialOutputs.filter(o => o["result"]["finishState"].getStr() == "success").len,
        "killed": m.trialOutputs.filter(o => o["result"]["finishState"].getStr() == "killed").len,
        "genocided": m.trialOutputs.filter(o => o["result"]["finishState"].getStr() == "genocided").len,
      },
      "turnPassed": {
        "mean": m.trialOutputs.map(o => o["result"]["turnPassed"].getInt()).mean(),
        "mean": m.trialOutputs.map(o => o["result"]["turnPassed"].getInt()).std()
      },
    },
    "exp": {
      "total": {
        "mean": m.trialOutputs.map(o => o["exp"]["total"].getInt()).mean(),
        "std": m.trialOutputs.map(o => o["exp"]["total"].getInt()).std(),
      },
      "perMonster": m.trialOutputs.map(o => o["exp"]["perMonster"].getElems().map(jo => jo.getInt())).getMeanAndStdFromArray()
    },
    "loss": {
      "action": m.trialOutputs.map(o => o["loss"]["action"].getElems().map(jo => jo.getInt())).getMeanAndStdFromArray(),
      "division": m.trialOutputs.map(o => o["loss"]["division"].getElems().map(jo => jo.getInt())).getMeanAndStdFromArray()
    }
  }

## ----------------------------------------------------------------------------
## main routine
##  └── runAllTrial
##      ├── init
##      └── trial
##          └── turn
##              ├── turnEnemy
##              └── turnFriend
proc runAllTrial* (m: Manager): void =
  for trial in 1..m.config.trial:
    m.trial()
  echo m.summarizeOutput()

proc trial* (m: Manager): void =
  m.init()
  for turn in 1..m.config.turn:
    m.turn()
    for friend in m.friends:
      if friend.chp <= 0:
        return
    if m.enemys.len == 0:
      return
    m.turnNow += 1
  m.saveOutput()

proc init(m: Manager) =
  # [field]
  let field = newField(m.j["field"])

  # [friends]
  var friends: seq[Friend]
  var order = 0
  for f in m.j["friends"]:
    friends.add(newFriend(f, order, field.findFriend(order+10), m.config.pConf))
    order += 1
  
  # [enemy]
  m.killCount = 0
  var enemys: seq[Enemy]
  for place in field.findEnemys():
    enemys.add(newEnemy(m.killCount+20, place, m.config.pConf))
    field.setField(place, m.killCount+20)
    m.killCount += 1
  
  m.friends = friends
  m.enemys = enemys
  m.field = field
  m.turnNow = 0

proc turn(m: Manager): void =
  m.turnEnemy()
  m.turnFriend()
  
proc turnFriend(m: Manager): void =
  for speed in [true, false]:
    for friend in m.friends:
      if speed or friend.doubleSpeed:
        let isActed = m.actionFriend(friend)
        if not isActed:
          friend.actionLossCount += 1
        friend.naturalRecovery()
  
proc turnEnemy(m: Manager): void =
  for enemy in m.enemys:
    # 1. 攻撃を試みる
    let targets = m.field.findTargets(enemy.place)
    if targets.len > 0:
      let target = targets[rand(targets.len-1)]
      let friend = m.friends[target-10]
      let wasHit = enemy.attack(friend)

      # 対象がスモールグールだった場合は分裂処理
      if friend.name == "スモールグール" and not friend.isSealed and wasHit:
        discard m.divide(m.friends[target-10])
      # 攻撃したら終了
      continue 
  
    # 2. 移動を試みる
    let emptyPlaces = m.field.findVacants(enemy.place)
    if emptyPlaces.len > 0:
      let place = emptyPlaces[rand(emptyPlaces.len-1)]
      m.field.setField(enemy.place, 0)
      m.field.setField(place, enemy.num+20)
      enemy.place = place
    
## ----------------------------------------------------------------------------
## small utilities
proc addEnemy(m: Manager, place: Place) =
  if rand(1.0) < m.config.pConf.divide:
    m.enemys.add(newEnemy(m.killCount+20, place, m.config.pConf))
    m.field.setField(place, m.killCount+20)
    m.killCount += 1

proc removeEnemy(m: Manager, enemy: Enemy) =
  m.field.setField(enemy.place, 0)
  m.enemys = m.enemys.filter(e => e.num != enemy.num)

proc divide(m: Manager, sumo: SCSUnit): bool =
  let dplaceList = [
      Place(row: -1, col: 0),  # 0: 上
      Place(row: -1, col: -1), # 1: 左上
      Place(row: 0, col: -1),  # 2: 左
      Place(row: 1, col: -1),  # 3: 左下
      Place(row: 1, col: 0),   # 4: 下
      Place(row: 1, col: 1),   # 5: 右下
      Place(row: 0, col: 1),   # 6: 右
      Place(row: -1,col: 1),   # 7: 右上
  ]
  let initialIndex = rand(3)*2  # 0, 2, 4, 6 = 上, 左, 下, 右
  for relativeIndex in 0..7:
    var index = relativeIndex + initialIndex
    if index > 7:
      index -= 8

    let place = addPlace(sumo.place, dplaceList[index])
    if m.field.getField(place) == 0:
      m.addEnemy(place)
      return true
  return false

proc getEnemyByNumber(m: Manager, num: int): Enemy =
  return m.enemys.filter(e => e.num == num)[0]

## ----------------------------------------------------------------------------
## freind actions
proc attack(m: Manager, friend: Friend, enemy: Enemy, fixedDamage: int = 0): string =
  let wasHit = friend.attack(enemy, fixedDamage)
  if enemy.chp <= 0:
    # 攻撃後に倒れた場合
    friend.getExp()
    m.removeEnemy(enemy)
    return "killed"
  elif wasHit:
    # 攻撃後に生き残った場合（分裂処理）
    let wasAbleToDivide = m.divide(enemy)
    if not wasAbleToDivide:
      friend.divisionLossCount += 1
    return "survived"
  return "missed"

proc actionKillerMachine(m: Manager, f: Friend): bool =
  let targets = m.field.findTargets(f.place)
  if targets.len > 0:
    let target = targets[rand(targets.len-1)]
    let enemy = m.getEnemyByNumber(target)

    let r = m.attack(f, enemy)     # 攻撃1回目
    if r == "killed": return true  # 一回目で倒したら終了
    discard m.attack(f, enemy)     # 攻撃2回目
    return true
  return false

proc actionHoimiSlime(m: Manager, f: Friend): bool =
  var returnValue = false
  # 1.
  var hoimiTargets: seq[SCSUnit]
  for drow in [-1, 0, 1]:
    for dcol in [-1, 0, 1]:
      let place = addPlace(f.place, Place(row: drow, col: dcol))
      let number = m.field.getField(place)
      if drow == 0 and dcol == 0:
        continue
      if 10 <= number and number <= 19:
        let unit = m.friends[number-10]
        if unit.chp < unit.mhp.float:
          hoimiTargets.add(unit)
      elif number >= 20:
        let unit = m.getEnemyByNumber(number)
        if unit.chp < unit.mhp.float:
          hoimiTargets.add(unit)
  returnValue = returnValue or hoimiTargets.len > 0

  # 2.
  var execSkill = false
  for t in 1..hoimiTargets.len:
    if rand(1.0) < m.config.pConf.hoimin.skill:
      execSkill = true
      break
  if execSkill:
    for target in hoimiTargets:
      target.chp += 25
      if target.chp > target.mhp.float:
        target.chp = target.mhp.float
    return returnValue

  # 3.
  let attackTargets = m.field.findTargets(f.place)
  returnValue = returnValue or attackTargets.len > 0

  # 4.
  for enemyId in attackTargets:
    if rand(1.0) < m.config.pConf.hoimin.attack:
      let enemy = m.getEnemyByNumber(enemyId)
      discard m.attack(f, enemy)
      return returnValue

  # 5.
  let vacantTargets = m.field.findVacants(f.place)
  returnValue = returnValue or vacantTargets.len > 0
  if not f.isSticked and rand(1.0) < m.config.pConf.hoimin.move and m.turnNow > m.config.pConf.hoimin.moveTurn and vacantTargets.len > 0:
    let newPlace = vacantTargets[rand(vacantTargets.len-1)]
    m.field.setField(f.place, 0)
    m.field.setField(newPlace, 10 + f.order)
    f.place = newPlace
    return returnValue
  return returnValue

proc actionNormal(m: Manager, f: Friend): bool =
  let targets = m.field.findTargets(f.place)
  if targets.len > 0:
    let target = targets[rand(targets.len-1)]
    let enemy = m.getEnemyByNumber(target - 20)
    discard m.attack(f, enemy)
    return true
  return false

proc actionFriend(m: Manager, f: Friend): bool =
  if f.isSealed:
    return m.actionNormal(f)
  elif f.name == "キラーマシン" or f.name == "さそりかまきり":
    return m.actionKillerMachine(f)
  elif f.name == "ホイミスライム":
    return m.actionHoimiSlime(f)
  else:
    return m.actionNormal(f)

