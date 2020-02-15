# cli.nim
import terminal, strformat, math, json
import manager

proc displayProgress(now: int, max: int): void =
  let turnWidth = ($max).len * 2 + 1
  let barWidth = terminalWidth() - turnWidth - 6 - 2
  let rate = now.float/max.float
  let doneWidth = floor(barWidth.float * rate).int
  
  var barStr = ""
  for t in 0..doneWidth-1:
    barStr.add("▓")
  for t in doneWidth..barWidth-1:
    barStr.add("░")
  barStr.add($fmt" {rate*100:5.1f}%")
  barStr.add($fmt" {now}/{max}")

  stdout.eraseLine()
  setCursorXPos(0)
  stdout.write(barStr)
  stdout.flushFile()

proc runAllTrialCli* (m: Manager): void =
  stdout.hideCursor()
  let trials = m.config.trial
  displayProgress(0, trials)
  for trial in 1..trials:
    m.trial()
    displayProgress(trial, trials)
  echo m.summarizeOutput().pretty()
  stdout.showCursor()