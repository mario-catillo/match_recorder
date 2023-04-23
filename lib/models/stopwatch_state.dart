import 'package:flutter/foundation.dart';

enum GameStatus { defense, attack, nullTime }

class StopwatchState extends ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  final ValueNotifier<Duration> currentDuration = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> defenseTime = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> attackTime = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> nullTime = ValueNotifier(Duration.zero);
  GameStatus gameStatus = GameStatus.defense;

  void setDefenseTime() {
    gameStatus = GameStatus.defense;
    notifyListeners();
  }

  void setAttackTime() {
    gameStatus = GameStatus.attack;
    notifyListeners();
  }

  void setNullTime() {
    gameStatus = GameStatus.nullTime;
    notifyListeners();
  }

  void resetGameTypeTime() {
    defenseTime.value = Duration.zero;
    attackTime.value = Duration.zero;
    nullTime.value = Duration.zero;
    notifyListeners();
  }

  void start() {
    _stopwatch.start();
    _updateTime();
    notifyListeners();
  }

  bool isRunning() => _stopwatch.isRunning;

  void stop() {
    _stopwatch.stop();
    notifyListeners();
  }

  void reset() {
    _stopwatch.reset();
    currentDuration.value = Duration.zero;
    resetGameTypeTime();
    notifyListeners();
  }

  void _updateTime() async {
    while (_stopwatch.isRunning) {
      await Future.delayed(const Duration(milliseconds: 10));
      final duration = _stopwatch.elapsed;
      currentDuration.value = duration;
      attackTime.value += gameStatus == GameStatus.attack
          ? duration - attackTime.value - defenseTime.value - nullTime.value
          : Duration.zero;
      defenseTime.value += gameStatus == GameStatus.defense
          ? duration - attackTime.value - defenseTime.value - nullTime.value
          : Duration.zero;

      nullTime.value += gameStatus == GameStatus.nullTime
          ? duration - attackTime.value - defenseTime.value - nullTime.value
          : Duration.zero;
    }
  }

  @override
  void dispose() {
    currentDuration.dispose();
    super.dispose();
  }
}
