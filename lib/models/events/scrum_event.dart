import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';
import 'package:match_recorder/team_page.dart';

class ScrumEvent extends BaseEvent {
  TeamType winnerTeam;
  MovementProgression progress = MovementProgression.negative;
  ScrumEvent({required String time, required this.winnerTeam})
      : super(name: 'Scrum', time: time);

  @override
  String getEventName() => 'Scrum';

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
    return {};
  }

  @override
  void setPlayer(String key, Player? value) {
    throw UnimplementedError();
  }

  @override
  Player? getPlayer(String key) {
    throw UnimplementedError();
  }
}
