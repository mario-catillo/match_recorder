import 'package:flutter/foundation.dart';

class StopwatchState extends ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  final ValueNotifier<Duration> currentDuration = ValueNotifier(Duration.zero);

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
    notifyListeners();
  }

  void _updateTime() async {
    while (_stopwatch.isRunning) {
      await Future.delayed(const Duration(milliseconds: 10));
      final duration = _stopwatch.elapsed;
      currentDuration.value = duration;
    }
  }

  @override
  void dispose() {
    currentDuration.dispose();
    super.dispose();
  }
}
