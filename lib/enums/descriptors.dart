enum Descriptors {
  movementProgression,
  infraction,
  speed,
  kickType,
  breakType,
  conversion,
  lineResult,
  turnover,
  result,
  lineQuantity,
  points,
  linePosition,
  tackleShoulder,
  cardStatus
}

enum MovementProgression { positive, negative, neutral }

enum Infraction {
  dirtyPlay,
  ruckAttack,
  ruckDefence,
  offside,
  maul,
  scrum,
  lineout,
  tenMeters
}

enum Speed { slow, fast }

enum KickType { upAndUnder, box, crossKick, punt, drop, grubber, chip, touche }

enum BreakType { individual, sequence, numbers, kick }
//manca evento

enum Conversion { converted, failed }
//manca evento

enum LineResult { clean, dirty, notStraight, lost }

enum Turnover { knockOn, jackal, robbed, touch, blocked, kick }

enum Result { won, lost }

enum LineQuantity { two, three, four, five, six, seven, other }

enum Points { try5, conversion2, penalty3, drop3, penaltyTry7 }

enum LinePosition { A, B, C, D, E, other }

enum TackleShoulder { internal, external, double }

enum CardStatus { yellow, red, none }
