import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';

class InfractionEvent extends BaseEvent {
  Infraction infraction = Infraction.dirtyPlay;
  InfractionEvent({required String time})
      : super(name: 'Infraction', time: time);
  Player? infractionPlayer;

  @override
  String getEventName() => 'Infraction';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.infraction];
  }

  @override
  T getDescriptorValue<T>() {
    if (T == Infraction) {
      return infraction as T;
    }
    throw UnimplementedError();
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == Infraction) {
      infraction = value as Infraction;
    }
  }

  @override
  Map<String, Player?> getPlayers() {
    return {'infractionPlayer': infractionPlayer};
  }

  @override
  void setPlayer(String key, Player? value) {
    if (key == 'infractionPlayer') {
      infractionPlayer = value;
    }
  }

  @override
  Player? getPlayer(String key) {
    if (key == 'infractionPlayer') {
      return infractionPlayer;
    }
    return null;
  }
}
