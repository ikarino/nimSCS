# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import os, json, osproc
import scspkg/multi

proc scs(fname: string, cpu=0) =
  let jsonStr = readFile(fname)
  var cpus: int
  if cpu == 0:
    cpus = countProcessors()
  else:
    cpus = cpu
  runAllTrialMulti(jsonStr, cpus)

when isMainModule:
  import cligen
  dispatch(scs)
