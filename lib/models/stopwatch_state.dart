import 'package:flutter/foundation.dart';

class StopwatchState extends ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  final ValueNotifier<String> currentTime = ValueNotifier("00:00:00");

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
    currentTime.value = "00:00:00";
    notifyListeners();
  }

  void _updateTime() async {
    while (_stopwatch.isRunning) {
      await Future.delayed(const Duration(milliseconds: 10));
      final duration = _stopwatch.elapsed;
      currentTime.value = "${duration.inMinutes.toString().padLeft(2, '0')}:"
          "${(duration.inSeconds % 60).toString().padLeft(2, '0')}:"
          "${(duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0')}";
    }
  }

  @override
  void dispose() {
    currentTime.dispose();
    super.dispose();
  }
}
