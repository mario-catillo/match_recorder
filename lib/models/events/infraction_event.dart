import 'dart:convert';

import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/team_page.dart';

class InfractionEvent extends BaseEvent {
  Infraction infraction = Infraction.dirtyPlay;
  CardStatus cardStatus = CardStatus.none;
  Player? infractionPlayer;
  InfractionEvent({required Duration duration})
      : super(name: 'Infraction', duration: duration);

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

  @override
  String toJson() {
    Map<String, dynamic> json = jsonDecode(super.toJson());
    json.addAll({
      'infraction': infraction.index,
      'cardStatus': cardStatus.index,
      'infractionPlayer': infractionPlayer?.toJson()
    });
    return jsonEncode(json);
  }

  @override
  InfractionEvent.fromJson(String json) : super.fromJson(json) {
    infraction = Infraction.values[jsonDecode(json)['infraction']];
    cardStatus = CardStatus.values[jsonDecode(json)['cardStatus']];
    infractionPlayer = Player.fromJson(jsonDecode(json)['infractionPlayer']);
  }
}
