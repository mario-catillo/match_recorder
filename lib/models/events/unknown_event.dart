import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';

class UnknownEvent extends BaseEvent {
  UnknownEvent({required Duration duration})
      : super(name: 'Unknown', duration: duration);
  @override
  String getEventName() => 'Unknown';

  @override
  List<Descriptors> getDescriptors() {
    return [];
  }

  @override
  T? getDescriptorValue<T>() {
    return null;
  }

  @override
  setDescriptorValue<T>(T value) {}

  @override
  Map<String, Player?> getPlayers() {
    return {};
  }

  @override
  void setPlayer(String key, Player? player) {}

  @override
  Player? getPlayer(String key) {
    return null;
  }

  @override
  UnknownEvent.fromJson(json) : super.fromJson(json);
}
