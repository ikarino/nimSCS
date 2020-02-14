# status.nim
#

import custom_types

type GrowType {.pure.} = enum
  FutsuSojuku
  KogekiSojuku
  BougyoSojuku
  BannoBansei
  KogekiBansei
  BougyoBansei
  KogekiTokusyu
  SyubiTokusyu

type BasicMonsterStatus* = object
  name*: string
  growType*: GrowType
  mhp0*, atk0*, def0*, exp*, maximumLv*, recovery*: int

proc getEXP(g: GrowType, lv: int): int =
  case g:
    of GrowType.FutsuSojuku:
      return [0, 3, 10, 30, 50, 100, 150, 200, 300, 500, 800, 1000, 1200, 1500, 1800, 2000, 2500, 3000, 4000, 5000, 6500, 8000, 10000, 13000, 16000, 20000, 25000, 30000, 36000, 42000, 48000, 54000, 60000, 70000, 80000, 90000, 100000, 115000, 130000, 145000, 160000, 175000, 200000, 230000, 260000, 290000, 320000, 350000, 380000, 410000, 440000, 470000, 500000, 530000, 560000, 590000, 620000, 650000, 680000, 710000, 750000, 790000, 830000, 870000, 910000, 950000, 990000, 1030000, 1070000, 1120000, 1170000, 1220000, 1270000, 1320000, 1370000, 1420000, 1470000, 1520000, 1570000, 1620000, 1670000, 1720000, 1770000, 1820000, 1880000, 1940000, 2000000, 2060000, 2120000, 2180000, 2240000, 2300000, 2360000, 2420000, 3000000, 5000000, 7000000, 9000000, 9990000][lv-1];
    of GrowType.KogekiSojuku:
      return [0, 10, 30, 60, 120, 160, 300, 500, 750, 1000, 1250, 1600, 2000, 2600, 3200, 4000, 5000, 6500, 8000, 9500, 11000, 13000, 16000, 19000, 22000, 25000, 28000, 31000, 36000, 42000, 48000, 54000, 60000, 70000, 80000, 90000, 100000, 115000, 130000, 145000, 160000, 175000, 200000, 230000, 260000, 290000, 320000, 350000, 380000, 410000, 440000, 470000, 500000, 530000, 560000, 590000, 620000, 650000, 680000, 710000, 750000, 790000, 830000, 870000, 910000, 950000, 990000, 1030000, 1070000, 1120000, 1170000, 1220000, 1270000, 1320000, 1370000, 1420000, 1470000, 1520000, 1570000, 1620000, 1670000, 1720000, 1770000, 1820000, 1880000, 1940000, 2000000, 2060000, 2120000, 2180000, 2240000, 2300000, 2360000, 2420000, 3000000, 5000000, 7000000, 9000000, 9990000][lv-1];
    of GrowType.BougyoSojuku:
      return [0, 35, 100, 300, 600, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 6000, 7000, 8000, 9000, 10000, 11000, 13000, 15000, 17000, 20000, 23000, 26000, 30000, 35000, 40000, 45000, 50000, 55000, 60000, 70000, 80000, 90000, 100000, 115000, 130000, 145000, 160000, 175000, 200000, 230000, 260000, 290000, 320000, 350000, 380000, 410000, 440000, 470000, 500000, 530000, 560000, 590000, 620000, 650000, 680000, 710000, 750000, 790000, 830000, 870000, 910000, 950000, 990000, 1030000, 1070000, 1120000, 1170000, 1220000, 1270000, 1320000, 1370000, 1420000, 1470000, 1520000, 1570000, 1620000, 1670000, 1720000, 1770000, 1820000, 1880000, 1940000, 2000000, 2060000, 2120000, 2180000, 2240000, 2300000, 2360000, 2420000, 3000000, 5000000, 7000000, 9000000, 9990000][lv-1];
    of GrowType.BannoBansei:
      return [0, 150, 500, 1300, 2500, 4000, 8000, 16000, 20000, 30000, 40000, 60000, 80000, 100000, 130000, 160000, 190000, 220000, 250000, 280000, 310000, 340000, 370000, 400000, 440000, 480000, 520000, 560000, 600000, 640000, 680000, 720000, 760000, 800000, 840000, 880000, 920000, 960000, 1000000, 1040000, 1090000, 1140000, 1190000, 1240000, 1290000, 1340000, 1390000, 1440000, 1490000, 1540000, 1590000, 1640000, 1690000, 1740000, 1790000, 1840000, 1890000, 1940000, 1990000, 2040000, 2090000, 2140000, 2190000, 2240000, 2290000, 2340000, 2390000, 2440000, 2490000, 2540000, 2590000, 2640000, 2690000, 2740000, 2790000, 2840000, 2890000, 2940000, 2990000, 3040000, 3100000, 3160000, 3220000, 3400000, 3600000, 3800000, 4000000, 4200000, 4400000, 4600000, 4800000, 5000000, 5500000, 6000000, 6500000, 7000000, 8000000, 9000000, 9990000][lv-1];
    of GrowType.KogekiBansei:
      return [0, 45, 200, 600, 1000, 1600, 2500, 3500, 4500, 5500, 7000, 8500, 10000, 20000, 30000, 50000, 70000, 90000, 110000, 130000, 150000, 170000, 190000, 210000, 230000, 240000, 250000, 260000, 270000, 280000, 290000, 300000, 310000, 320000, 330000, 340000, 350000, 360000, 370000, 380000, 390000, 400000, 410000, 420000, 430000, 440000, 450000, 460000, 470000, 480000, 490000, 500000, 510000, 520000, 530000, 540000, 550000, 560000, 570000, 580000, 630000, 680000, 730000, 780000, 830000, 880000, 930000, 980000, 1030000, 1090000, 1150000, 1210000, 1270000, 1330000, 1390000, 1450000, 1510000, 1570000, 1630000, 1690000, 1750000, 1810000, 1870000, 1930000, 1990000, 2050000, 2110000, 2170000, 2230000, 2310000, 2390000, 2470000, 2550000, 2630000, 3000000, 5000000, 7000000, 9000000, 9990000][lv-1];
    of GrowType.BougyoBansei:
      return [0, 55, 300, 900, 1300, 2000, 3500, 5000, 7500, 10000, 12500, 15500, 20000, 30000, 40000, 50000, 70000, 90000, 110000, 130000, 150000, 170000, 190000, 210000, 230000, 240000, 250000, 260000, 270000, 280000, 290000, 300000, 310000, 320000, 330000, 340000, 350000, 360000, 370000, 380000, 390000, 400000, 410000, 420000, 430000, 440000, 450000, 460000, 470000, 480000, 490000, 500000, 510000, 520000, 530000, 540000, 550000, 560000, 570000, 580000, 630000, 680000, 730000, 780000, 830000, 880000, 930000, 980000, 1030000, 1090000, 1150000, 1210000, 1270000, 1330000, 1390000, 1450000, 1510000, 1570000, 1630000, 1690000, 1750000, 1810000, 1870000, 1930000, 1990000, 2050000, 2110000, 2170000, 2230000, 2310000, 2390000, 2470000, 2550000, 2630000, 3000000, 5000000, 7000000, 9000000, 9990000][lv-1];
    of GrowType.KogekiTokusyu:
      return [0, 100000, 200000, 300000, 400000, 500000, 600000, 700000, 800000, 900000, 1000000, 1100000, 1200000, 1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000, 2200000, 2300000, 2400000, 2500000, 2600000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000, 3400000, 3500000, 3600000, 3700000, 3800000, 3900000, 4000000, 4100000, 4200000, 4300000, 4400000, 4500000, 4600000, 4700000, 4800000, 4900000, 5000000, 5100000, 5200000, 5300000, 5400000, 5500000, 5600000, 5700000, 5800000, 5900000, 6000000, 6100000, 6200000, 6300000, 6400000, 6500000, 6600000, 6700000, 6800000, 6900000, 7000000, 7100000, 7200000, 7300000, 7400000, 7500000, 7600000, 7700000, 7800000, 7900000, 8000000, 8100000, 8200000, 8300000, 8400000, 8500000, 8600000, 8700000, 8800000, 8900000, 9000000, 9100000, 9200000, 9300000, 9400000, 9500000, 9600000, 9700000, 9990000][lv-1];
    of GrowType.SyubiTokusyu:
      return [0, 100, 350, 900, 1300, 2000, 3500, 5000, 7500, 10000, 12500, 15500, 20000, 30000, 40000, 50000, 70000, 90000, 110000, 130000, 150000, 170000, 190000, 210000, 230000, 270000, 300000, 330000, 360000, 380000, 390000, 420000, 470000, 520000, 570000, 620000, 670000, 720000, 770000, 820000, 870000, 920000, 970000, 1020000, 1070000, 1120000, 1170000, 1220000, 1270000, 1320000, 1380000, 1440000, 1500000, 1560000, 1620000, 1680000, 1740000, 1800000, 1860000, 1920000, 1980000, 2040000, 2100000, 2160000, 2220000, 2280000, 2340000, 2400000, 2460000, 2520000, 2580000, 2640000, 2700000, 2760000, 2820000, 2880000, 2940000, 3000000, 3060000, 3120000, 3180000, 3250000, 3320000, 3390000, 3460000, 3530000, 3600000, 3670000, 3740000, 3810000, 3880000, 3950000, 4020000, 4090000, 4160000, 5000000, 7000000, 9000000, 9990000][lv-1];

