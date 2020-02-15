# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import os
import scspkg/manager, scspkg/cli

proc main(fname: string) =
  let jsonStr = readFile(fname)
  let m = newManager(jsonStr)
  m.runAllTrialCli()

when isMainModule:
  if paramCount() == 1:
    let argv = commandLineParams()
    main(argv[0])
  else:
    echo "Usage: "
    echo "$ scs [json input file]"

