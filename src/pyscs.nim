import nimpy

import scspkg/manager

proc trialOpt* (m: Manager): string =
  m.init()
  for turn in 1..m.config.turn:
    m.turn()
    for friend in m.friends:
      if friend.chp <= 0:
        return "killed"
    if m.enemys.len == 0:
      return "genocided"
    m.turnNow += 1
  return "success"

proc runAllTrialOpt(m: Manager): int =
  var exp: int = 0
  for trial in 1..m.config.trial:
    case m.trialOpt():
      of "success":
        exp += m.killCount*22
      of "killed":
        return 0
      of "genocided":
        return 0
  return exp


proc pyscs(jsonStr: string): int {.exportpy.} =
  let m = newManager(jsonStr)
  return m.runAllTrialOpt()
