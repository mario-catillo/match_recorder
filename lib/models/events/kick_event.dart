import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';

class KickEvent extends BaseEvent {
  KickEvent({required Duration duration})
      : super(name: 'Kick', duration: duration);
  KickType kickType = KickType.upAndUnder;
  Player? kicker;
  @override
  String getEventName() => 'Kick';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.kickType];
  }

  @override
  T getDescriptorValue<T>() {
    if (T == KickType) {
      return kickType as T;
    }
    throw UnimplementedError();
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == KickType) {
      kickType = value as KickType;
    }
  }

  @override
  Map<String, Player?> getPlayers() {
    return {'kicker': kicker};
  }

  @override
  void setPlayer(String key, Player? player) {
    if (key == 'kicker') {
      kicker = player;
    }
  }

  @override
  Player? getPlayer(String key) {
    if (key == 'kicker') {
      return kicker;
    }
    return null;
  }
}
