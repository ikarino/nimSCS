# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import scspkg/status
test "status":
  var km13 = getBasicMonsterStatus("キラーマシン", 13)
  check km13.mhp0 == 100
  check km13.atk0 == 37
  check km13.def0 == 60
  check km13.recovery == 100
  check km13.exp == 20000

  var sm1 = getBasicMonsterStatus("スモールグール", 1)
  check sm1.mhp0 == 55
  check sm1.atk0 == 17
  check sm1.def0 == 10
  check sm1.recovery == 50
  check sm1.exp == 0

  var hm30 = getBasicMonsterStatus("ホイミスライム", 30)
  check hm30.mhp0 == 105
  check hm30.atk0 == 71
  check hm30.def0 == 49
  check hm30.recovery == 50
  check hm30.exp == 42000

  check getLvByDexp("キラーマシン", 1, 10000) == 10
