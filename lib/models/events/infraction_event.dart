import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';

class InfractionEvent extends BaseEvent {
  Infraction infraction = Infraction.dirtyPlay;
  CardStatus cardStatus = CardStatus.none;
  InfractionEvent({required Duration duration})
      : super(name: 'Infraction', duration: duration);
  Player? infractionPlayer;

  @override
  String getEventName() => 'Infraction';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.infraction, Descriptors.cardStatus];
  }

  @override
  T getDescriptorValue<T>() {
    if (T == Infraction) {
      return infraction as T;
    }
    if (T == CardStatus) {
      return cardStatus as T;
    }

    throw UnimplementedError();
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == Infraction) {
      infraction = value as Infraction;
    }
    if (T == CardStatus) {
      cardStatus = value as CardStatus;
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