proc getMHPGrow(g: GrowType, lv: int): int =
  case g:
    of GrowType.FutsuSojuku:
      return [0, 8, 15, 21, 26, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 59, 61, 63, 65, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146][lv-1];
    of GrowType.KogekiSojuku:
      return [0, 3, 6, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 47, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67][lv-1];
    of GrowType.BougyoSojuku:
      return [0, 4, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35, 38, 41, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 60, 61, 61, 62, 62, 63, 63, 64, 64, 65, 65, 66, 66, 67, 67, 68, 68, 69, 69, 70, 70, 71, 71, 72, 72, 73, 73, 74, 74, 75, 75, 76, 76, 77, 77, 78, 78, 79, 79, 80, 80, 81, 81, 82, 82, 83, 83, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84, 84][lv-1];
    of GrowType.BannoBansei:
      return [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 93, 96, 99, 102, 105, 108, 111, 114, 117, 120, 122, 124, 126, 128, 130, 132, 134, 136, 138, 140, 142, 144, 146, 148, 150, 152, 154, 156, 158, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210][lv-1];
    of GrowType.KogekiBansei:
      return [0, 3, 6, 9, 12, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132][lv-1];
    of GrowType.BougyoBansei:
      return [0, 8, 15, 21, 26, 30, 33, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86, 86][lv-1];
    of GrowType.KogekiTokusyu:
      return [0, 10, 15, 20, 25, 30, 35, 40, 45, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55][lv-1];
    of GrowType.SyubiTokusyu:
      return [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0][lv-1];

proc getATKGrow(g: GrowType, lv: int): int =
  case g:
    of GrowType.FutsuSojuku:
      return [0, 9, 14, 18, 21, 24, 27, 30, 33, 36, 38, 40, 42, 44, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 71, 71, 72, 72, 73, 73, 74, 74, 75, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76][lv-1];
    of GrowType.KogekiSojuku:
      return [0, 2, 4, 6, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131][lv-1];
    of GrowType.BougyoSojuku:
      return [0, 5, 10, 14, 17, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 39, 39, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40][lv-1];
    of GrowType.BannoBansei:
      return [0, 10, 16, 21, 26, 31, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 107, 108, 108, 109, 109, 110, 110, 111, 111, 112, 112, 113, 113, 114, 114, 115, 115, 116, 116, 117, 117, 118, 118, 119, 119, 120, 120, 121, 121, 122, 122, 123, 123, 124, 124, 125, 125, 126, 126, 127, 127, 128, 128, 129, 129, 130, 130, 131, 131, 132, 132, 133, 133, 134, 134, 135, 135, 136][lv-1];
    of GrowType.KogekiBansei:
      return [0, 5, 9, 12, 14, 16, 18, 20, 22, 23, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 43, 43, 44, 44, 45, 45, 46, 46, 47, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122, 124, 126, 128, 130, 132, 134, 136, 138, 140, 142, 144, 146, 148, 150, 152, 154, 156, 158, 160, 162, 164, 166, 168, 170, 172, 174, 176][lv-1];
    of GrowType.BougyoBansei:
      return [0, 2, 4, 6, 8, 10, 12, 14, 15, 16, 16, 17, 17, 18, 18, 19, 19, 20, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25, 25, 26, 26, 27, 27, 28, 28, 29, 29, 30, 30, 31, 31, 32, 32, 33, 33, 34, 34, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35][lv-1];
    of GrowType.KogekiTokusyu:
      return [0, 70, 140, 200, 260, 310, 360, 410, 460, 510, 515, 519, 522, 524, 526, 528, 530, 532, 534, 536, 538, 540, 542, 544, 546, 548, 550, 552, 554, 556, 558, 560, 562, 564, 566, 568, 570, 572, 574, 576, 578, 580, 582, 584, 586, 588, 590, 592, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644][lv-1];
    of GrowType.SyubiTokusyu:
      return [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0][lv-1];

proc getDEFGrow(g: GrowType, lv: int): int =
  case g:
    of GrowType.FutsuSojuku:
      return [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40][lv-1];
    of GrowType.KogekiSojuku:
      return [0, 2, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33][lv-1];
    of GrowType.BougyoSojuku:
      return [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 55, 56, 57, 57, 58, 58, 59, 59, 60, 60, 61, 61, 62, 62, 63, 63, 64, 64, 65, 65, 66, 66, 67, 67, 68, 68, 69, 69, 70, 70, 71, 71, 72, 72, 73, 73, 74, 74, 75, 75, 76, 76, 77, 77, 78, 78, 79, 79, 80, 80, 81, 81, 82, 82, 83, 83, 84, 84, 85, 85, 86, 86, 87, 87, 88, 88, 89, 89, 90, 90, 91][lv-1];
    of GrowType.BannoBansei:
      return [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107][lv-1];
    of GrowType.KogekiBansei:
      return [0, 1, 2, 3, 4, 5, 6, 9, 12, 15, 18, 21, 24, 25, 26, 27, 28, 29, 30, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31][lv-1];
    of GrowType.BougyoBansei:
      return [0, 6, 11, 15, 18, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 90, 92, 94, 96, 98, 100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122, 124, 126, 127, 129, 130, 132, 133, 135, 136, 138, 139, 141, 142, 144, 145, 147, 148, 150, 151, 153, 154, 158][lv-1];
    of GrowType.KogekiTokusyu:
      return [0, 30, 35, 40, 45, 50, 55, 60, 65, 70, 74, 77, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165][lv-1];
    of GrowType.SyubiTokusyu:
      return [0, 3, 6, 9, 12, 15, 18, 21, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122, 124, 126, 128, 130, 132, 134, 136, 138, 140, 142, 144, 146, 148, 150, 152, 154, 156, 158, 160, 162, 164, 166, 168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 196, 198, 200, 202, 204][lv-1];

