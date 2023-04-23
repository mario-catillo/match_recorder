import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/widgets/descriptors/progression_descriptor.dart';

class TackleEvent extends BaseEvent {
  TackleEvent({required Duration duration})
      : super(name: 'Tackle', duration: duration);
  MovementProgression progress = MovementProgression.neutral;
  Player? tacklePlayer1;
  Player? tacklePlayer2;
  TackleShoulder tackleShoulder = TackleShoulder.external;

  @override
  String getEventName() => 'Tackle';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.movementProgression, Descriptors.tackleShoulder];
  }

  @override
  T? getDescriptorValue<T>() {
    if (T == MovementProgression) {
      return progress as T;
    }
    if (T == TackleShoulder) {
      return tackleShoulder as T;
    }
    return null;
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == MovementProgression) {
      progress = value as MovementProgression;
    }
    if (T == TackleShoulder) {
      tackleShoulder = value as TackleShoulder;
    }
  }

  @override
  Map<String, Player?> getPlayers() {
    return {'tacklePlayer1': tacklePlayer1, 'tacklePlayer2': tacklePlayer2};
  }

  @override
  void setPlayer(String key, Player? value) {
    if (key == 'tacklePlayer1') {
      tacklePlayer1 = value;
    }
    if (key == 'tacklePlayer2') {
      tacklePlayer2 = value;
    }
  }

  @override
  Player? getPlayer(String key) {
    if (key == 'tacklePlayer1') {
      return tacklePlayer1;
    }
    if (key == 'tacklePlayer2') {
      return tacklePlayer2;
    }
    throw UnimplementedError();
  }
}
//Time;Team;Player;Shoulder;Progress