import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';

class MissedTacklenEvent extends BaseEvent {
  MissedTacklenEvent({required Duration duration})
      : super(name: 'MissedTackle', duration: duration);
  Player? missedTacklePlayer;

  @override
  String getEventName() => 'MissedTackle';

  @override
  List<Descriptors> getDescriptors() {
    return [];
  }

  @override
  T? getDescriptorValue<T>() {
    // if (T == MissedTackle) {
    //   return missedTackle as T;
    // }
    return null;
  }

  @override
  setDescriptorValue<T>(T value) {
    // if (T == Turnover) {
    //   turnover = value as Turnover;
    // }
  }

  @override
  Map<String, Player?> getPlayers() {
    return {'missedTacklePlayer': missedTacklePlayer};
  }

  @override
  void setPlayer(String key, Player? value) {
    if (key == 'missedTacklePlayer') {
      missedTacklePlayer = value;
    }
  }

  @override
  Player? getPlayer(String key) {
    if (key == 'missedTacklePlayer') {
      return missedTacklePlayer;
    }
    return null;
  }
}
