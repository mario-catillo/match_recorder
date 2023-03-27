import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/widgets/descriptors/progression_descriptor.dart';

class TackleEvent extends BaseEvent {
  TackleEvent({required String time}) : super(name: 'Tackle', time: time);
  MovementProgression progress = MovementProgression.neutral;
  Player? tacklePlayer1;
  Player? tacklePlayer2;

  @override
  String getEventName() => 'Tackle';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.movementProgression];
  }

  @override
  T getDescriptorValue<T>() {
    if (T == MovementProgression) {
      return progress as T;
    }
    throw UnimplementedError();
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == MovementProgression) {
      progress = value as MovementProgression;
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