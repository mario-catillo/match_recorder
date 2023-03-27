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
  tackleShoulder
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

enum Conversion { converted, failed }

enum LineResult { clean, dirty, notStraight, lost }

enum Turnover { knockOn, jackal, robbed, touch, blocked, kick }

enum Result { won, lost }

enum LineQuantity { two, three, four, five, six, seven, other }

enum Points { try7, conversion, penalty, drop, penaltyTry }

enum LinePosition { A, B, C, D, E, other }

enum TackleShoulder { internal, external, double }