proc getBasicMonsterStatus* (name: string, lv: int): BasicMonsterStatus =
  if lv < 1 or lv > 99:
    raise newException(SCSError, "invalid lv given.")

  var bms: BasicMonsterStatus

  case name:
    of "いたずらもぐら":
      bms = BasicMonsterStatus(name: "いたずらもぐら", growType: GrowType.FutsuSojuku, mhp0: 8, atk0: 6, def0: 5, maximumLv: 5, exp: 0, recovery: 50)
    of "がいこつけんし":
      bms = BasicMonsterStatus(name: "がいこつけんし", growType: GrowType.FutsuSojuku, mhp0: 35, atk0: 20, def0: 10, maximumLv: 9, exp: 0, recovery: 50)
    of "かげのきし":
      bms = BasicMonsterStatus(name: "かげのきし", growType: GrowType.FutsuSojuku, mhp0: 85, atk0: 30, def0: 29, maximumLv: 9, exp: 0, recovery: 50)
    of "キラースター":
      bms = BasicMonsterStatus(name: "キラースター", growType: GrowType.FutsuSojuku, mhp0: 62, atk0: 19, def0: 18, maximumLv: 99, exp: 0, recovery: 100)
    of "グール":
      bms = BasicMonsterStatus(name: "グール", growType: GrowType.FutsuSojuku, mhp0: 50, atk0: 21, def0: 20, maximumLv: 9, exp: 0, recovery: 50)
    of "くさった死体":
      bms = BasicMonsterStatus(name: "くさった死体", growType: GrowType.FutsuSojuku, mhp0: 45, atk0: 15, def0: 15, maximumLv: 9, exp: 0, recovery: 50)
    of "しりょうのきし":
      bms = BasicMonsterStatus(name: "しりょうのきし", growType: GrowType.FutsuSojuku, mhp0: 70, atk0: 35, def0: 35, maximumLv: 9, exp: 0, recovery: 50)
    of "スライム":
      bms = BasicMonsterStatus(name: "スライム", growType: GrowType.FutsuSojuku, mhp0: 5, atk0: 2, def0: 2, maximumLv: 99, exp: 0, recovery: 50)
    of "スライムベス":
      bms = BasicMonsterStatus(name: "スライムベス", growType: GrowType.FutsuSojuku, mhp0: 6, atk0: 3, def0: 3, maximumLv: 99, exp: 0, recovery: 50)
    of "スライムベホマズン":
      bms = BasicMonsterStatus(name: "スライムベホマズン", growType: GrowType.FutsuSojuku, mhp0: 100, atk0: 50, def0: 50, maximumLv: 9, exp: 0, recovery: 100)
    of "タホドラキー":
      bms = BasicMonsterStatus(name: "タホドラキー", growType: GrowType.FutsuSojuku, mhp0: 35, atk0: 16, def0: 15, maximumLv: 3, exp: 0, recovery: 50)
    of "デビルアンカー":
      bms = BasicMonsterStatus(name: "デビルアンカー", growType: GrowType.FutsuSojuku, mhp0: 45, atk0: 16, def0: 11, maximumLv: 99, exp: 0, recovery: 100)
    of "どくどくゾンビ":
      bms = BasicMonsterStatus(name: "どくどくゾンビ", growType: GrowType.FutsuSojuku, mhp0: 100, atk0: 45, def0: 35, maximumLv: 9, exp: 0, recovery: 50)
    of "ドラキー":
      bms = BasicMonsterStatus(name: "ドラキー", growType: GrowType.FutsuSojuku, mhp0: 7, atk0: 5, def0: 2, maximumLv: 99, exp: 0, recovery: 50)
    of "ドラキーマ":
      bms = BasicMonsterStatus(name: "ドラキーマ", growType: GrowType.FutsuSojuku, mhp0: 42, atk0: 20, def0: 14, maximumLv: 99, exp: 0, recovery: 100)
    of "ハエまどう":
      bms = BasicMonsterStatus(name: "ハエまどう", growType: GrowType.FutsuSojuku, mhp0: 50, atk0: 16, def0: 24, maximumLv: 99, exp: 0, recovery: 50)
    of "ファイヤーケロッグ":
      bms = BasicMonsterStatus(name: "ファイヤーケロッグ", growType: GrowType.FutsuSojuku, mhp0: 40, atk0: 11, def0: 10, maximumLv: 9, exp: 0, recovery: 50)
    of "ブラウニー":
      bms = BasicMonsterStatus(name: "ブラウニー", growType: GrowType.FutsuSojuku, mhp0: 25, atk0: 14, def0: 17, maximumLv: 99, exp: 0, recovery: 50)
    of "プラチナキング":
      bms = BasicMonsterStatus(name: "プラチナキング", growType: GrowType.FutsuSojuku, mhp0: 134, atk0: 52, def0: 52, maximumLv: 99, exp: 0, recovery: 100)
    of "ホイミスライム":
      bms = BasicMonsterStatus(name: "ホイミスライム", growType: GrowType.FutsuSojuku, mhp0: 28, atk0: 10, def0: 9, maximumLv: 99, exp: 0, recovery: 50)
    of "メイジももんじゃ":
      bms = BasicMonsterStatus(name: "メイジももんじゃ", growType: GrowType.FutsuSojuku, mhp0: 45, atk0: 19, def0: 19, maximumLv: 99, exp: 0, recovery: 50)
    of "ももんじゃ":
      bms = BasicMonsterStatus(name: "ももんじゃ", growType: GrowType.FutsuSojuku, mhp0: 12, atk0: 7, def0: 5, maximumLv: 99, exp: 0, recovery: 50)
    of "リビングデッド":
      bms = BasicMonsterStatus(name: "リビングデッド", growType: GrowType.FutsuSojuku, mhp0: 50, atk0: 15, def0: 16, maximumLv: 9, exp: 0, recovery: 50)
    of "リビングハンマー":
      bms = BasicMonsterStatus(name: "リビングハンマー", growType: GrowType.FutsuSojuku, mhp0: 90, atk0: 44, def0: 30, maximumLv: 99, exp: 0, recovery: 100)
    of "エリミネーター":
      bms = BasicMonsterStatus(name: "エリミネーター", growType: GrowType.KogekiSojuku, mhp0: 100, atk0: 30, def0: 35, maximumLv: 99, exp: 0, recovery: 100)
    of "キメラ":
      bms = BasicMonsterStatus(name: "キメラ", growType: GrowType.KogekiSojuku, mhp0: 48, atk0: 30, def0: 20, maximumLv: 99, exp: 0, recovery: 30)
    of "さつじんき":
      bms = BasicMonsterStatus(name: "さつじんき", growType: GrowType.KogekiSojuku, mhp0: 48, atk0: 16, def0: 18, maximumLv: 99, exp: 0, recovery: 50)
    of "しにがみ":
      bms = BasicMonsterStatus(name: "しにがみ", growType: GrowType.KogekiSojuku, mhp0: 35, atk0: 15, def0: 13, maximumLv: 99, exp: 0, recovery: 50)
    of "スターキメラ":
      bms = BasicMonsterStatus(name: "スターキメラ", growType: GrowType.KogekiSojuku, mhp0: 78, atk0: 32, def0: 31, maximumLv: 99, exp: 0, recovery: 30)
    of "スモールグール":
      bms = BasicMonsterStatus(name: "スモールグール", growType: GrowType.KogekiSojuku, mhp0: 55, atk0: 17, def0: 10, maximumLv: 99, exp: 0, recovery: 50)
    of "デスストーカー":
      bms = BasicMonsterStatus(name: "デスストーカー", growType: GrowType.KogekiSojuku, mhp0: 150, atk0: 45, def0: 45, maximumLv: 99, exp: 0, recovery: 100)
    of "トロル":
      bms = BasicMonsterStatus(name: "トロル", growType: GrowType.KogekiSojuku, mhp0: 50, atk0: 23, def0: 23, maximumLv: 99, exp: 0, recovery: 100)
    of "トロルボンバー":
      bms = BasicMonsterStatus(name: "トロルボンバー", growType: GrowType.KogekiSojuku, mhp0: 60, atk0: 31, def0: 27, maximumLv: 99, exp: 0, recovery: 100)
    of "ベロベロ":
      bms = BasicMonsterStatus(name: "ベロベロ", growType: GrowType.KogekiSojuku, mhp0: 80, atk0: 45, def0: 30, maximumLv: 99, exp: 0, recovery: 50)
    of "マミー":
      bms = BasicMonsterStatus(name: "マミー", growType: GrowType.KogekiSojuku, mhp0: 40, atk0: 25, def0: 13, maximumLv: 99, exp: 0, recovery: 50)
    of "ミイラおとこ":
      bms = BasicMonsterStatus(name: "ミイラおとこ", growType: GrowType.KogekiSojuku, mhp0: 42, atk0: 21, def0: 13, maximumLv: 99, exp: 0, recovery: 50)
    of "ゆうれい":
      bms = BasicMonsterStatus(name: "ゆうれい", growType: GrowType.KogekiSojuku, mhp0: 23, atk0: 18, def0: 5, maximumLv: 99, exp: 0, recovery: 50)
    of "アイアンタートル":
      bms = BasicMonsterStatus(name: "アイアンタートル", growType: GrowType.BougyoSojuku, mhp0: 30, atk0: 18, def0: 19, maximumLv: 99, exp: 0, recovery: 50)
    of "あめふらし":
      bms = BasicMonsterStatus(name: "あめふらし", growType: GrowType.BougyoSojuku, mhp0: 31, atk0: 19, def0: 14, maximumLv: 99, exp: 0, recovery: 50)
    of "アローインプ":
      bms = BasicMonsterStatus(name: "アローインプ", growType: GrowType.BougyoSojuku, mhp0: 41, atk0: 11, def0: 14, maximumLv: 99, exp: 0, recovery: 50)
    of "あんこくつむり":
      bms = BasicMonsterStatus(name: "あんこくつむり", growType: GrowType.BougyoSojuku, mhp0: 30, atk0: 20, def0: 19, maximumLv: 99, exp: 0, recovery: 50)
    of "岩とびあくま":
      bms = BasicMonsterStatus(name: "岩とびあくま", growType: GrowType.BougyoSojuku, mhp0: 32, atk0: 15, def0: 18, maximumLv: 99, exp: 0, recovery: 50)
    of "エビルポット":
      bms = BasicMonsterStatus(name: "エビルポット", growType: GrowType.BougyoSojuku, mhp0: 26, atk0: 8, def0: 11, maximumLv: 99, exp: 0, recovery: 50)
    of "おおナメクジ":
      bms = BasicMonsterStatus(name: "おおナメクジ", growType: GrowType.BougyoSojuku, mhp0: 17, atk0: 8, def0: 7, maximumLv: 99, exp: 0, recovery: 50)
    of "おどる宝石":
      bms = BasicMonsterStatus(name: "おどる宝石", growType: GrowType.BougyoSojuku, mhp0: 36, atk0: 10, def0: 8, maximumLv: 99, exp: 0, recovery: 50)
    of "ガニラス":
      bms = BasicMonsterStatus(name: "ガニラス", growType: GrowType.BougyoSojuku, mhp0: 33, atk0: 17, def0: 15, maximumLv: 99, exp: 0, recovery: 100)
    of "キラーマンティス":
      bms = BasicMonsterStatus(name: "キラーマンティス", growType: GrowType.BougyoSojuku, mhp0: 50, atk0: 16, def0: 18, maximumLv: 99, exp: 0, recovery: 100)
    of "ぐんたいガニ":
      bms = BasicMonsterStatus(name: "ぐんたいガニ", growType: GrowType.BougyoSojuku, mhp0: 47, atk0: 23, def0: 19, maximumLv: 99, exp: 0, recovery: 100)
    of "ケダモン":
      bms = BasicMonsterStatus(name: "ケダモン", growType: GrowType.BougyoSojuku, mhp0: 33, atk0: 17, def0: 16, maximumLv: 99, exp: 0, recovery: 50)
    of "ゴースト":
      bms = BasicMonsterStatus(name: "ゴースト", growType: GrowType.BougyoSojuku, mhp0: 21, atk0: 9, def0: 10, maximumLv: 99, exp: 0, recovery: 50)
    of "さそりかまきり":
      bms = BasicMonsterStatus(name: "さそりかまきり", growType: GrowType.BougyoSojuku, mhp0: 15, atk0: 11, def0: 10, maximumLv: 99, exp: 0, recovery: 100)
    of "じごくのハサミ":
      bms = BasicMonsterStatus(name: "じごくのハサミ", growType: GrowType.BougyoSojuku, mhp0: 35, atk0: 17, def0: 18, maximumLv: 99, exp: 0, recovery: 100)
    of "しびれマイマイ":
      bms = BasicMonsterStatus(name: "しびれマイマイ", growType: GrowType.BougyoSojuku, mhp0: 28, atk0: 14, def0: 18, maximumLv: 99, exp: 0, recovery: 50)
    of "ストローマウス":
      bms = BasicMonsterStatus(name: "ストローマウス", growType: GrowType.BougyoSojuku, mhp0: 19, atk0: 12, def0: 13, maximumLv: 99, exp: 0, recovery: 50)
    of "スライムブレス":
      bms = BasicMonsterStatus(name: "スライムブレス", growType: GrowType.BougyoSojuku, mhp0: 34, atk0: 14, def0: 12, maximumLv: 99, exp: 0, recovery: 50)
    of "タッフペンギー":
      bms = BasicMonsterStatus(name: "タッフペンギー", growType: GrowType.BougyoSojuku, mhp0: 31, atk0: 13, def0: 15, maximumLv: 99, exp: 0, recovery: 50)
    of "タマゴロン":
      bms = BasicMonsterStatus(name: "タマゴロン", growType: GrowType.BougyoSojuku, mhp0: 6, atk0: 10, def0: 3, maximumLv: 99, exp: 0, recovery: 50)
    of "ちゅうまじゅう":
      bms = BasicMonsterStatus(name: "ちゅうまじゅう", growType: GrowType.BougyoSojuku, mhp0: 25, atk0: 11, def0: 11, maximumLv: 99, exp: 0, recovery: 50)
    of "つかいま":
      bms = BasicMonsterStatus(name: "つかいま", growType: GrowType.BougyoSojuku, mhp0: 125, atk0: 40, def0: 35, maximumLv: 99, exp: 0, recovery: 50)
    of "つのうしがい":
      bms = BasicMonsterStatus(name: "つのうしがい", growType: GrowType.BougyoSojuku, mhp0: 23, atk0: 13, def0: 14, maximumLv: 99, exp: 0, recovery: 50)
    of "ドラゴスライム":
      bms = BasicMonsterStatus(name: "ドラゴスライム", growType: GrowType.BougyoSojuku, mhp0: 37, atk0: 19, def0: 18, maximumLv: 99, exp: 0, recovery: 150)
    of "ドラゴメタル":
      bms = BasicMonsterStatus(name: "ドラゴメタル", growType: GrowType.BougyoSojuku, mhp0: 50, atk0: 25, def0: 50, maximumLv: 99, exp: 0, recovery: 50)
    of "ドルイド":
      bms = BasicMonsterStatus(name: "ドルイド", growType: GrowType.BougyoSojuku, mhp0: 20, atk0: 10, def0: 6, maximumLv: 99, exp: 0, recovery: 50)
    of "どろにんぎょう":
      bms = BasicMonsterStatus(name: "どろにんぎょう", growType: GrowType.BougyoSojuku, mhp0: 35, atk0: 20, def0: 10, maximumLv: 99, exp: 0, recovery: 50)
    of "バブルスライム":
      bms = BasicMonsterStatus(name: "バブルスライム", growType: GrowType.BougyoSojuku, mhp0: 21, atk0: 9, def0: 7, maximumLv: 5, exp: 0, recovery: 50)
    of "パペットマン":
      bms = BasicMonsterStatus(name: "パペットマン", growType: GrowType.BougyoSojuku, mhp0: 35, atk0: 16, def0: 10, maximumLv: 99, exp: 0, recovery: 50)
    of "ファーラット":
      bms = BasicMonsterStatus(name: "ファーラット", growType: GrowType.BougyoSojuku, mhp0: 21, atk0: 10, def0: 9, maximumLv: 99, exp: 0, recovery: 50)
    of "ベビーサタン":
      bms = BasicMonsterStatus(name: "ベビーサタン", growType: GrowType.BougyoSojuku, mhp0: 44, atk0: 10, def0: 15, maximumLv: 99, exp: 0, recovery: 50)
    of "ヘルゴースト":
      bms = BasicMonsterStatus(name: "ヘルゴースト", growType: GrowType.BougyoSojuku, mhp0: 46, atk0: 19, def0: 21, maximumLv: 99, exp: 0, recovery: 50)
    of "マージスター":
      bms = BasicMonsterStatus(name: "マージスター", growType: GrowType.BougyoSojuku, mhp0: 26, atk0: 15, def0: 13, maximumLv: 99, exp: 0, recovery: 50)
    of "ミニデーモン":
      bms = BasicMonsterStatus(name: "ミニデーモン", growType: GrowType.BougyoSojuku, mhp0: 49, atk0: 20, def0: 24, maximumLv: 99, exp: 0, recovery: 50)
    of "メイジキメラ":
      bms = BasicMonsterStatus(name: "メイジキメラ", growType: GrowType.BougyoSojuku, mhp0: 60, atk0: 27, def0: 20, maximumLv: 99, exp: 0, recovery: 50)
    of "メガザルロック":
      bms = BasicMonsterStatus(name: "メガザルロック", growType: GrowType.BougyoSojuku, mhp0: 35, atk0: 14, def0: 9, maximumLv: 99, exp: 0, recovery: 50)
    of "メダパニシックル":
      bms = BasicMonsterStatus(name: "メダパニシックル", growType: GrowType.BougyoSojuku, mhp0: 90, atk0: 19, def0: 25, maximumLv: 99, exp: 0, recovery: 100)
    of "メトロゴースト":
      bms = BasicMonsterStatus(name: "メトロゴースト", growType: GrowType.BougyoSojuku, mhp0: 41, atk0: 13, def0: 18, maximumLv: 99, exp: 0, recovery: 50)
    of "ランドアーマー":
      bms = BasicMonsterStatus(name: "ランドアーマー", growType: GrowType.BougyoSojuku, mhp0: 31, atk0: 20, def0: 35, maximumLv: 99, exp: 0, recovery: 50)
    of "リリパット":
      bms = BasicMonsterStatus(name: "リリパット", growType: GrowType.BougyoSojuku, mhp0: 40, atk0: 11, def0: 12, maximumLv: 99, exp: 0, recovery: 50)
    of "ワンダーエッグ":
      bms = BasicMonsterStatus(name: "ワンダーエッグ", growType: GrowType.BougyoSojuku, mhp0: 6, atk0: 10, def0: 3, maximumLv: 99, exp: 0, recovery: 50)
    of "アークデーモン":
      bms = BasicMonsterStatus(name: "アークデーモン", growType: GrowType.BannoBansei, mhp0: 60, atk0: 26, def0: 27, maximumLv: 99, exp: 0, recovery: 100)
    of "ギガンテス":
      bms = BasicMonsterStatus(name: "ギガンテス", growType: GrowType.BannoBansei, mhp0: 55, atk0: 22, def0: 22, maximumLv: 99, exp: 0, recovery: 50)
    of "キラースコップ":
      bms = BasicMonsterStatus(name: "キラースコップ", growType: GrowType.BannoBansei, mhp0: 22, atk0: 10, def0: 10, maximumLv: 99, exp: 0, recovery: 50)
    of "グレイトホーン":
      bms = BasicMonsterStatus(name: "グレイトホーン", growType: GrowType.BannoBansei, mhp0: 80, atk0: 28, def0: 29, maximumLv: 99, exp: 0, recovery: 100)
    of "ゴーレム":
      bms = BasicMonsterStatus(name: "ゴーレム", growType: GrowType.BannoBansei, mhp0: 50, atk0: 20, def0: 20, maximumLv: 99, exp: 0, recovery: 100)
    of "レノファイター":
      bms = BasicMonsterStatus(name: "レノファイター", growType: GrowType.BannoBansei, mhp0: 70, atk0: 21, def0: 27, maximumLv: 99, exp: 0, recovery: 100)
    of "あくましんかん":
      bms = BasicMonsterStatus(name: "あくましんかん", growType: GrowType.KogekiBansei, mhp0: 48, atk0: 22, def0: 15, maximumLv: 99, exp: 0, recovery: 50)
    of "うごくせきぞう":
      bms = BasicMonsterStatus(name: "うごくせきぞう", growType: GrowType.KogekiBansei, mhp0: 42, atk0: 20, def0: 22, maximumLv: 99, exp: 0, recovery: 100)
    of "キースドラゴン":
      bms = BasicMonsterStatus(name: "キースドラゴン", growType: GrowType.KogekiBansei, mhp0: 150, atk0: 50, def0: 40, maximumLv: 99, exp: 0, recovery: 100)
    of "グレイトマーマン":
      bms = BasicMonsterStatus(name: "グレイトマーマン", growType: GrowType.KogekiBansei, mhp0: 39, atk0: 20, def0: 18, maximumLv: 99, exp: 0, recovery: 50)
    of "じごくのつかい":
      bms = BasicMonsterStatus(name: "じごくのつかい", growType: GrowType.KogekiBansei, mhp0: 44, atk0: 22, def0: 17, maximumLv: 99, exp: 0, recovery: 50)
    of "スカイフロッグ":
      bms = BasicMonsterStatus(name: "スカイフロッグ", growType: GrowType.KogekiBansei, mhp0: 38, atk0: 9, def0: 10, maximumLv: 99, exp: 0, recovery: 50)
    of "ストーンマン":
      bms = BasicMonsterStatus(name: "ストーンマン", growType: GrowType.KogekiBansei, mhp0: 75, atk0: 25, def0: 29, maximumLv: 99, exp: 0, recovery: 100)
    of "ダースドラゴン":
      bms = BasicMonsterStatus(name: "ダースドラゴン", growType: GrowType.KogekiBansei, mhp0: 150, atk0: 50, def0: 55, maximumLv: 99, exp: 0, recovery: 100)
    of "デーモントード":
      bms = BasicMonsterStatus(name: "デーモントード", growType: GrowType.KogekiBansei, mhp0: 45, atk0: 21, def0: 19, maximumLv: 99, exp: 0, recovery: 50)
    of "ドラゴン":
      bms = BasicMonsterStatus(name: "ドラゴン", growType: GrowType.KogekiBansei, mhp0: 120, atk0: 40, def0: 36, maximumLv: 99, exp: 0, recovery: 100)
    of "バーサーカー":
      bms = BasicMonsterStatus(name: "バーサーカー", growType: GrowType.KogekiBansei, mhp0: 30, atk0: 12, def0: 12, maximumLv: 99, exp: 0, recovery: 50)
    of "ひとくいばこ":
      bms = BasicMonsterStatus(name: "ひとくいばこ", growType: GrowType.KogekiBansei, mhp0: 20, atk0: 40, def0: 10, maximumLv: 99, exp: 0, recovery: 50)
    of "ひょうがまじん":
      bms = BasicMonsterStatus(name: "ひょうがまじん", growType: GrowType.KogekiBansei, mhp0: 70, atk0: 30, def0: 20, maximumLv: 99, exp: 0, recovery: 100)
    of "ミミック":
      bms = BasicMonsterStatus(name: "ミミック", growType: GrowType.KogekiBansei, mhp0: 50, atk0: 10, def0: 15, maximumLv: 99, exp: 0, recovery: 50)
    of "ようがんまじん":
      bms = BasicMonsterStatus(name: "ようがんまじん", growType: GrowType.KogekiBansei, mhp0: 97, atk0: 31, def0: 36, maximumLv: 99, exp: 0, recovery: 100)
    of "アイアンアント":
      bms = BasicMonsterStatus(name: "アイアンアント", growType: GrowType.BougyoBansei, mhp0: 17, atk0: 13, def0: 20, maximumLv: 99, exp: 0, recovery: 50)
    of "イエティ":
      bms = BasicMonsterStatus(name: "イエティ", growType: GrowType.BougyoBansei, mhp0: 70, atk0: 15, def0: 5, maximumLv: 99, exp: 0, recovery: 150)
    of "いしにんぎょう":
      bms = BasicMonsterStatus(name: "いしにんぎょう", growType: GrowType.BougyoBansei, mhp0: 100, atk0: 45, def0: 45, maximumLv: 99, exp: 0, recovery: 50)
    of "おおきづち":
      bms = BasicMonsterStatus(name: "おおきづち", growType: GrowType.BougyoBansei, mhp0: 15, atk0: 10, def0: 8, maximumLv: 5, exp: 0, recovery: 50)
    of "おおめだま":
      bms = BasicMonsterStatus(name: "おおめだま", growType: GrowType.BougyoBansei, mhp0: 55, atk0: 22, def0: 22, maximumLv: 99, exp: 0, recovery: 50)
    of "おばけキノコ":
      bms = BasicMonsterStatus(name: "おばけキノコ", growType: GrowType.BougyoBansei, mhp0: 38, atk0: 20, def0: 12, maximumLv: 99, exp: 0, recovery: 50)
    of "おばけヒトデ":
      bms = BasicMonsterStatus(name: "おばけヒトデ", growType: GrowType.BougyoBansei, mhp0: 22, atk0: 12, def0: 12, maximumLv: 5, exp: 0, recovery: 50)
    of "ガーゴイル":
      bms = BasicMonsterStatus(name: "ガーゴイル", growType: GrowType.BougyoBansei, mhp0: 200, atk0: 180, def0: 150, maximumLv: 99, exp: 0, recovery: 100)
    of "きとうし":
      bms = BasicMonsterStatus(name: "きとうし", growType: GrowType.BougyoBansei, mhp0: 39, atk0: 8, def0: 10, maximumLv: 99, exp: 0, recovery: 50)
    of "きめんどうし":
      bms = BasicMonsterStatus(name: "きめんどうし", growType: GrowType.BougyoBansei, mhp0: 18, atk0: 9, def0: 8, maximumLv: 99, exp: 0, recovery: 50)
    of "キラーアーマー":
      bms = BasicMonsterStatus(name: "キラーアーマー", growType: GrowType.BougyoBansei, mhp0: 55, atk0: 25, def0: 26, maximumLv: 99, exp: 0, recovery: 100)
    of "キラープラスター":
      bms = BasicMonsterStatus(name: "キラープラスター", growType: GrowType.BougyoBansei, mhp0: 135, atk0: 55, def0: 52, maximumLv: 99, exp: 0, recovery: 100)
    of "キラーマシン":
      bms = BasicMonsterStatus(name: "キラーマシン", growType: GrowType.BougyoBansei, mhp0: 60, atk0: 20, def0: 25, maximumLv: 99, exp: 0, recovery: 100)
    of "ぐんたいアリ":
      bms = BasicMonsterStatus(name: "ぐんたいアリ", growType: GrowType.BougyoBansei, mhp0: 40, atk0: 8, def0: 11, maximumLv: 99, exp: 0, recovery: 50)
    of "げんじゅつし":
      bms = BasicMonsterStatus(name: "げんじゅつし", growType: GrowType.BougyoBansei, mhp0: 37, atk0: 18, def0: 16, maximumLv: 99, exp: 0, recovery: 50)
    of "コロヒーロー":
      bms = BasicMonsterStatus(name: "コロヒーロー", growType: GrowType.BougyoBansei, mhp0: 34, atk0: 9, def0: 14, maximumLv: 99, exp: 0, recovery: 50)
    of "コロファイター":
      bms = BasicMonsterStatus(name: "コロファイター", growType: GrowType.BougyoBansei, mhp0: 35, atk0: 10, def0: 15, maximumLv: 99, exp: 0, recovery: 50)
    of "コロプリースト":
      bms = BasicMonsterStatus(name: "コロプリースト", growType: GrowType.BougyoBansei, mhp0: 35, atk0: 11, def0: 14, maximumLv: 99, exp: 0, recovery: 50)
    of "コロマージ":
      bms = BasicMonsterStatus(name: "コロマージ", growType: GrowType.BougyoBansei, mhp0: 35, atk0: 10, def0: 16, maximumLv: 99, exp: 0, recovery: 50)
    of "さまようよろい":
      bms = BasicMonsterStatus(name: "さまようよろい", growType: GrowType.BougyoBansei, mhp0: 45, atk0: 21, def0: 23, maximumLv: 99, exp: 0, recovery: 100)
    of "じごくのよろい":
      bms = BasicMonsterStatus(name: "じごくのよろい", growType: GrowType.BougyoBansei, mhp0: 105, atk0: 45, def0: 47, maximumLv: 99, exp: 0, recovery: 100)
    of "しびれくらげ":
      bms = BasicMonsterStatus(name: "しびれくらげ", growType: GrowType.BougyoBansei, mhp0: 31, atk0: 10, def0: 12, maximumLv: 99, exp: 0, recovery: 50)
    of "シャーマン":
      bms = BasicMonsterStatus(name: "シャーマン", growType: GrowType.BougyoBansei, mhp0: 35, atk0: 20, def0: 17, maximumLv: 99, exp: 0, recovery: 50)
    of "シャドーナイト":
      bms = BasicMonsterStatus(name: "シャドーナイト", growType: GrowType.BougyoBansei, mhp0: 48, atk0: 19, def0: 14, maximumLv: 99, exp: 0, recovery: 50)
    of "シルバーデビル":
      bms = BasicMonsterStatus(name: "シルバーデビル", growType: GrowType.BougyoBansei, mhp0: 65, atk0: 20, def0: 20, maximumLv: 99, exp: 0, recovery: 100)
    of "スーパーテンツク":
      bms = BasicMonsterStatus(name: "スーパーテンツク", growType: GrowType.BougyoBansei, mhp0: 38, atk0: 22, def0: 20, maximumLv: 99, exp: 0, recovery: 50)
    of "スペクテット":
      bms = BasicMonsterStatus(name: "スペクテット", growType: GrowType.BougyoBansei, mhp0: 45, atk0: 10, def0: 15, maximumLv: 99, exp: 0, recovery: 50)
    of "ゾンビマスター":
      bms = BasicMonsterStatus(name: "ゾンビマスター", growType: GrowType.BougyoBansei, mhp0: 55, atk0: 23, def0: 18, maximumLv: 99, exp: 0, recovery: 50)
    of "だいまじん":
      bms = BasicMonsterStatus(name: "だいまじん", growType: GrowType.BougyoBansei, mhp0: 105, atk0: 34, def0: 30, maximumLv: 99, exp: 0, recovery: 100)
    of "だいまどう":
      bms = BasicMonsterStatus(name: "だいまどう", growType: GrowType.BougyoBansei, mhp0: 41, atk0: 17, def0: 17, maximumLv: 99, exp: 0, recovery: 50)
    of "ダンスキャロット":
      bms = BasicMonsterStatus(name: "ダンスキャロット", growType: GrowType.BougyoBansei, mhp0: 28, atk0: 18, def0: 13, maximumLv: 99, exp: 0, recovery: 50)
    of "デスマシーン":
      bms = BasicMonsterStatus(name: "デスマシーン", growType: GrowType.BougyoBansei, mhp0: 128, atk0: 65, def0: 53, maximumLv: 99, exp: 0, recovery: 100)
    of "デビルロード":
      bms = BasicMonsterStatus(name: "デビルロード", growType: GrowType.BougyoBansei, mhp0: 120, atk0: 25, def0: 35, maximumLv: 99, exp: 0, recovery: 100)
    of "テンツク":
      bms = BasicMonsterStatus(name: "テンツク", growType: GrowType.BougyoBansei, mhp0: 35, atk0: 17, def0: 19, maximumLv: 99, exp: 0, recovery: 50)
    of "どぐう戦士":
      bms = BasicMonsterStatus(name: "どぐう戦士", growType: GrowType.BougyoBansei, mhp0: 120, atk0: 39, def0: 50, maximumLv: 99, exp: 0, recovery: 100)
    of "どくやずきん":
      bms = BasicMonsterStatus(name: "どくやずきん", growType: GrowType.BougyoBansei, mhp0: 50, atk0: 15, def0: 18, maximumLv: 99, exp: 0, recovery: 50)
    of "ドッグスナイパー":
      bms = BasicMonsterStatus(name: "ドッグスナイパー", growType: GrowType.BougyoBansei, mhp0: 50, atk0: 15, def0: 15, maximumLv: 99, exp: 0, recovery: 100)
    of "ドラゴンキッズ":
      bms = BasicMonsterStatus(name: "ドラゴンキッズ", growType: GrowType.BougyoBansei, mhp0: 55, atk0: 18, def0: 18, maximumLv: 99, exp: 0, recovery: 50)
    of "ばくだん岩":
      bms = BasicMonsterStatus(name: "ばくだん岩", growType: GrowType.BougyoBansei, mhp0: 100, atk0: 15, def0: 5, maximumLv: 99, exp: 0, recovery: 50)
    of "バズズ":
      bms = BasicMonsterStatus(name: "バズズ", growType: GrowType.BougyoBansei, mhp0: 135, atk0: 30, def0: 45, maximumLv: 99, exp: 0, recovery: 100)
    of "はねせんにん":
      bms = BasicMonsterStatus(name: "はねせんにん", growType: GrowType.BougyoBansei, mhp0: 17, atk0: 9, def0: 13, maximumLv: 99, exp: 0, recovery: 50)
    of "ビッグスロース":
      bms = BasicMonsterStatus(name: "ビッグスロース", growType: GrowType.BougyoBansei, mhp0: 55, atk0: 8, def0: 5, maximumLv: 99, exp: 0, recovery: 150)
    of "プチヒーロー":
      bms = BasicMonsterStatus(name: "プチヒーロー", growType: GrowType.BougyoBansei, mhp0: 35, atk0: 10, def0: 15, maximumLv: 99, exp: 0, recovery: 50)
    of "プチファイター":
      bms = BasicMonsterStatus(name: "プチファイター", growType: GrowType.BougyoBansei, mhp0: 35, atk0: 11, def0: 14, maximumLv: 99, exp: 0, recovery: 50)
    of "プチプリースト":
      bms = BasicMonsterStatus(name: "プチプリースト", growType: GrowType.BougyoBansei, mhp0: 33, atk0: 10, def0: 14, maximumLv: 99, exp: 0, recovery: 50)
    of "プチマージ":
      bms = BasicMonsterStatus(name: "プチマージ", growType: GrowType.BougyoBansei, mhp0: 20, atk0: 8, def0: 10, maximumLv: 99, exp: 0, recovery: 50)
    of "フライングデビル":
      bms = BasicMonsterStatus(name: "フライングデビル", growType: GrowType.BougyoBansei, mhp0: 130, atk0: 40, def0: 40, maximumLv: 99, exp: 0, recovery: 100)
    of "ベビーニュート":
      bms = BasicMonsterStatus(name: "ベビーニュート", growType: GrowType.BougyoBansei, mhp0: 20, atk0: 13, def0: 14, maximumLv: 99, exp: 0, recovery: 50)
    of "ベホマスライム":
      bms = BasicMonsterStatus(name: "ベホマスライム", growType: GrowType.BougyoBansei, mhp0: 35, atk0: 20, def0: 10, maximumLv: 99, exp: 0, recovery: 50)
    of "マージマタンゴ":
      bms = BasicMonsterStatus(name: "マージマタンゴ", growType: GrowType.BougyoBansei, mhp0: 110, atk0: 40, def0: 40, maximumLv: 99, exp: 0, recovery: 50)
    of "マタンゴ":
      bms = BasicMonsterStatus(name: "マタンゴ", growType: GrowType.BougyoBansei, mhp0: 51, atk0: 22, def0: 21, maximumLv: 99, exp: 0, recovery: 50)
    of "まどうし":
      bms = BasicMonsterStatus(name: "まどうし", growType: GrowType.BougyoBansei, mhp0: 35, atk0: 14, def0: 13, maximumLv: 99, exp: 0, recovery: 50)
    of "マンドラゴラ":
      bms = BasicMonsterStatus(name: "マンドラゴラ", growType: GrowType.BougyoBansei, mhp0: 75, atk0: 25, def0: 28, maximumLv: 99, exp: 0, recovery: 50)
    of "ミステリドール":
      bms = BasicMonsterStatus(name: "ミステリドール", growType: GrowType.BougyoBansei, mhp0: 60, atk0: 23, def0: 17, maximumLv: 99, exp: 0, recovery: 50)
    of "メタルハンター":
      bms = BasicMonsterStatus(name: "メタルハンター", growType: GrowType.BougyoBansei, mhp0: 130, atk0: 40, def0: 45, maximumLv: 99, exp: 0, recovery: 100)
    of "メラリザード":
      bms = BasicMonsterStatus(name: "メラリザード", growType: GrowType.BougyoBansei, mhp0: 90, atk0: 29, def0: 27, maximumLv: 99, exp: 0, recovery: 50)
    of "モシャスナイト":
      bms = BasicMonsterStatus(name: "モシャスナイト", growType: GrowType.BougyoBansei, mhp0: 51, atk0: 20, def0: 22, maximumLv: 99, exp: 0, recovery: 50)
    of "ようじゅつし":
      bms = BasicMonsterStatus(name: "ようじゅつし", growType: GrowType.BougyoBansei, mhp0: 34, atk0: 12, def0: 15, maximumLv: 99, exp: 0, recovery: 50)
    of "ラストテンツク":
      bms = BasicMonsterStatus(name: "ラストテンツク", growType: GrowType.BougyoBansei, mhp0: 95, atk0: 28, def0: 26, maximumLv: 99, exp: 0, recovery: 50)
    of "ラリホーアント":
      bms = BasicMonsterStatus(name: "ラリホーアント", growType: GrowType.BougyoBansei, mhp0: 25, atk0: 11, def0: 10, maximumLv: 99, exp: 0, recovery: 50)
    of "ランガー":
      bms = BasicMonsterStatus(name: "ランガー", growType: GrowType.BougyoBansei, mhp0: 140, atk0: 51, def0: 45, maximumLv: 99, exp: 0, recovery: 100)
    of "アトラス":
      bms = BasicMonsterStatus(name: "アトラス", growType: GrowType.KogekiTokusyu, mhp0: 130, atk0: 60, def0: 48, maximumLv: 10, exp: 0, recovery: 100)
    of "エビルエスターク":
      bms = BasicMonsterStatus(name: "エビルエスターク", growType: GrowType.KogekiTokusyu, mhp0: 145, atk0: 60, def0: 55, maximumLv: 10, exp: 0, recovery: 100)
    of "キングスライム":
      bms = BasicMonsterStatus(name: "キングスライム", growType: GrowType.KogekiTokusyu, mhp0: 100, atk0: 50, def0: 50, maximumLv: 10, exp: 0, recovery: 100)
    of "こうてつまじん":
      bms = BasicMonsterStatus(name: "こうてつまじん", growType: GrowType.KogekiTokusyu, mhp0: 135, atk0: 60, def0: 55, maximumLv: 10, exp: 0, recovery: 100)
    of "ゴールデンスライム":
      bms = BasicMonsterStatus(name: "ゴールデンスライム", growType: GrowType.KogekiTokusyu, mhp0: 132, atk0: 50, def0: 50, maximumLv: 10, exp: 0, recovery: 50)
    of "ゴールドマン":
      bms = BasicMonsterStatus(name: "ゴールドマン", growType: GrowType.KogekiTokusyu, mhp0: 131, atk0: 51, def0: 55, maximumLv: 99, exp: 0, recovery: 100)
    of "ジャスティス兄":
      bms = BasicMonsterStatus(name: "ジャスティス兄", growType: GrowType.KogekiTokusyu, mhp0: 150, atk0: 80, def0: 80, maximumLv: 99, exp: 0, recovery: 150)
    of "スライムエンペラー":
      bms = BasicMonsterStatus(name: "スライムエンペラー", growType: GrowType.KogekiTokusyu, mhp0: 133, atk0: 51, def0: 51, maximumLv: 10, exp: 0, recovery: 100)
    of "トロルキング":
      bms = BasicMonsterStatus(name: "トロルキング", growType: GrowType.KogekiTokusyu, mhp0: 131, atk0: 66, def0: 53, maximumLv: 99, exp: 0, recovery: 100)
    of "ベリアル":
      bms = BasicMonsterStatus(name: "ベリアル", growType: GrowType.KogekiTokusyu, mhp0: 135, atk0: 65, def0: 55, maximumLv: 10, exp: 0, recovery: 100)
    of "あやしいかげ":
      bms = BasicMonsterStatus(name: "あやしいかげ", growType: GrowType.SyubiTokusyu, mhp0: 5, atk0: 20, def0: 1, maximumLv: 9, exp: 0, recovery: 50)
    of "オニオーン":
      bms = BasicMonsterStatus(name: "オニオーン", growType: GrowType.SyubiTokusyu, mhp0: 10, atk0: 1, def0: 1, maximumLv: 99, exp: 0, recovery: 50)
    of "サンダーラット":
      bms = BasicMonsterStatus(name: "サンダーラット", growType: GrowType.SyubiTokusyu, mhp0: 6, atk0: 12, def0: 4, maximumLv: 9, exp: 0, recovery: 150)
    of "シャドー":
      bms = BasicMonsterStatus(name: "シャドー", growType: GrowType.SyubiTokusyu, mhp0: 5, atk0: 13, def0: 1, maximumLv: 9, exp: 0, recovery: 50)
    of "たまねぎマン":
      bms = BasicMonsterStatus(name: "たまねぎマン", growType: GrowType.SyubiTokusyu, mhp0: 10, atk0: 1, def0: 100, maximumLv: 99, exp: 0, recovery: 50)
    of "はぐれメタル":
      bms = BasicMonsterStatus(name: "はぐれメタル", growType: GrowType.SyubiTokusyu, mhp0: 5, atk0: 10, def0: 200, maximumLv: 99, exp: 0, recovery: 50)
    of "バブリン":
      bms = BasicMonsterStatus(name: "バブリン", growType: GrowType.SyubiTokusyu, mhp0: 100, atk0: 35, def0: 15, maximumLv: 99, exp: 0, recovery: 100)
    of "はりせんもぐら":
      bms = BasicMonsterStatus(name: "はりせんもぐら", growType: GrowType.SyubiTokusyu, mhp0: 4, atk0: 7, def0: 4, maximumLv: 9, exp: 0, recovery: 50)
    of "プヨンターゲット":
      bms = BasicMonsterStatus(name: "プヨンターゲット", growType: GrowType.SyubiTokusyu, mhp0: 150, atk0: 45, def0: 20, maximumLv: 99, exp: 0, recovery: 100)
    of "プラズママウス":
      bms = BasicMonsterStatus(name: "プラズママウス", growType: GrowType.SyubiTokusyu, mhp0: 6, atk0: 40, def0: 4, maximumLv: 9, exp: 0, recovery: 150)
    of "ブラッドハンド":
      bms = BasicMonsterStatus(name: "ブラッドハンド", growType: GrowType.SyubiTokusyu, mhp0: 26, atk0: 17, def0: 15, maximumLv: 99, exp: 0, recovery: 50)
    of "ポムポムボム":
      bms = BasicMonsterStatus(name: "ポムポムボム", growType: GrowType.SyubiTokusyu, mhp0: 200, atk0: 55, def0: 29, maximumLv: 99, exp: 0, recovery: 100)
    of "マドハンド":
      bms = BasicMonsterStatus(name: "マドハンド", growType: GrowType.SyubiTokusyu, mhp0: 10, atk0: 6, def0: 5, maximumLv: 99, exp: 0, recovery: 30)
    of "メタルキング":
      bms = BasicMonsterStatus(name: "メタルキング", growType: GrowType.SyubiTokusyu, mhp0: 50, atk0: 10, def0: 100, maximumLv: 99, exp: 0, recovery: 100)
    of "メタルスライム":
      bms = BasicMonsterStatus(name: "メタルスライム", growType: GrowType.SyubiTokusyu, mhp0: 6, atk0: 10, def0: 100, maximumLv: 99, exp: 0, recovery: 50)
    of "笑いぶくろ":
      bms = BasicMonsterStatus(name: "笑いぶくろ", growType: GrowType.SyubiTokusyu, mhp0: 35, atk0: 0, def0: 5, maximumLv: 99, exp: 0, recovery: 50)
    else:
      raise newException(SCSError, "invalid name given")

  bms.exp = getEXP(bms.growType, lv)
  bms.mhp0 += getMHPGrow(bms.growType, lv)
  bms.atk0 += getATKGrow(bms.growType, lv)
  bms.def0 += getDEFGrow(bms.growType, lv)

  return bms


proc getLvByDexp* (name: string, startLv: int, dexp: int): int =
  let bms0 = getBasicMonsterStatus(name, startLv)
  for lv in countup(startLv+1, 99):
    let bms1 = getBasicMonsterStatus(name, lv)
    if bms1.exp - bms0.exp > dexp:
      return lv-1
  raise newException(SCSError, "invalid input for getLvByDexp")
