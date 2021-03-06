# custom_types.nim

type SCSError* = object of Exception

type Place* = ref object
  row*: int
  col*: int

proc addPlace* (p1: Place, p2: Place): Place =
  Place(row: p1.row+p2.row, col: p1.col+p2.col)

type
  Hoimin = ref object    # ホイミスライム
    skill*: float          # 特技使用率
    attack*: float         # ホイミスライムの非封印時攻撃確率
    move*: float           # ホイミスライムの移動確率
    moveTurn*: int         # ホイミスライムの移動開始ターン
  ProbabilityConfig* = object
    attack*: float         # 通常攻撃があたる確率
    divide*: float         # スモールグールの分裂確率
    hoimin*: Hoimin

proc defaultProbabilityConfig* (): ProbabilityConfig =
  ProbabilityConfig(
    attack: 0.92,
    divide: 0.25,
    hoimin: Hoimin(
      skill: 0.3413,
      attack: 0.3,
      move: 1.0,
      moveTurn: 200
    )
  )
