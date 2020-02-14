# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import json
import marshal

import scspkg/custom_types
import scspkg/manager

when isMainModule:
  let jsonStr = readFile("inputs/sample.json")
  let m = newManager(jsonStr)

  m.runAllTrial()
