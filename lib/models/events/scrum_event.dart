import 'package:match_recorder/enums/descriptors.dart';
import 'package:match_recorder/models/events/base_event.dart';
import 'package:match_recorder/models/player.dart';
// import 'package:match_recorder/team_page.dart';

class ScrumEvent extends BaseEvent {
  // TeamType winnerTeam;
  MovementProgression progress = MovementProgression.negative;
  Result result = Result.won;
  ScrumEvent({
    required Duration duration,
  }) : super(name: 'Scrum', duration: duration);

  @override
  String getEventName() => 'Scrum';

  @override
  List<Descriptors> getDescriptors() {
    return [Descriptors.movementProgression, Descriptors.result];
  }

  @override
  T? getDescriptorValue<T>() {
    if (T == MovementProgression) {
      return progress as T;
    }
    if (T == Result) {
      return result as T;
    }
    return null;
  }

  @override
  setDescriptorValue<T>(T value) {
    if (T == MovementProgression) {
      progress = value as MovementProgression;
    }
    if (T == Result) {
      result = value as Result;
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

  ScrumEvent.fromJson(String json) : super.fromJson(json);
}
