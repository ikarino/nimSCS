import threadpool, json, cpuinfo, strformat
import sequtils, sugar, random
import manager, field, unit

proc childThread(jsonStr: string, trials: int): seq[JsonNode] =
  let m = newManager(jsonStr)
  for trial in 1..trials:
    m.init()
    for turn in 1..m.config.turn:
      # m.turnEnemy()
      for num in m.enemys.map(e => e.num):
        let enemy = m.getEnemyByNumber(num)
        let targets = m.field.findTargets(enemy.place)
        if targets.len > 0:
          let target = targets[rand(targets.len-1)]
          let friend = m.friends[target-10]
          let wasHit = enemy.attack(friend)

          if friend.name == "スモールグール" and not friend.isSealed and wasHit:
            discard m.divide(m.friends[target-10])
          continue

        let emptyPlaces = m.field.findVacants(enemy.place)
        if emptyPlaces.len > 0:
          let place = emptyPlaces[rand(emptyPlaces.len-1)]
          m.field.setField(enemy.place, 0)
          m.field.setField(place, enemy.num+20)
          enemy.place = place

      # m.turnFriend()
      for speed in [true, false]:
        for friend in m.friends:
          if speed or friend.doubleSpeed:
            let isActed = m.actionFriend(friend)
            if not isActed:
              friend.actionLossCount += 1
            friend.naturalRecovery()


      for friend in m.friends:
        if friend.chp <= 0:
          return
      if m.enemys.len == 0:
        return
      m.turnNow += 1
    m.saveOutput()
  return m.trialOutputs

proc runAllTrialMulti*(jsonStr: string, cpus: int): void =
  let j = parseJson(jsonStr)
  let trials = j["config"]["trial"].getInt()
  let trialsPerCPU = trials div cpus
  echo "multi thread mode"
  echo "========================"
  echo fmt"cpu num:      {cpus:8}"
  echo fmt"input trials :{trials:8}"
  echo fmt"trials/cpu:   {trialsPerCPU:8}"
  echo fmt"final trials: {cpus*trialsPerCPU:8}"

  var outputs = newSeq[FlowVar[seq[JsonNode]]](cpus)
  for cpu in 0..outputs.high:
    outputs[cpu] = spawn childThread(jsonStr, trialsPerCPU)
  sync()

  let m = newManager(jsonStr)
  for cpu in 0..outputs.high:
    m.trialOutputs = concat(m.trialOutputs, ^outputs[cpu])

  echo m.summarizeOutput().pretty()
