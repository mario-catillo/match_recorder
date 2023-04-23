enum Descriptors {
  movementProgression,
  infraction,
  speed,
  kickType,
  breakType,
  goalKick,
  lineResult,
  turnover,
  result,
  lineQuantity,
  points,
  linePosition,
  tackleShoulder,
  cardStatus,
  restartType
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

enum KickType {
  upAndUnder,
  box,
  crossed,
  punt,
  drop,
  grubber,
  chip,
  touche,
  goal
}

enum BreakType { individual, sequence, numbers, kick }

enum GoalKick { good, failed, none }
//manca evento

enum LineResult { clean, dirty, notStraight, lost }

enum Turnover { knockOn, jackal, robbed, touch, blocked, kick }

enum Result { won, lost }

enum LineQuantity { two, three, four, five, six, seven, other }

enum Points { try5, conversion2, penalty3, drop3, penaltyTry7 }

enum LinePosition { A, B, C, D, E, other }

enum TackleShoulder { internal, external, double }

enum CardStatus { yellow, red, none }

enum PlayStatus { attack, defense, none }

enum RestartType { kickoff, drop22, dropingoal }
