import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';

class TurnoverEvent extends BaseEvent {
  Turnover turnover = Turnover.knockOn;
  TurnoverEvent({required Duration duration})
      : super(name: 'Turnover (lost)', duration: duration);
  Player? turnoverPlayer;

  @override
  String getEventName() => 'Turnover (lost)';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.turnover];
  }

  @override
  T? getDescriptorValue<T>() {
    if (T == Turnover) {
      return turnover as T;
    }
    return null;
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == Turnover) {
      turnover = value as Turnover;
    }
  }

  @override
  Map<String, Player?> getPlayers() {
    return {'turnoverPlayer': turnoverPlayer};
  }

  @override
  void setPlayer(String key, Player? value) {
    if (key == 'turnoverPlayer') {
      turnoverPlayer = value;
    }
  }

  @override
  Player? getPlayer(String key) {
    if (key == 'turnoverPlayer') {
      return turnoverPlayer;
    }
    return null;
  }

  TurnoverEvent.fromJson(String json) : super.fromJson(json);
}
