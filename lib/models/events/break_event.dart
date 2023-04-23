import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';

class BreakEnEvent extends BaseEvent {
  BreakType breaktype = BreakType.individual;
  BreakEnEvent({required Duration duration})
      : super(name: 'Break', duration: duration);
  Player? breakPlayer;

  @override
  String getEventName() => 'Break';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.breakType];
  }

  @override
  T? getDescriptorValue<T>() {
    if (T == BreakType) {
      return breaktype as T;
    }
    return null;
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == BreakType) {
      breaktype = value as BreakType;
    }
  }

  @override
  Map<String, Player?> getPlayers() {
    return {'breakPlayer': breakPlayer};
  }

  @override
  void setPlayer(String key, Player? value) {
    if (key == 'breakPlayer') {
      breakPlayer = value;
    }
  }

  @override
  Player? getPlayer(String key) {
    if (key == 'breakPlayer') {
      return breakPlayer;
    }
    return null;
  }
}
